
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('server:saveQuestProgress', function(questId, progress)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        xPlayer.Functions.SetMetaData("quests", xPlayer.PlayerData.metadata.quests or {})
        xPlayer.PlayerData.metadata.quests[questId] = progress
    end
end)

RegisterNetEvent('server:completeQuest', function(questId)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        local quest = Config.Quests[questId]
        if quest then
            xPlayer.Functions.AddItem(quest.reward.item, quest.reward.amount)
            TriggerClientEvent('QBCore:Notify', src, "You received " .. quest.reward.amount .. " " .. quest.reward.item, "success")
        end
    end
end)

QBCore.Functions.CreateCallback('server:getQuestProgress', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        cb(xPlayer.PlayerData.metadata.quests)
    else
        cb({})
    end
end)
