local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

local activeEvents = {}

-- Local functions
local function StartEvent(eventName)
    local eventConfig = Config.Events[eventName]
    if not eventConfig then return end

    activeEvents[eventName] = true
    TLELib.Notify("Event started: " .. eventName, "info")
    
    -- Apply event bonuses
    for skill, multiplier in pairs(eventConfig.bonus) do
        TLE.SetSkillMultiplier(skill, multiplier)
    end

    -- Set timer to end the event
    SetTimeout(eventConfig.duration * 1000, function()
        EndEvent(eventName)
    end)
end

local function EndEvent(eventName)
    if not activeEvents[eventName] then return end

    local eventConfig = Config.Events[eventName]
    activeEvents[eventName] = nil
    TLELib.Notify("Event ended: " .. eventName, "info")

    -- Remove event bonuses
    for skill, _ in pairs(eventConfig.bonus) do
        TLE.SetSkillMultiplier(skill, 1.0)
    end
end

-- Events
RegisterNetEvent('theluxempire_roleplayworld:client:StartEvent', function(eventName)
    StartEvent(eventName)
end)

RegisterNetEvent('theluxempire_roleplayworld:client:EndEvent', function(eventName)
    EndEvent(eventName)
end)

-- Main thread for rendering event effects (if any)
CreateThread(function()
    while true do
        Wait(1000)
        for eventName, isActive in pairs(activeEvents) do
            if isActive then
                -- Add any visual effects or UI updates for active events here
                -- For example, you could display a small icon or text on the screen
                TLELib.DrawText2D(0.5, 0.05, "Active Event: " .. eventName, 0.5)
            end
        end
    end
end)
