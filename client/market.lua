
-- Client market script

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('client:openMarket', function()
    local marketItems = {
        { name = 'apple', price = 3 },
        { name = 'banana', price = 2 }
    }
    TriggerEvent('client:openShop', marketItems)
end)
