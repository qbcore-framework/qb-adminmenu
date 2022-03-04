-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local SoundScriptName = 'interact-sound'
local SoundPath = '/client/html/sounds'
local IsFrozen = {}
local permissions = { -- What should each permission be able to do
    ['kill'] = 'god',
    ['revive'] = 'god',
    ['freeze'] = 'admin',
    ['spectate'] = 'admin',
    ['goto'] = 'admin',
    ['bring'] = 'admin',
    ['intovehicle'] = 'admin',
    ['kick'] = 'admin',
    ['ban'] = 'god',
    ['setPermissions'] = 'god',
    ['cloth'] = 'admin',
    ['spawnVehicle'] = 'admin',
    ['SaveCar'] = 'god',
    ['playsound'] = 'god',
}
local PermissionOrder = { -- Permission hierarchy order from top to bottom
    'god',
    'admin',
    'user'
}

-- Functions
local function tablelength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

local function PermOrder(permission)
    for i = 1, #PermissionOrder do
        if PermissionOrder[i] == permission then
            return i
        end
    end
end

local function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    for filename in popen('dir "'..directory..'" /b'):lines() do
        i = i + 1
        t[i] = filename:match("(.+)%..+$")
    end
    return t
end

-- Events
RegisterNetEvent('qb-admin:server:GetPlayersForBlips', function()
    local src = source
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        players[#players+1] = {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | ' .. GetPlayerName(v),
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source
        }
    end
    TriggerClientEvent('qb-admin:client:Show', src, players)
end)

RegisterNetEvent('qb-admin:server:kill', function(player)
    local src = source
    local target = player.id

    if not (QBCore.Functions.HasPermission(src, permissions['kill']) or IsPlayerAceAllowed(src, 'command')) then return end
    if PermOrder(QBCore.Functions.GetPermission(src)) > PermOrder(QBCore.Functions.GetPermission(target)) then return end

    TriggerClientEvent('hospital:client:KillPlayer', target)
end)

RegisterNetEvent('qb-admin:server:revive', function(player)
    local src = source

    if not (QBCore.Functions.HasPermission(src, permissions['revive']) or IsPlayerAceAllowed(src, 'command')) then return end
    
    TriggerClientEvent('hospital:client:Revive', player.id)
end)

RegisterNetEvent('qb-admin:server:freeze', function(player)
    local src = source
    local target = GetPlayerPed(player.id)
    
    if not (QBCore.Functions.HasPermission(src, permissions['freeze']) or IsPlayerAceAllowed(src, 'command')) then return end
    if PermOrder(QBCore.Functions.GetPermission(src)) > PermOrder(QBCore.Functions.GetPermission(player.id)) then return end
    if IsFrozen[target] == nil then IsFrozen[target] = false end

    if IsFrozen[target] then
        FreezeEntityPosition(target, false)
        IsFrozen[target] = false
    else
        FreezeEntityPosition(target, true)
        IsFrozen[target] = true
    end
end)

RegisterNetEvent('qb-admin:server:spectate', function(player)
    local src = source
    local targetped = GetPlayerPed(player.id)
    local coords = GetEntityCoords(targetped)

    if not (QBCore.Functions.HasPermission(src, permissions['spectate']) or IsPlayerAceAllowed(src, 'command')) then return end
    
    TriggerClientEvent('qb-admin:client:spectate', src, player.id, coords)
end)

RegisterNetEvent('qb-admin:server:goto', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(GetPlayerPed(player.id))
    
    if not (QBCore.Functions.HasPermission(src, permissions['goto']) or IsPlayerAceAllowed(src, 'command')) then return end

    SetEntityCoords(admin, coords)
end)

RegisterNetEvent('qb-admin:server:bring', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(player.id)
    
    if not (QBCore.Functions.HasPermission(src, permissions['bring']) or IsPlayerAceAllowed(src, 'command')) then return end
    
    SetEntityCoords(target, coords)
end)

