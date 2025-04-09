-- Add these near the top of your client.lua file:

-- Check permission on resource start
AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        QBCore.Functions.TriggerCallback('omiya-weaponcarry:server:checkPermission', function(hasPermission)
            if not hasPermission then
                print("You don't have permission to use the holster system")
                -- You could disable the script here if desired
            end
        end)
    end
end)

-- Handle synced holster visibility from other players
RegisterNetEvent('omiya-weaponcarry:client:syncHolster')
AddEventHandler('omiya-weaponcarry:client:syncHolster', function(playerId, weaponHash, visible)
    -- Only process for other players, not yourself
    if playerId ~= GetPlayerServerId(PlayerId()) then
        -- Implementation for syncing other players' holsters would go here
        -- This is complex and would require a different approach than the personal holster system
    end
end)

-- Config reload from server
RegisterNetEvent('omiya-weaponcarry:client:reloadConfig')
AddEventHandler('omiya-weaponcarry:client:reloadConfig', function()
    RemoveAllWeaponProps()
    print("Holster configuration reloaded from server")
end)

-- And modify the AttachWeaponProp function to sync with others:
local function AttachWeaponProp(weaponHash)
    -- Existing code...
    
    -- Add this at the end:
    TriggerServerEvent('omiya-weaponcarry:server:syncHolster', weaponHash, true)
end

-- And modify the RemoveWeaponProp function:
local function RemoveWeaponProp(weaponHash)
    if attachedWeapons[weaponHash] then
        DeleteObject(attachedWeapons[weaponHash])
        attachedWeapons[weaponHash] = nil
        
        -- Sync with other players
        TriggerServerEvent('omiya-weaponcarry:server:syncHolster', weaponHash, false)
    end
end