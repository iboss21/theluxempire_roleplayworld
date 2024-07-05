
-- Main client script for TheLuxEmpire Roleplay World

local QBCore = exports['qb-core']:GetCoreObject()
local TargetSystem
local InventorySystem

if Config.TargetSystem == 'qb-target' then
    TargetSystem = exports['qb-target']:GetTarget()
elseif Config.TargetSystem == 'other-target-system' then
    TargetSystem = exports['other-target-system']:GetTarget()
end

if Config.InventorySystem == 'tgiann-inventory' then
    InventorySystem = exports['tgiann-inventory']:GetInventory()
elseif Config.InventorySystem == 'other-inventory-system' then
    InventorySystem = exports['other-inventory-system']:GetInventory()
end

local locales = QBCore.Shared._L

CreateThread(function()
    local npc = GetHashKey('mp_m_shopkeep_01')
    RequestModel(npc)
    while not HasModelLoaded(npc) do
        Wait(1)
    end

    local npcEntity = CreatePed(4, npc, -47.26, -1758.93, 29.42, 45.0, false, true)
    FreezeEntityPosition(npcEntity, true)
    SetEntityInvincible(npcEntity, true)
    SetBlockingOfNonTemporaryEvents(npcEntity, true)

    TargetSystem:AddTargetEntity(npcEntity, {
        options = {
            {
                type = "client",
                event = "client:openShop",
                icon = "fas fa-shopping-basket",
                label = locales('shop_open'),
            },
        },
        distance = 2.5
    })
end)

RegisterNetEvent('client:openShop', function()
    local shopItems = {
        { name = "bread", price = 5 },
        { name = "water", price = 2 }
    }
    InventorySystem:OpenInventory('shop', shopItems)
end)
