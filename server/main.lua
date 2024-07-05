
local QBCore = exports['qb-core']:GetCoreObject()
local InventorySystem

if Config.InventorySystem == 'tgiann-inventory' then
    InventorySystem = exports['tgiann-inventory']:GetInventory()
elseif Config.InventorySystem == 'other-inventory-system' then
    InventorySystem = exports['other-inventory-system']:GetInventory()
end

local locales = QBCore.Shared._L

RegisterNetEvent('server:buyItem', function(playerId, itemName, quantity)
    local xPlayer = QBCore.Functions.GetPlayer(playerId)
    local itemPrice = GetItemPrice(itemName)

    if xPlayer.Functions.RemoveMoney('cash', itemPrice * quantity) then
        InventorySystem:AddItem(playerId, itemName, quantity)
        TriggerClientEvent('QBCore:Notify', playerId, locales('purchase_successful'), "success")
    else
        TriggerClientEvent('QBCore:Notify', playerId, locales('not_enough_money'), "error")
    end
end)

function GetItemPrice(itemName)
    local prices = {
        bread = 5,
        water = 2
    }
    return prices[itemName] or 0
end
