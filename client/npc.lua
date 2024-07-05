
-- Client NPC script

local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    local npcModel = GetHashKey('mp_m_shopkeep_01')
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(1)
    end

    local npcCoords = vector3(-47.26, -1758.93, 29.42)
    local npcHeading = 45.0
    local npcEntity = CreatePed(4, npcModel, npcCoords, npcHeading, false, true)
    FreezeEntityPosition(npcEntity, true)
    SetEntityInvincible(npcEntity, true)
    SetBlockingOfNonTemporaryEvents(npcEntity, true)

    exports['qb-target']:AddTargetEntity(npcEntity, {
        options = {
            {
                type = 'client',
                event = 'client:openMarket',
                icon = 'fas fa-shopping-basket',
                label = 'Open Market',
            }
        },
        distance = 2.5
    })
end)
