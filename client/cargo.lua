
-- Cargo delivery script

local QBCore = exports['qb-core']:GetCoreObject()
local locales = QBCore.Shared._L

RegisterNetEvent('client:startCargoDelivery', function()
    local vehicleModel = GetHashKey('boxville')
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(1)
    end

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local cargoVehicle = CreateVehicle(vehicleModel, coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, false)
    TaskWarpPedIntoVehicle(playerPed, cargoVehicle, -1)

    TriggerServerEvent('server:startCargoDelivery')
end)
