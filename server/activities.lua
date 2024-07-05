local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

-- Local functions
local function CalculateResourceYield(activityType, tool)
    local baseYield = Config.Activities[activityType].baseYield
    local toolEfficiency = Config.Activities[activityType].tools[tool].efficiency
    return math.ceil(baseYield * toolEfficiency)
end

local function AddSkillXP(source, skillName, xpAmount)
    local playerData = exports.theluxempire_roleplayworld:GetPlayerData(source)
    if not playerData or not playerData.skills[skillName] then return end

    local currentXP = playerData.skills[skillName].xp
    local currentLevel = playerData.skills[skillName].level
    local xpForNextLevel = Config.Skills[skillName].xpPerLevel * currentLevel

    currentXP = currentXP + xpAmount
    while currentXP >= xpForNextLevel do
        currentXP = currentXP - xpForNextLevel
        currentLevel = currentLevel + 1
        xpForNextLevel = Config.Skills[skillName].xpPerLevel * currentLevel
    end

    playerData.skills[skillName].xp = currentXP
    playerData.skills[skillName].level = currentLevel

    TriggerClientEvent('theluxempire_roleplayworld:client:UpdateSkill', source, skillName, currentLevel, currentXP)
end

-- Events
RegisterNetEvent('theluxempire_roleplayworld:server:ActivityActionPerformed', function(activityType, nodeIndex, tool)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local yield = CalculateResourceYield(activityType, tool)
    local resourceData = Config.Activities[activityType].resources[math.random(#Config.Activities[activityType].resources)]
    
    Player.Functions.AddItem(resourceData.item, yield)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[resourceData.item], "add")

    AddSkillXP(src, activityType, resourceData.xp)

    TriggerClientEvent('theluxempire_roleplayworld:client:UpdateNodeResource', src, activityType, nodeIndex, 100 - yield)
end)