RegisterNetEvent('qb-admin:server:intovehicle', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local targetPed = GetPlayerPed(player.id)
    local vehicle = GetVehiclePedIsIn(targetPed, false)
    local seat = -1
    
    if not (QBCore.Functions.HasPermission(src, permissions['intovehicle']) or IsPlayerAceAllowed(src, 'command')) then return end
    if vehicle == 0 then TriggerClientEvent('QBCore:Notify', src, Lang:t("error.player_no_vehicle"), 'error', 4000) return end
    for i = 0, 8, 1 do if GetPedInVehicleSeat(vehicle, i) == 0 then seat = i break end end
    if seat == -1 then TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_free_seats"), 'error', 4000) return end
    
    SetPedIntoVehicle(admin, vehicle, seat)
    TriggerClientEvent('QBCore:Notify', src, Lang:t("success.entered_vehicle"), 'success', 5000)
end)

RegisterNetEvent('qb-admin:server:kick', function(player, reason)
    local src = source
    local target = player.id
    
    if not (QBCore.Functions.HasPermission(src, permissions['kick']) or IsPlayerAceAllowed(src, 'command')) then return end
    if PermOrder(QBCore.Functions.GetPermission(src)) > PermOrder(QBCore.Functions.GetPermission(target)) then return end
    
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(target), GetPlayerName(src), reason), true)
    DropPlayer(target, Lang:t("info.kicked_server") .. ':\n' .. reason .. '\n\n' .. Lang:t("info.check_discord") .. QBCore.Config.Server.discord)
end)

RegisterNetEvent('qb-admin:server:ban', function(player, time, reason)
    local src = source
    local target = player.id
    local banTime = tonumber(os.time() + tonumber(time))
    if banTime > 2147483647 then banTime = 2147483647 end
    local timeTable = os.date('*t', banTime)
    
    if not (QBCore.Functions.HasPermission(src, permissions['ban']) or IsPlayerAceAllowed(src, 'command')) then return end
    if PermOrder(QBCore.Functions.GetPermission(src)) > PermOrder(QBCore.Functions.GetPermission(target)) then return end

    MySQL.Async.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(target),
        QBCore.Functions.GetIdentifier(target, 'license'),
        QBCore.Functions.GetIdentifier(target, 'discord'),
        QBCore.Functions.GetIdentifier(target, 'ip'),
        reason,
        banTime,
        GetPlayerName(src)
    })
    TriggerClientEvent('chat:addMessage', -1, {
        template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been banned:</strong> {1}</div>",
        args = {GetPlayerName(target), reason}
    })
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(target), GetPlayerName(src), reason), true)
    if banTime >= 2147483647 then
        DropPlayer(target, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_perm") .. QBCore.Config.Server.discord)
    else
        DropPlayer(target, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.discord)
    end
end)

RegisterNetEvent('qb-admin:server:setPermissions', function(targetId, group)
    local src = source

    if not (QBCore.Functions.HasPermission(src, permissions['setPermissions']) or IsPlayerAceAllowed(src, 'command')) then return end
    if PermOrder(QBCore.Functions.GetPermission(src)) > PermOrder(group[1].rank) then return end

    QBCore.Functions.AddPermission(targetId, group[1].rank)
    TriggerClientEvent('QBCore:Notify', targetId, Lang:t("info.rank_level")..group[1].label)
    TriggerClientEvent('QBCore:Notify', src, Lang:t("success.changed_perm")..' : '..group[1].label)
end)

RegisterNetEvent('qb-admin:server:cloth', function(player)
    local src = source

    if not (QBCore.Functions.HasPermission(src, permissions['cloth']) or IsPlayerAceAllowed(src, 'command')) then return end

    TriggerClientEvent('qb-clothing:client:openMenu', player.id)
end)

RegisterNetEvent('qb-admin:server:spawnVehicle', function(model)
    local src = source
    local hash = GetHashKey(model)
    local player = GetPlayerPed(src)
    local coords = GetEntityCoords(player)
    local heading = GetEntityHeading(player)
    local vehicle = GetVehiclePedIsIn(player, false)

    if not (QBCore.Functions.HasPermission(src, permissions['spawnVehicle']) or IsPlayerAceAllowed(src, 'command')) then return end
    if vehicle ~= 0 then DeleteEntity(vehicle) end

    local vehicle = CreateVehicle(hash, coords, true, true)
    while not DoesEntityExist(vehicle) do
        Wait(100)
    end
    SetEntityHeading(vehicle, heading)
    TaskWarpPedIntoVehicle(player, vehicle, -1)
    TriggerClientEvent('vehiclekeys:client:SetOwner', src, GetVehicleNumberPlateText(vehicle))
end)

