
-- Server skills script

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('server:updatePlayerSkills', function(skills)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.SetMetaData('skills', skills)
end)
