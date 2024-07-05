local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

-- Initialize tgiann-inventory
local TGIANNInventory = exports['tgiann-inventory']:GetInventory()

-- Example: Handling a shop purchase
RegisterNetEvent('server:buyItem', function(playerId, itemName, quantity)
    local xPlayer = QBCore.Functions.GetPlayer(playerId)
    local itemPrice = GetItemPrice(itemName) -- Assume a function to get item price

    if xPlayer.Functions.RemoveMoney('cash', itemPrice * quantity) then
        TGIANNInventory:AddItem(playerId, itemName, quantity)
        TriggerClientEvent('QBCore:Notify', playerId, "Purchase successful!", "success")
    else
        TriggerClientEvent('QBCore:Notify', playerId, "Not enough money", "error")
    end
end)

-- Server-side variables
local PlayerData = {}

-- Functions
local function LoadPlayerData(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid
    local result = MySQL.Sync.fetchAll('SELECT * FROM theluxempire_playerdata WHERE citizenid = ?', {citizenid})
    
    if result[1] then
        PlayerData[source] = json.decode(result[1].data)
    else
        PlayerData[source] = {
            skills = {},
            reputation = {},
            quests = {},
        }
        for skillName, _ in pairs(Config.Skills) do
            PlayerData[source].skills[skillName] = {level = 1, xp = 0}
        end
        MySQL.Async.insert('INSERT INTO theluxempire_playerdata (citizenid, data) VALUES (?, ?)', {
            citizenid,
            json.encode(PlayerData[source])
        })
    end

    TriggerClientEvent('theluxempire_roleplayworld:client:SyncPlayerData', source, PlayerData[source])
end

local function SavePlayerData(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid
    MySQL.Async.execute('UPDATE theluxempire_playerdata SET data = ? WHERE citizenid = ?', {
        json.encode(PlayerData[source]),
        citizenid
    })
end

-- Function to get item price (placeholder)
function GetItemPrice(itemName)
    local prices = {
        bread = 5,
        water = 2
    }
    return prices[itemName] or 0
end

-- Events
RegisterNetEvent('QBCore:Server:PlayerLoaded', function(Player)
    LoadPlayerData(Player.PlayerData.source)
end)

RegisterNetEvent('QBCore:Server:OnPlayerUnload', function(source)
    if PlayerData[source] then
        SavePlayerData(source)
        PlayerData[source] = nil
    end
end)

RegisterNetEvent('theluxempire_roleplayworld:server:SyncPlayerData', function()
    local src = source
    if PlayerData[src] then
        TriggerClientEvent('theluxempire_roleplayworld:client:SyncPlayerData', src, PlayerData[src])
    else
        LoadPlayerData(src)
    end
end)

-- Save player data periodically
CreateThread(function()
    while true do
        Wait(300000) -- Save every 5 minutes
        for src, _ in pairs(PlayerData) do
            SavePlayerData(src)
        end
    end
end)

-- Exports
exports('GetPlayerData', function(source)
    return PlayerData[source]
end)
