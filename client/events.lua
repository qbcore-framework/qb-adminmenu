-- Variables

local lastSpectateCoord = nil
local isSpectating = false

-- Events

RegisterNetEvent('qb-admin:client:inventory')
AddEventHandler('qb-admin:client:inventory', function(targetPed)
    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", targetPed)
end)

RegisterNetEvent('qb-admin:client:spectate')
AddEventHandler('qb-admin:client:spectate', function(targetPed, coords)
    local myPed = PlayerPedId()
    local targetplayer = GetPlayerFromServerId(targetPed)
    local target = GetPlayerPed(targetplayer)
    if not isSpectating then
        isSpectating = true
        SetEntityVisible(myPed, false) -- Set invisible
        SetEntityInvincible(myPed, true) -- set godmode
        lastSpectateCoord = GetEntityCoords(myPed) -- save my last coords
        SetEntityCoords(myPed, coords) -- Teleport To Player
        NetworkSetInSpectatorMode(true, target) -- Enter Spectate Mode
    else
        isSpectating = false
        NetworkSetInSpectatorMode(false, target) -- Remove From Spectate Mode
        SetEntityCoords(myPed, lastSpectateCoord) -- Return Me To My Coords
        SetEntityVisible(myPed, true) -- Remove invisible
        SetEntityInvincible(myPed, false) -- Remove godmode
        lastSpectateCoord = nil -- Reset Last Saved Coords
    end
end)

RegisterNetEvent('qb-admin:client:SendReport')
AddEventHandler('qb-admin:client:SendReport', function(name, src, msg)
    TriggerServerEvent('qb-admin:server:SendReport', name, src, msg)
end)

RegisterNetEvent('qb-admin:client:SendStaffChat')
AddEventHandler('qb-admin:client:SendStaffChat', function(name, msg)
    TriggerServerEvent('qb-admin:server:StaffChatMessage', name, msg)
end)

RegisterNetEvent('qb-admin:client:SaveCar')
AddEventHandler('qb-admin:client:SaveCar', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)

    if veh ~= nil and veh ~= 0 then
        local plate = GetVehicleNumberPlateText(veh)
        local props = QBCore.Functions.GetVehicleProperties(veh)
        local hash = props.model
        local vehname = GetDisplayNameFromVehicleModel(hash):lower()
        if QBCore.Shared.Vehicles[vehname] ~= nil and next(QBCore.Shared.Vehicles[vehname]) ~= nil then
            TriggerServerEvent('qb-admin:server:SaveCar', props, QBCore.Shared.Vehicles[vehname], `veh`, plate)
        else
            QBCore.Functions.Notify('You cant store this vehicle in your garage..', 'error')
        end
    else
        QBCore.Functions.Notify('You are not in a vehicle..', 'error')
    end
end)

RegisterNetEvent('qb-admin:client:SetModel')
AddEventHandler('qb-admin:client:SetModel', function(skin)
    local ped = PlayerPedId()
    local model = GetHashKey(skin)
    SetEntityInvincible(ped, true)

    if IsModelInCdimage(model) and IsModelValid(model) then
        LoadPlayerModel(model)
        SetPlayerModel(PlayerId(), model)

        if isPedAllowedRandom(skin) then
            SetPedRandomComponentVariation(ped, true)
        end
        
		SetModelAsNoLongerNeeded(model)
	end
	SetEntityInvincible(ped, false)
end)

RegisterNetEvent('qb-admin:client:SetSpeed')
AddEventHandler('qb-admin:client:SetSpeed', function(speed)
    local ped = PlayerId()
    if speed == "fast" then
        SetRunSprintMultiplierForPlayer(ped, 1.49)
        SetSwimMultiplierForPlayer(ped, 1.49)
    else
        SetRunSprintMultiplierForPlayer(ped, 1.0)
        SetSwimMultiplierForPlayer(ped, 1.0)
    end
end)

RegisterNetEvent('qb-weapons:client:SetWeaponAmmoManual')
AddEventHandler('qb-weapons:client:SetWeaponAmmoManual', function(weapon, ammo)
    local ped = PlayerPedId()
    if weapon ~= "current" then
        local weapon = weapon:upper()
        SetPedAmmo(ped, GetHashKey(weapon), ammo)
        QBCore.Functions.Notify('+'..ammo..' Ammo for the '..QBCore.Shared.Weapons[GetHashKey(weapon)]["label"], 'success')
    else
        local weapon = GetSelectedPedWeapon(ped)
        if weapon ~= nil then
            SetPedAmmo(ped, weapon, ammo)
            QBCore.Functions.Notify('+'..ammo..' Ammo for the '..QBCore.Shared.Weapons[weapon]["label"], 'success')
        else
            QBCore.Functions.Notify('You dont have a weapon in your hands..', 'error')
        end
    end
end)

RegisterNetEvent('qb-admin:client:GiveNuiFocus')
AddEventHandler('qb-admin:client:GiveNuiFocus', function(focus, mouse)
    SetNuiFocus(focus, mouse)
end)