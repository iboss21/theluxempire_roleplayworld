local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

local activeEvents = {}

-- Local functions
local function StartEvent(eventName)
    if activeEvents[eventName] then return end

    local eventConfig = Config.Events[eventName]
    if not eventConfig then return end

    activeEvents[eventName] = {
        startTime = os.time(),
        endTime = os.time() + eventConfig.duration
    }

    TriggerClientEvent('theluxempire_roleplayworld:client:StartEvent', -1, eventName)

    SetTimeout(eventConfig.duration * 1000, function()
        EndEvent(eventName)
    end)
end

local function EndEvent(eventName)
    if not activeEvents[eventName] then return end

    activeEvents[eventName] = nil
    TriggerClientEvent('theluxempire_roleplayworld:client:EndEvent', -1, eventName)
end

-- Events
RegisterNetEvent('theluxempire_roleplayworld:server:RequestEventStatus', function()
    local src = source
    TriggerClientEvent('theluxempire_roleplayworld:client:SyncEventStatus', src, activeEvents)
end)

-- Start random events periodically
CreateThread(function()
    while true do
        Wait(3600000) -- Check every hour
        local eventNames = TLELib.GetTableKeys(Config.Events)
        local randomEvent = eventNames[math.random(#eventNames)]
        
        if not activeEvents[randomEvent] then
            local lastEventTime = TLE.GetLastEventTime(randomEvent)
            if os.time() - lastEventTime > Config.Events[randomEvent].cooldown then
                StartEvent(randomEvent)
            end
        end
    end
end)

-- Export functions
exports('IsEventActive', function(eventName)
    return activeEvents[eventName] ~= nil
end)

exports('GetActiveEvents', function()
    return activeEvents
end)
