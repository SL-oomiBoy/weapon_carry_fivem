--[[ 
    Advanced Weapon Holster System - Server Component
    Created by Omiya
    Version 1.0.1
--]]

local QBCore = exports['qb-core']:GetCoreObject()

-- Server-side configuration (can be synced to clients)
local Config = {
    AdminOnly = false,       -- Set to true to restrict usage to admins only
    EnabledJobs = {},        -- Empty means all jobs can use it, or specify like {'police', 'sheriff'}
    VersionCheck = true      -- Check for updates
}

-- Register server callback for permissions
QBCore.Functions.CreateCallback('omiya-weaponcarry:server:checkPermission', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then 
        cb(false)
        return
    end
    
    local citizenid = Player.PlayerData.citizenid
    local job = Player.PlayerData.job.name
    
    -- Admin only check
    if Config.AdminOnly then
        local isAdmin = QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god')
        if not isAdmin then
            cb(false)
            return
        end
    end
    
    -- Job restriction check
    if #Config.EnabledJobs > 0 then
        local hasJob = false
        for _, allowedJob in ipairs(Config.EnabledJobs) do
            if job == allowedJob then
                hasJob = true
                break
            end
        end
        
        if not hasJob then
            cb(false)
            return
        end
    end
    
    -- Player has permission
    cb(true)
end)

-- Event to sync holster visibility to nearby players
RegisterNetEvent('omiya-weaponcarry:server:syncHolster')
AddEventHandler('omiya-weaponcarry:server:syncHolster', function(weaponHash, visible)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    
    -- Broadcast to nearby players
    TriggerClientEvent('omiya-weaponcarry:client:syncHolster', -1, src, weaponHash, visible)
end)

-- Command to reload configuration
QBCore.Commands.Add('holsterconfig', 'Reload holster configuration', {}, true, function(source, args)
    TriggerClientEvent('omiya-weaponcarry:client:reloadConfig', -1)
end, 'admin')

-- Server startup message
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print('^2Advanced Weapon Holster System^7 by Omiya started successfully!')
    end
end)