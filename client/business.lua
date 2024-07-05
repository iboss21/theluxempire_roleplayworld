
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('client:startBusiness', function()
    local businessType = 'Shop'
    local playerMoney = QBCore.Functions.GetPlayerData().money['cash']

    if playerMoney >= 10000 then
        TriggerServerEvent('server:createBusiness', businessType)
        QBCore.Functions.Notify('Business started successfully', 'success')
    else
        QBCore.Functions.Notify('You need more money to start a business', 'error')
    end
end)
