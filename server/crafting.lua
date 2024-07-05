local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

-- Events
RegisterNetEvent('theluxempire_roleplayworld:server:CraftItem', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local recipe = Config.Crafting[itemName]
    if not recipe then return end

    -- Check if player has required items
    for item, amount in pairs(recipe.items) do
        if not Player.Functions.RemoveItem(item, amount) then
            TriggerClientEvent('QBCore:Notify', src, "You don't have the required materials!", "error")
            return
        end
    end

    -- Craft the item
    Player.Functions.AddItem(itemName, recipe.result.amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "add")

    -- Add crafting XP
    AddSkillXP(src, "crafting", recipe.xp or 10)

    TriggerClientEvent('QBCore:Notify', src, "You've successfully crafted " .. QBCore.Shared.Items[itemName].label, "success")
end)
