local QBCore = exports['qb-core']:GetCoreObject()

-- Add any necessary server-side core functionality here

-- Initialize database table if it doesn't exist
MySQL.ready(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS theluxempire_playerdata (
            citizenid VARCHAR(50) PRIMARY KEY,
            data LONGTEXT
        )
    ]])
end)
