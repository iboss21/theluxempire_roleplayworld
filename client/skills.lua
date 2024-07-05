local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

local playerSkills = {}

-- Local functions
local function UpdateSkill(skillName, newLevel, newXP)
    playerSkills[skillName] = {level = newLevel, xp = newXP}
    TLELib.Notify("Your " .. skillName .. " skill is now level " .. newLevel .. "!", "success")
end

local function DisplaySkillProgress(skillName)
    local skill = playerSkills[skillName]
    if not skill then return end

    local config = Config.Skills[skillName]
    local progress = (skill.xp / config.xpPerLevel) * 100
    TLELib.ShowProgressBar(skillName, progress, "Level " .. skill.level .. " (" .. skill.xp .. "/" .. config.xpPerLevel .. " XP)")
end

-- Events
RegisterNetEvent('theluxempire_roleplayworld:client:SyncSkills', function(skills)
    playerSkills = skills
end)

RegisterNetEvent('theluxempire_roleplayworld:client:UpdateSkill', function(skillName, newLevel, newXP)
    UpdateSkill(skillName, newLevel, newXP)
    DisplaySkillProgress(skillName)
end)

-- Command to view skills (temporary, replace with proper UI later)
RegisterCommand('viewskills', function()
    local skillList = "Your Skills:\n\n"
    for skillName, skillData in pairs(playerSkills) do
        skillList = skillList .. skillName:gsub("^%l", string.upper) .. ": Level " .. skillData.level .. " (" .. skillData.xp .. "/" .. Config.Skills[skillName].xpPerLevel .. " XP)\n"
    end
    TLELib.ShowNotification(skillList)
end)

-- Export function to get player skills
exports('GetPlayerSkills', function()
    return playerSkills
end)
