local QBCore = exports['qb-core']:GetCoreObject()
local TLE = exports['theluxempire-core']:GetObject()
local TLELib = exports['theluxempire-lib']:GetObject()

local isLoggedIn = false
local PlayerData = {}
local currentActivity = nil

-- Functions
local function InitializePlayer()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('theluxempire_roleplayworld:server:SyncPlayerData')
end

local function UpdatePlayerData(key, value)
    PlayerData[key] = value
end

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    InitializePlayer()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
    PlayerData = {}
    currentActivity = nil
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(data)
    PlayerData = data
end)

RegisterNetEvent('theluxempire_roleplayworld:client:SyncPlayerData', function(data)
    for key, value in pairs(data) do
        UpdatePlayerData(key, value)
    end
end)

-- Main thread
CreateThread(function()
    while true do
        if isLoggedIn then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for activityType, activityData in pairs(Config.Activities) do
                if activityData.enabled then
                    for _, location in ipairs(activityData.locations) do
                        local distance = #(playerCoords - location.coords)
                        if distance < location.radius then
                            if currentActivity ~= activityType then
                                currentActivity = activityType
                                TriggerEvent('theluxempire_roleplayworld:client:EnteredActivityZone', activityType, location)
                            end
                            break
                        elseif currentActivity == activityType then
                            currentActivity = nil
                            TriggerEvent('theluxempire_roleplayworld:client:LeftActivityZone', activityType)
                        end
                    end
                end
            end
        end
        Wait(1000)
    end
end)

-- Exports
exports('GetPlayerData', function()
    return PlayerData
end)

exports('GetCurrentActivity', function()
    return currentActivity
end)
