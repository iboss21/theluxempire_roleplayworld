
local QBCore = exports['qb-core']:GetCoreObject()
local activeQuests = {}

RegisterNetEvent('client:startQuest', function(questId)
    local quest = Config.Quests[questId]
    if quest then
        activeQuests[questId] = { progress = 0, completed = false }
        QBCore.Functions.Notify("Quest started: " .. quest.name, "success")
        TriggerServerEvent('server:saveQuestProgress', questId, activeQuests[questId])
    else
        QBCore.Functions.Notify("Quest not found.", "error")
    end
end)

RegisterNetEvent('client:updateQuestProgress', function(questId, item, amount)
    local quest = Config.Quests[questId]
    if quest and activeQuests[questId] and not activeQuests[questId].completed then
        for _, objective in ipairs(quest.objectives) do
            if objective.item == item then
                activeQuests[questId].progress = activeQuests[questId].progress + amount
                if activeQuests[questId].progress >= objective.amount then
                    activeQuests[questId].completed = true
                    QBCore.Functions.Notify("Quest completed: " .. quest.name, "success")
                    TriggerServerEvent('server:completeQuest', questId)
                else
                    QBCore.Functions.Notify("Quest progress: " .. activeQuests[questId].progress .. "/" .. objective.amount, "info")
                end
                TriggerServerEvent('server:saveQuestProgress', questId, activeQuests[questId])
                break
            end
        end
    end
end)

RegisterNetEvent('client:loadQuestProgress', function(savedQuests)
    activeQuests = savedQuests or {}
end)
