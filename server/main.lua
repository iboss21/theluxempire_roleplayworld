
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('server:getQuestProgress', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        cb(xPlayer.PlayerData.metadata.quests)
    else
        cb({})
    end
end)
