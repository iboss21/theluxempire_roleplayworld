local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

local npcs = {}

-- Local functions
local function SpawnNPC(npcData)
    local model = GetHashKey(npcData.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    local npc = CreatePed(4, model, npcData.coords.x, npcData.coords.y, npcData.coords.z - 1.0, npcData.heading, false, true)
    SetEntityHeading(npc, npcData.heading)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    return npc
end

local function InitializeNPCs()
    for _, npcData in ipairs(Config.NPCs) do
        local npc = SpawnNPC(npcData)
        table.insert(npcs, {entity = npc, data = npcData})
    end
end

local function InteractWithNPC(npcData)
    if npcData.type == "vendor" then
        TriggerEvent('theluxempire_roleplayworld:client:OpenVendorMenu', npcData)
    elseif npcData.type == "quest_giver" then
        TriggerEvent('theluxempire_roleplayworld:client:StartQuest', npcData.questId)
    end
    -- Add more NPC interaction types as needed
end

-- Main thread for NPC interactions
CreateThread(function()
    InitializeNPCs()

    while true do
        local wait = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, npcData in ipairs(npcs) do
            local distance = #(playerCoords - npcData.data.coords)
            if distance < 5.0 then
                wait = 0
                TLELib.DrawText3D(npcData.data.coords.x, npcData.data.coords.y, npcData.data.coords.z + 1.0, "Press [E] to interact with " .. npcData.data.name)
                if distance < 2.0 and IsControlJustReleased(0, 38) then -- E key
                    InteractWithNPC(npcData.data)
                end
            end
        end

        Wait(wait)
    end
end)
