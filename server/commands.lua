local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

QBCore.Commands.Add("startvent", "Start a specific event (Admin Only)", {{name="eventName", help="Name of the event to start"}}, true, function(source, args)
    local src = source
    if QBCore.Functions.HasPermission(src, "admin") then
        local eventName = args[1]
        if Config.Events[eventName] then
            StartEvent(eventName)
            TriggerClientEvent('QBCore:Notify', src, "Event " .. eventName .. " has been started.", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "Invalid event name.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have permission to use this command.", "error")
    end
end)

QBCore.Commands.Add("endevent", "End a specific event (Admin Only)", {{name="eventName", help="Name of the event to end"}}, true, function(source, args)
    local src = source
    if QBCore.Functions.HasPermission(src, "admin") then
        local eventName = args[1]
        if activeEvents[eventName] then
            EndEvent(eventName)
            TriggerClientEvent('QBCore:Notify', src, "Event " .. eventName .. " has been ended.", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "This event is not currently active.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have permission to use this command.", "error")
    end
end)

QBCore.Commands.Add("addskillxp", "Add skill XP to a player (Admin Only)", {{name="playerId", help="ID of the player"}, {name="skillName", help="Name of the skill"}, {name="xpAmount", help="Amount of XP to add"}}, true, function(source, args)
    local src = source
    if QBCore.Functions.HasPermission(src, "admin") then
        local playerId = tonumber(args[1])
        local skillName = args[2]
        local xpAmount = tonumber(args[3])
        
        if playerId and skillName and xpAmount then
            if Config.Skills[skillName] then
                AddSkillXP(playerId, skillName, xpAmount)
                TriggerClientEvent('QBCore:Notify', src, "Added " .. xpAmount .. " XP to " .. skillName .. " skill for player " .. playerId, "success")
            else
                TriggerClientEvent('QBCore:Notify', src, "Invalid skill name.", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Invalid command usage.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have permission to use this command.", "error")
    end
end)

QBCore.Commands.Add("setskill", "Set skill level for a player (Admin Only)", {{name="playerId", help="ID of the player"}, {name="skillName", help="Name of the skill"}, {name="level", help="Skill level to set"}}, true, function(source, args)
    local src = source
    if QBCore.Functions.HasPermission(src, "admin") then
        local playerId = tonumber(args[1])
        local skillName = args[2]
        local level = tonumber(args[3])
        
        if playerId and skillName and level then
            if Config.Skills[skillName] then
                local playerData = exports.theluxempire_roleplayworld:GetPlayerData(playerId)
                if playerData and playerData.skills[skillName] then
                    playerData.skills[skillName].level = level
                    playerData.skills[skillName].xp = 0
                    TriggerClientEvent('theluxempire_roleplayworld:client:UpdateSkill', playerId, skillName, level, 0)
                    TriggerClientEvent('QBCore:Notify', src, "Set " .. skillName .. " skill to level " .. level .. " for player " .. playerId, "success")
                else
                    TriggerClientEvent('QBCore:Notify', src, "Player data not found.", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Invalid skill name.", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Invalid command usage.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have permission to use this command.", "error")
    end
end)
