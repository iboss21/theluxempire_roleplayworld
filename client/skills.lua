
-- Client skills script

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('client:increaseSkill', function(skillName, amount)
    local playerData = QBCore.Functions.GetPlayerData()
    playerData.skills = playerData.skills or {}
    playerData.skills[skillName] = (playerData.skills[skillName] or 0) + amount
    TriggerServerEvent('server:updatePlayerSkills', playerData.skills)
    TriggerEvent('QBCore:Notify', 'Skill increased: ' .. skillName, 'success')
end)