RegisterNetEvent('qb-admin:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.Sync.fetchAll('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    
    if result[1] ~= nil then TriggerClientEvent('QBCore:Notify', src, Lang:t("error.failed_vehicle_owner"), 'error', 3000) return end
    if not (QBCore.Functions.HasPermission(src, permissions['SaveCar']) or IsPlayerAceAllowed(src, 'command')) then return end
    
    MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.license,
        Player.PlayerData.citizenid,
        vehicle.model,
        vehicle.hash,
        json.encode(mods),
        plate,
        0
    })
    TriggerClientEvent('QBCore:Notify', src, Lang:t("success.success_vehicle_owner"), 'success', 5000)
end)

RegisterNetEvent('qb-admin:server:getsounds', function()
    local src = source
    local path = GetResourcePath(SoundScriptName)
    path = path:gsub('//', '/')..SoundPath
    local Files = scandir(path)
    
    if not (QBCore.Functions.HasPermission(src, permissions['SaveCar']) or IsPlayerAceAllowed(src, 'command')) then return end
    
    TriggerClientEvent('qb-admin:client:getsounds', src, Files)
end)

RegisterNetEvent('qb-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chat:addMessage', src, {
                color = {255, 0, 0},
                multiline = true,
                args = {Lang:t("info.admin_report")..name..' ('..targetSrc..')', msg}
            })
        end
    end
end)

RegisterNetEvent('qb-admin:server:Staffchat:addMessage', function(name, msg)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chat:addMessage', src, Lang:t("info.staffchat")..name, 'error', msg)
        end
    end
end)

RegisterNetEvent('qb-admin:server:playsound', function(target, soundname, soundvolume, soundradius)
    local src = source

    if not (QBCore.Functions.HasPermission(src, permissions['playsound']) or IsPlayerAceAllowed(src, 'command')) then return end

    TriggerClientEvent('qb-admin:client:playsound', target, soundname, soundvolume, soundradius)
end)
-- Commands

