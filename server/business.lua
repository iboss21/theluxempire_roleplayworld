
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('server:createBusiness', function(businessType)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local businessName = xPlayer.PlayerData.name .. "'s " .. businessType
    local business = {
        owner = xPlayer.PlayerData.citizenid,
        name = businessName,
        type = businessType,
        balance = 0,
        employees = {}
    }
    -- Add business to database
    MySQL.Async.execute('INSERT INTO businesses (owner, name, type, balance) VALUES (?, ?, ?, ?)', {business.owner, business.name, business.type, business.balance})
    TriggerClientEvent('QBCore:Notify', src, 'Business created: ' .. businessName, 'success')
end)
