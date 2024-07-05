local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

local isCrafting = false

-- Local functions
local function CanCraftItem(itemName)
    local recipe = Config.Crafting[itemName]
    if not recipe then return false end

    local playerSkill = TLE.GetPlayerSkill(recipe.requiredSkill.name)
    if playerSkill < recipe.requiredSkill.level then return false end

    for item, amount in pairs(recipe.items) do
        if not QBCore.Functions.HasItem(item, amount) then return false end
    end

    return true
end

local function StartCrafting(itemName)
    if isCrafting then return end
    isCrafting = true

    local recipe = Config.Crafting[itemName]
    TLELib.ProgressBar("crafting_item", "Crafting " .. Config.Items[itemName].label, recipe.time, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_ped",
        flags = 49,
    }, {}, {}, function() -- Done
        isCrafting = false
        TriggerServerEvent('theluxempire_roleplayworld:server:CraftItem', itemName)
    end, function() -- Cancel
        isCrafting = false
    end)
end

-- Events
RegisterNetEvent('theluxempire_roleplayworld:client:OpenCraftingMenu', function()
    local craftableItems = {}
    for itemName, recipe in pairs(Config.Crafting) do
        if CanCraftItem(itemName) then
            table.insert(craftableItems, {
                label = Config.Items[itemName].label,
                value = itemName,
            })
        end
    end

    TLELib.OpenMenu("Crafting Menu", craftableItems, function(selected)
        if selected then
            StartCrafting(selected)
        end
    end)
end)

-- Command to open crafting menu (temporary, replace with proper trigger later)
RegisterCommand('opencrafting', function()
    TriggerEvent('theluxempire_roleplayworld:client:OpenCraftingMenu')
end)
