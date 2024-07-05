local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

local currentPrices = {}

-- Local functions
local function UpdateMarketPrices(prices)
    currentPrices = prices
end

local function DisplayMarketPrices()
    local priceList = "Current Market Prices:\n\n"
    for item, price in pairs(currentPrices) do
        priceList = priceList .. Config.Items[item].label .. ": $" .. Utils.FormatNumber(price) .. "\n"
    end
    TLELib.ShowNotification(priceList)
end

local function SellItem(item, amount)
    if not currentPrices[item] then
        TLELib.Notify("This item cannot be sold here.", "error")
        return
    end

    TriggerServerEvent('theluxempire_roleplayworld:server:SellItem', item, amount)
end

-- Events
RegisterNetEvent('theluxempire_roleplayworld:client:UpdateMarketPrices', function(prices)
    UpdateMarketPrices(prices)
end)

RegisterNetEvent('theluxempire_roleplayworld:client:OpenMarketMenu', function()
    local marketOptions = {
        {label = "View Current Prices", value = "view_prices"},
        {label = "Sell Items", value = "sell_items"},
    }

    TLELib.OpenMenu("Market Options", marketOptions, function(selected)
        if selected == "view_prices" then
            DisplayMarketPrices()
        elseif selected == "sell_items" then
            -- Open inventory and allow player to select items to sell
            -- This part depends on your inventory system
            -- For simplicity, let's assume we're selling wood
            SellItem("wood", 10) -- Sell 10 wood
        end
    end)
end)

-- Main thread for market locations
CreateThread(function()
    while true do
        local wait = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, marketLocation in ipairs(Config.Market.locations) do
            local distance = #(playerCoords - marketLocation.coords)
            if distance < 10.0 then
                wait = 0
                TLELib.DrawMarker(1, marketLocation.coords.x, marketLocation.coords.y, marketLocation.coords.z - 1.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 0, 255, 0, 100, false, true, 2, false, nil, nil, false)
                if distance < 1.5 then
                    TLELib.DrawText3D(marketLocation.coords.x, marketLocation.coords.y, marketLocation.coords.z, "Press [E] to access the market")
                    if IsControlJustReleased(0, 38) then -- E key
                        TriggerEvent('theluxempire_roleplayworld:client:OpenMarketMenu')
                    end
                end
            end
        end

        Wait(wait)
    end
end)
