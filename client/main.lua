
local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while not QBCore.Functions.GetPlayerData() do
        Wait(100)
    end

    QBCore.Functions.TriggerCallback('server:getQuestProgress', function(quests)
        TriggerEvent('client:loadQuestProgress', quests)
    end)
end)
