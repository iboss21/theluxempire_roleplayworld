
-- Client activities script

local QBCore = exports['qb-core']:GetCoreObject()

-- Example activity: Gathering resources
RegisterNetEvent('client:startGathering', function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
    QBCore.Functions.Progressbar('gathering', 'Gathering resources...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(playerPed)
        TriggerServerEvent('server:giveGatheredItem')
    end)
end)