QBCore.Commands.Add('blips', Lang:t("commands.blips_for_player"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleBlips', src)
end, 'admin')

QBCore.Commands.Add('names', Lang:t("commands.player_name_overhead"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleNames', src)
end, 'admin')

QBCore.Commands.Add('coords', Lang:t("commands.coords_dev_command"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:ToggleCoords', src)
end, 'admin')

QBCore.Commands.Add('noclip', Lang:t("commands.toogle_noclip"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:ToggleNoClip', src)
end, 'admin')

QBCore.Commands.Add('admincar', Lang:t("commands.save_vehicle_garage"), {}, false, function(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SaveCar', source)
end, 'admin')

QBCore.Commands.Add('announce', Lang:t("commands.make_announcement"), {}, false, function(source, args)
    local msg = table.concat(args, ' ')
    if msg == '' then return end
    TriggerClientEvent('chat:addMessage', -1, {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Announcement", msg}
    })
end, 'admin')

QBCore.Commands.Add('admin', Lang:t("commands.open_admin"), {}, false, function(source, args)
    TriggerClientEvent('qb-admin:client:openMenu', source)
end, 'admin')

QBCore.Commands.Add('report', Lang:t("info.admin_report"), {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SendReport', -1, GetPlayerName(src), src, msg)
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report', 'green', '**'..GetPlayerName(source)..'** (CitizenID: '..Player.PlayerData.citizenid..' | ID: '..source..') **Report:** ' ..msg, false)
end)

QBCore.Commands.Add('staffchat', Lang:t("commands.staffchat_message"), {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    TriggerClientEvent('qb-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, 'admin')

QBCore.Commands.Add('givenuifocus', Lang:t("commands.nui_focus"), {{name='id', help='Player id'}, {name='focus', help='Set focus on/off'}, {name='mouse', help='Set mouse on/off'}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]
    TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, 'admin')

QBCore.Commands.Add('warn', Lang:t("commands.warn_a_player"), {{name='ID', help='Player'}, {name='Reason', help='Mention a reason'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local myName = senderPlayer.PlayerData.name
    local warnId = 'WARN-'..math.random(1111, 9999)
    if targetPlayer ~= nil then
		TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, { args = { "SYSTEM", Lang:t("info.warning_chat_message")..GetPlayerName(source).."," .. Lang:t("info.reason") .. ": "..msg }, color = 255, 0, 0 })
		TriggerClientEvent('chat:addMessage', source, { args = { "SYSTEM", Lang:t("info.warning_staff_message")..GetPlayerName(targetPlayer.PlayerData.source)..", for: "..msg }, color = 255, 0, 0 })
        MySQL.Async.insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.license,
            targetPlayer.PlayerData.license,
            msg,
            warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('checkwarns', Lang:t("commands.check_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local result = MySQL.Sync.fetchAll('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has '..tablelength(result)..' warnings!')
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local warnings = MySQL.Sync.fetchAll('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        local selectedWarning = tonumber(args[2])
        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
            TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has been warned by '..sender.PlayerData.name..', Reason: '..warnings[selectedWarning].reason)
        end
    end
end, 'admin')

QBCore.Commands.Add('delwarn', Lang:t("commands.delete_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local warnings = MySQL.Sync.fetchAll('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
    local selectedWarning = tonumber(args[2])
    if warnings[selectedWarning] ~= nil then
        local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', 'You have deleted warning ('..selectedWarning..') , Reason: '..warnings[selectedWarning].reason)
        MySQL.Async.execute('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
    end
end, 'admin')

QBCore.Commands.Add('reportr', Lang:t("commands.reply_to_report"), {{name='id', help='Player'}, {name = 'message', help = 'Message to respond with'}}, false, function(source, args, rawCommand)
    local src = source
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if msg == '' then return end
    if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end
    if not QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') ~= 1 then return end
    TriggerClientEvent('chat:addMessage', playerId, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Admin Response', msg}
    })
    TriggerClientEvent('chat:addMessage', src, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Report Response ('..playerId..')', msg}
    })
    TriggerClientEvent('QBCore:Notify', src, 'Reply Sent')
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report Reply', 'red', '**'..GetPlayerName(src)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)
end, 'admin')

QBCore.Commands.Add('setmodel', Lang:t("commands.change_ped_model"), {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_model"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('setspeed', Lang:t("commands.set_player_foot_speed"), {}, false, function(source, args)
    local speed = args[1]
    if speed ~= nil then
        TriggerClientEvent('qb-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_speed"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('reporttoggle', Lang:t("commands.report_toggle"), {}, false, function(source, args)
    local src = source
    QBCore.Functions.ToggleOptin(src)
    if QBCore.Functions.IsOptin(src) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.receive_reports"), 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_receive_report"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('kickall', Lang:t("commands.kick_all"), {}, false, function(source, args)
    local src = source
    if src > 0 then
        local reason = table.concat(args, ' ')
        if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
            if reason and reason ~= '' then
                for k, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player then
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t("info.no_reason_specified"), 'error')
            end
        end
    else
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player then
                DropPlayer(Player.PlayerData.source, Lang:t("info.server_restart") .. QBCore.Config.Server.discord)
            end
        end
    end
end, 'god')

QBCore.Commands.Add('setammo', Lang:t("commands.ammo_amount_set"), {{name='amount', help='Amount of bullets, for example: 20'}, {name='weapon', help='Name of the weapen, for example: WEAPON_VINTAGEPISTOL'}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, 'current', amount)
    end
end, 'admin')

QBCore.Functions.CreateCallback('qb-adminmenu:callback:getdealers', function(source, cb)
    cb(exports['qb-drugs']:GetDealers())
end)

QBCore.Functions.CreateCallback('qb-adminmenu:callback:getplayers', function(source, cb)
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        players[#players+1] = {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(v) .. ')',
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source

        }
    end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(players, function(a, b)
            return a.id < b.id
        end)
        ------
    cb(players)
end)

QBCore.Functions.CreateCallback('qb-adminmenu:callback:haspermission', function(source, cb)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        cb(true)
    else
        cb(false)
    end
end)
