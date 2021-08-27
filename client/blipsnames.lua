local ShowBlips = false
local ShowNames = false

RegisterNetEvent('qb-admin:client:toggleBlips')
AddEventHandler('qb-admin:client:toggleBlips', function()
    if not ShowBlips then
        ShowBlips = true
        QBCore.Functions.Notify("Blips activated", "success")
    else
        ShowBlips = false
        QBCore.Functions.Notify("Blips deactivated", "error")
    end
end)

RegisterNetEvent('qb-admin:client:toggleNames')
AddEventHandler('qb-admin:client:toggleNames', function()
    if not ShowNames then
        ShowNames = true
        QBCore.Functions.Notify("Names activated", "success")
    else
        ShowNames = false
        QBCore.Functions.Notify("Names deactivated", "error")
    end
end)

RegisterNetEvent('qb-admin:client:Show')
AddEventHandler('qb-admin:client:Show', function(players)
    for k, player in pairs(players) do
        local playeridx = GetPlayerFromServerId(player.id)
        local ped = GetPlayerPed(playeridx)
        local blip = GetBlipFromEntity(ped)
        local name = '#'..player.id..' - '..player.name

        -- Names Logic
        local idTesta = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, name, false, false, "", false)

        if ShowNames then
            Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 0, true)
            if NetworkIsPlayerTalking(playeridx) then
                Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, true)
            else
                Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, false)
            end
        else
            Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, false)
            Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 0, false)
        end

        -- Blips Logic
        if ShowBlips then
            if not DoesBlipExist(blip) then -- Blip doesn't exist, make it appear
                blip = AddBlipForEntity(ped)
                SetBlipSprite(blip, 1)
                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
            else -- Blip exist, update it
                local veh = GetVehiclePedIsIn(ped, false)
                local blipSprite = GetBlipSprite(blip)
                if not GetEntityHealth(ped) then -- Check if ped is death
                    if blipSprite ~= 274 then
                        SetBlipSprite(blip, 274)
                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                    end
                elseif veh ~= 0 then -- Check if ped is in vehicle
                    local classveh = GetVehicleClass(veh)
                    local modelveh = GetEntityModel(veh)
                    if classveh == 15 then -- Vehicle type 15 Helicopters
                        if blipSprite ~= 422 then
                            SetBlipSprite(blip, 422)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                        end
                    elseif classveh == 16 then -- Vehicle type 16 Planes
                        if modelveh == `besra` or modelveh == `hydra` or modelveh == `lazer` then   --Check if vehicle is military jet
                            if blipSprite ~= 424 then
                                SetBlipSprite(blip, 424)
                                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                            end
                        elseif blipSprite ~= 423 then
                            SetBlipSprite(blip, 423)
                            Citizen.InvokeNative (0x5FBCA48327B914DF, blip, false)
                        end
                    elseif classveh == 14 then -- Vehicle type 14 Boat
                        if blipSprite ~= 427 then
                            SetBlipSprite(blip, 427)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                        end
                    elseif modelveh == `insurgent` or modelveh == `insurgent2` or modelveh == `limo2` then   -- Vehicle is armed car
                        if blipSprite ~= 426 then
                            SetBlipSprite(blip, 426)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                        end
                    elseif modelveh == `rhino` then -- Vehicle is Rhino
                        if blipSprite ~= 421 then
                            SetBlipSprite(blip, 421)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                        end
                    elseif blipSprite ~= 1 then -- default blip
                        SetBlipSprite(blip, 1)
                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                    end
                    -- Show number in case of passangers
                    passengers = GetVehicleNumberOfPassengers(veh)
                    if passengers then
                        if not IsVehicleSeatFree(veh, -1) then
                            passengers = passengers + 1
                        end
                        ShowNumberOnBlip(blip, passengers)
                    else
                        HideNumberOnBlip(blip)
                    end
                else    -- Ped is on foot
                    HideNumberOnBlip(blip)
                    if blipSprite ~= 1 then
                        SetBlipSprite(blip, 1)
                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                    end
                end

                SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                SetBlipNameToPlayerName(blip, playeridx)
                SetBlipScale(blip, 0.85)

                if IsPauseMenuActive() then
                    SetBlipAlpha(blip, 255)
                else
                    local x1, y1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                    local x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(playeridx), true))
                    local distance = (math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1)) + 900
                    if distance < 0 then
                        distance = 0
                    elseif distance > 255 then
                        distance = 255
                    end
                    SetBlipAlpha(blip, distance)
                end
            end
        else
            RemoveBlip(blip)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if ShowBlips then
            TriggerServerEvent('qb-admin:server:GetPlayersForBlips')
        end
    end
end)