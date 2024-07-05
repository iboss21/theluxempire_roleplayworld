
local QBCore = exports['qb-core']:GetCoreObject()
local locales = QBCore.Shared._L

RegisterNetEvent('server:startCargoDelivery', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    -- Simulate cargo delivery process
    Wait(60000) -- 1 minute for delivery

    xPlayer.Functions.AddMoney('cash', 500)
    TriggerClientEvent('QBCore:Notify', src, locales('delivery_successful'), "success")
end)
