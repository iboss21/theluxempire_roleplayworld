local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

local activeNodes = {}
local isPerformingAction = false

-- Local functions
local function SpawnResourceNodes(activityType, location)
    if activeNodes[activityType] then return end
    activeNodes[activityType] = {}

    local nodeCount = location.trees or location.nodes or 20
    for i = 1, nodeCount do
        local nodeCoords = TLELib.GetRandomPositionInCircle(location.coords, location.radius)
        local nodeData = {
            coords = nodeCoords,
            resourceLeft = 100,
        }
        table.insert(activeNodes[activityType], nodeData)
    end
end

local function RemoveResourceNodes(activityType)
    if not activeNodes[activityType] then return end
    -- Remove any created objects or markers here
    activeNodes[activityType] = nil
end

local function PerformActivityAction(activityType, nodeIndex)
    if isPerformingAction then return end
    isPerformingAction = true

    local activityConfig = Config.Activities[activityType]
    local tool = TLE.GetPlayerTool(activityType)
    if not tool then
        TLELib.Notify("You need a tool to perform this action!", "error")
        isPerformingAction = false
        return
    end

    local animDict, animName = TLE.GetActivityAnimation(activityType)
    TLELib.PlayAnimation(animDict, animName, -1)

    TLELib.ProgressBar("performing_activity", "Performing " .. activityType, 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TLELib.StopAnimation()
        isPerformingAction = false
        TriggerServerEvent('theluxempire_roleplayworld:server:ActivityActionPerformed', activityType, nodeIndex, tool)
    end, function() -- Cancel
        TLELib.StopAnimation()
        isPerformingAction = false
    end)
end

-- Events
RegisterNetEvent('theluxempire_roleplayworld:client:EnteredActivityZone', function(activityType, location)
    SpawnResourceNodes(activityType, location)
    TLELib.Notify("You've entered a " .. activityType .. " zone.", "info")
end)

RegisterNetEvent('theluxempire_roleplayworld:client:LeftActivityZone', function(activityType)
    RemoveResourceNodes(activityType)
    TLELib.Notify("You've left the " .. activityType .. " zone.", "info")
end)

RegisterNetEvent('theluxempire_roleplayworld:client:UpdateNodeResource', function(activityType, nodeIndex, newResourceAmount)
    if activeNodes[activityType] and activeNodes[activityType][nodeIndex] then
        activeNodes[activityType][nodeIndex].resourceLeft = newResourceAmount
    end
end)

-- Main thread for rendering nodes and handling interactions
CreateThread(function()
    while true do
        local wait = 1000
        if next(activeNodes) then
            wait = 0
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for activityType, nodes in pairs(activeNodes) do
                for i, node in ipairs(nodes) do
                    local distance = #(playerCoords - node.coords)
                    if distance < 10.0 then
                        TLELib.DrawMarker(1, node.coords.x, node.coords.y, node.coords.z - 1.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, nil, nil, false)
                        if distance < 1.5 then
                            TLELib.DrawText3D(node.coords.x, node.coords.y, node.coords.z, "Press [E] to gather")
                            if IsControlJustReleased(0, 38) then -- E key
                                PerformActivityAction(activityType, i)
                            end
                        end
                    end
                end
            end
        end
        Wait(wait)
    end
end)
