local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

local marketPrices = {}

-- Local functions
local function UpdateMarketPrices()
    for item, basePrice in pairs(Config.Market.basePrices) do
        local fluctuation = math.random() * Config.Market.priceFluctuation * 2 - Config.Market.priceFluctuation
        marketPrices[item] = math.floor(basePrice * (1 + fluctuation))
    end

    TriggerClientEvent('theluxempire_roleplayworld:client:UpdateMarketPrices', -1, marketPrices)
end

-- Events
RegisterNetEvent('theluxempire_roleplayworld:server:SellItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not marketPrices[item] then
        TriggerClientEvent('QBCore:Notify', src, "This item cannot be sold here.", "error")
        return
    end

    if Player.Functions.RemoveItem(item, amount) then
        local price = marketPrices[item] * amount
        Player.Functions.AddMoney("cash", price)
        TriggerClientEvent('QBCore:Notify', src, "You sold " .. amount .. "x " .. QBCore.Shared.Items[item].label .. " for $" .. price, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough of this item to sell.", "error")
    end
end)

-- Initialize market prices and start update loop
CreateThread(function()
    UpdateMarketPrices()
    while true do
        Wait(Config.Market.updateInterval * 1000)
        UpdateMarketPrices()
    end
end)
