
-- Server activities script

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('server:giveGatheredItem', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddItem('wood', 1)
    TriggerClientEvent('QBCore:Notify', src, 'You have gathered some wood.', 'success')
end)
