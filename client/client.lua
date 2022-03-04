QBCore = exports['qb-core']:GetCoreObject()
local banlength = nil
local showCoords = false
local vehicleDevMode = false
local banreason = 'Unknown'
local kickreason = 'Unknown'
local itemname = 'Unknown'
local itemamount = 0
local soundname = 'Unknown'
local soundrange = 0
local soundvolume = 0
local menuLocation = 'topright' -- e.g. topright (default), topleft, bottomright, bottomleft
local menuSize = 'size-125' -- e.g. 'size-100', 'size-110', 'size-125', 'size-150', 'size-175', 'size-200'
local r, g, b = 220, 20, 60 -- red, green, blue values for the menu background

local MainMenu = MenuV:CreateMenu(false, Lang:t("menu.admin_menu"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:mainmenu')
local SelfMenu = MenuV:CreateMenu(false, Lang:t("menu.admin_options"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:selfmenu')
local PlayerMenu = MenuV:CreateMenu(false, Lang:t("menu.online_players"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:playermenu')
local PlayerGeneralMenu = MenuV:CreateMenu(false, Lang:t("menu.player_general"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:playergeneral')
local PlayerAdminMenu = MenuV:CreateMenu(false, Lang:t("menu.player_administration"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:playeradministration')
local PlayerExtraMenu = MenuV:CreateMenu(false, Lang:t("menu.player_extra"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:playerextra')
local BanMenu = MenuV:CreateMenu(false, Lang:t("menu.ban"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:banmenu')
local KickMenu = MenuV:CreateMenu(false, Lang:t("menu.kick"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:kickmenu')
local PermsMenu = MenuV:CreateMenu(false, Lang:t("menu.permissions"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:permsmenu')
local GiveItemMenu = MenuV:CreateMenu(false, Lang:t("menu.give_item_menu"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:giveitemmenu')
local SoundMenu = MenuV:CreateMenu(false, Lang:t("menu.play_sound"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:soundmenu')
local ServerMenu = MenuV:CreateMenu(false, Lang:t("menu.manage_server"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:servermenu')
local WeatherMenu = MenuV:CreateMenu(false, Lang:t("menu.weather_conditions"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:weathermenu')
local VehicleMenu = MenuV:CreateMenu(false, Lang:t("menu.vehicle_options"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:vehiclemenu')
local VehCategorieMenu = MenuV:CreateMenu(false, Lang:t("menu.vehicle_categories"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:vehcategoriemenu')
local VehNameMenu = MenuV:CreateMenu(false, Lang:t("menu.vehicle_models"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:vehnamemenu')
local DealerMenu = MenuV:CreateMenu(false, Lang:t("menu.dealer_list"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:dealermenu')
local DevMenu = MenuV:CreateMenu(false, Lang:t("menu.developer_options"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:devmenu')

-- Main Menu
local MainMenuButton1 = MainMenu:AddButton({
    icon = '😃',
    label = Lang:t("menu.admin_options"),
    value = SelfMenu,
    description = Lang:t("desc.admin_options_desc")
})
local MainMenuButton2 = MainMenu:AddButton({
    icon = '🙍‍♂️',
    label = Lang:t("menu.player_management"),
    value = PlayerMenu,
    description = Lang:t("desc.player_management_desc")
})
local MainMenuButton3 = MainMenu:AddButton({
    icon = '🎮',
    label = Lang:t("menu.server_management"),
    value = ServerMenu,
    description = Lang:t("desc.server_management_desc")
})
local MainMenuButton4 = MainMenu:AddButton({
    icon = '🚗',
    label = Lang:t("menu.vehicles"),
    value = VehicleMenu,
    description = Lang:t("desc.vehicles_desc")
})
local MainMenuButton5 = MainMenu:AddButton({
    icon = '💊',
    label = Lang:t("menu.dealer_list"),
    value = DealerMenu,
    description = Lang:t("desc.dealer_desc")
})
local MainMenuButton6 = MainMenu:AddButton({
    icon = '🔧',
    label = Lang:t("menu.developer_options"),
    value = DevMenu,
    description = Lang:t("desc.developer_desc")
})

-- SelfMenu
local SelfMenuButton1 = SelfMenu:AddCheckbox({
    icon = '🎥',
    label = Lang:t("menu.noclip"),
    value = SelfMenu,
    description = Lang:t("desc.noclip_desc")
})
SelfMenuButton1:On('change', function(item, newValue, oldValue)
    ToggleNoClipMode()
end)

local SelfMenuButton2 = SelfMenu:AddButton({
    icon = '🏥',
    label = Lang:t("menu.revive"),
    value = 'revive',
    description = Lang:t("desc.revive_desc")
})
SelfMenuButton2:On('select', function(item)
    TriggerEvent('hospital:client:Revive', PlayerPedId())
end)

local SelfMenuButton3 = SelfMenu:AddCheckbox({
    icon = '👻',
    label = Lang:t("menu.invisible"),
    value = SelfMenu,
    description = Lang:t("desc.invisible_desc")
})
local invisible = false
SelfMenuButton3:On('change', function(item, newValue, oldValue)
    invisible = not invisible
    if invisible then
        while invisible do
            Wait(0)
            SetEntityVisible(PlayerPedId(), false, 0)
        end
        SetEntityVisible(PlayerPedId(), true, 0)
    end

end)

local SelfMenuButton4 = SelfMenu:AddCheckbox({
    icon = '⚡',
    label = Lang:t("menu.god"),
    value = SelfMenu,
    description = Lang:t("desc.god_desc")
})
local godmode = false
SelfMenuButton4:On('change', function(item, newValue, oldValue)
    if not godmode then
        godmode = true
        SetPlayerInvincible(PlayerId(), true)
    else
        godmode = false
        SetPlayerInvincible(PlayerId(), false)
    end
end)

local SelfMenuButton5 = SelfMenu:AddCheckbox({
    icon = '📋',
    label = Lang:t("menu.names"),
    value = SelfMenu,
    description = Lang:t("desc.names_desc")
})
SelfMenuButton5:On('change', function()
    TriggerEvent('qb-admin:client:toggleNames')
end)

local SelfMenuButton6 = SelfMenu:AddCheckbox({
    icon = '📍',
    label = Lang:t("menu.blips"),
    value = SelfMenu,
    description = Lang:t("desc.blips_desc")
})
SelfMenuButton6:On('change', function()
    TriggerEvent('qb-admin:client:toggleBlips')
end)

local SelfMenuButton7 = SelfMenu:AddCheckbox({
    icon = '🚔',
    label = Lang:t("menu.vehicle_godmode"),
    value = SelfMenu,
    description = Lang:t("desc.vehicle_godmode")
})
local vehiclegodmode = false
SelfMenuButton7:On('change', function()
    vehiclegodmode = not vehiclegodmode
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehiclegodmode then
        SetEntityInvincible(vehicle, true)
        SetEntityCanBeDamaged(vehicle, false)
        while true do
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehicleFixed(vehicle)
            SetVehicleEngineHealth(vehicle, 1000.0)
            Wait(250)
            if not vehiclegodmode then break end
        end
    else
        SetEntityInvincible(vehicle, false)
        SetEntityCanBeDamaged(vehicle, true)
    end
end)

local SelfMenuButton8 = SelfMenu:AddSlider({
    icon = '📍',
    label = Lang:t("menu.ped"),
    value = '',
    values = {{
        label = Lang:t("menu.ped"),
        value = 'ped',
        description = Lang:t("desc.ped")
    }, {
        label = Lang:t("menu.reset_ped"),
        value ='reset',
        description = Lang:t("desc.reset_ped")
    }},
    select = function(btn, newValue, oldValue)
        if newValue == "ped" then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.ped"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "a_m_m_salton_03",
                        name = "model",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                TriggerServerEvent('QBCore:CallCommand', "setmodel", {dialog.model})
            end
        else
            ExecuteCommand('refreshskin')
        end
    end
})

local SelfMenuButton9 = SelfMenu:AddCheckbox({
    icon = '🔫',
    label = Lang:t("menu.ammo"),
    value = SelfMenu,
    description = Lang:t("desc.ammo")
})
local infiniteammo = false
SelfMenuButton9:On('change', function()
    infiniteammo = not infiniteammo
    local ped = PlayerPedId()
    if infiniteammo then
        while true do
            local weapon = GetSelectedPedWeapon(ped)
            SetPedInfiniteAmmo(ped, true, weapon)
            RefillAmmoInstantly(ped)
            Wait(250)
            if not infiniteammo then break end
        end
    else
        SetPedInfiniteAmmo(ped, false, weapon)
    end
end)

-- PlayerMenu
local function OpenBanMenu(banplayer)
    MenuV:OpenMenu(BanMenu)
    BanMenu:ClearItems()
    local BanMenuButton1 = BanMenu:AddButton({
        icon = '',
        label = Lang:t("info.reason"),
        value = "reason",
        description = Lang:t("desc.ban_reason"),
        select = function(btn)
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.ban_reason"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "VDM",
                        name = "reason",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                banreason = dialog.reason
            end
        end
    })

    local BanMenuButton2 = BanMenu:AddSlider({
        icon = '⏲️',
        label = Lang:t("info.length"),
        value = '3600',
        values = {{
            label = Lang:t("time.1hour"),
            value = '3600',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.6hour"),
            value ='21600',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.12hour"),
            value = '43200',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1day"),
            value = '86400',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.3day"),
            value = '259200',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1week"),
            value = '604800',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1month"),
            value = '2678400',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.3month"),
            value = '8035200',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.6month"),
            value = '16070400',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1year"),
            value = '32140800',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.permenent"),
            value = '99999999999',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.self"),
            value = "self",
            description = Lang:t("time.ban_length")
        }},
        select = function(btn, newValue, oldValue)
            if newValue == "self" then
                local dialog = exports['qb-input']:ShowInput({
                    header = 'Ban Length',
                    submitText = "Confirm",
                    inputs = {
                        {
                            text = "20",
                            name = "lenght",
                            type = "number",
                            isRequired = true
                        }
                    }
                })
                if dialog then
                    banlength = dialog.lenght
                end
            else
                banlength = newValue
            end
        end
    })

    local BanMenuButton3 = BanMenu:AddButton({
        icon = '',
        label = Lang:t("info.confirm"),
        value = "ban",
        description = Lang:t("desc.confirm_ban"),
        select = function(btn)
            if banreason ~= 'Unknown' and banlength ~= nil then
                TriggerServerEvent('qb-admin:server:ban', banplayer, banlength, banreason)
                banreason = 'Unknown'
                banlength = nil
            else
                QBCore.Functions.Notify(Lang:t("error.invalid_reason_length_ban"), 'error')
            end
        end
    })
end

local function OpenKickMenu(kickplayer)
    MenuV:OpenMenu(KickMenu)
    KickMenu:ClearItems()
    local KickMenuButton1 = KickMenu:AddButton({
        icon = '',
        label = Lang:t("info.reason"),
        value = "reason",
        description = Lang:t("desc.kick_reason"),
        select = function(btn)
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.kick_reason"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "VDM",
                        name = "reason",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                kickreason = dialog.reason
            end
        end
    })

    local KickMenuButton2 = KickMenu:AddButton({
        icon = '',
        label = Lang:t("info.confirm"),
        value = "kick",
        description = Lang:t("desc.confirm_kick"),
        select = function(btn)
            if kickreason ~= 'Unknown' then
                TriggerServerEvent('qb-admin:server:kick', kickplayer, kickreason)
                kickreason = 'Unknown'
            else
                QBCore.Functions.Notify(Lang:t("error.missing_reason"), 'error')
            end
        end
    })
end

local function OpenPermsMenu(permsply)
    local selectedgroup = 'Unknown'
    MenuV:OpenMenu(PermsMenu)
    PermsMenu:ClearItems()
    local PermsMenuButton1 = PermsMenu:AddSlider({
        icon = '',
        label = 'Group',
        value = 'user',
        values = {{
            label = 'User',
            value = 'user',
            description = 'Group'
        }, {
            label = 'Admin',
            value = 'admin',
            description = 'Group'
        }, {
            label = 'God',
            value = 'god',
            description = 'Group'
        }},
        change = function(item, newValue, oldValue)
            local vcal = newValue
            if vcal == 1 then
                selectedgroup = {}
                selectedgroup[#selectedgroup+1] = {rank = "user", label = "User"}
            elseif vcal == 2 then
                selectedgroup = {}
                selectedgroup[#selectedgroup+1] = {rank = "admin", label = "Admin"}
            elseif vcal == 3 then
                selectedgroup = {}
                selectedgroup[#selectedgroup+1] = {rank = "god", label = "God"}
            end
        end
    })

    local PermsMenuButton2 = PermsMenu:AddButton({
        icon = '',
        label = Lang:t("info.confirm"),
        value = "giveperms",
        description = 'Give the permission group',
        select = function(btn)
            if selectedgroup ~= 'Unknown' then
                TriggerServerEvent('qb-admin:server:setPermissions', permsply.id, selectedgroup)
                selectedgroup = 'Unknown'
            else
                QBCore.Functions.Notify(Lang:t("error.changed_perm_failed"), 'error')
            end
        end
    })
end

local function OpenGiveItemMenu(player)
    MenuV:OpenMenu(GiveItemMenu)
    GiveItemMenu:ClearItems()
    local GiveItemMenuButton1 = GiveItemMenu:AddButton({
        icon = '',
        label = Lang:t("info.item"),
        value = "reason",
        description = Lang:t("desc.item"),
        select = function(btn)
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.item"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "Lockpick",
                        name = "item",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                itemname = dialog.item
            end
        end
    })
    local GiveItemMenuButton2 = GiveItemMenu:AddButton({
        icon = '',
        label = Lang:t("info.amount"),
        value = "reason",
        description = Lang:t("desc.amount"),
        select = function(btn)
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.amount"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "Lockpick",
                        name = "amount",
                        type = "number",
                        isRequired = true
                    }
                }
            })
            if dialog then
                itemamount = dialog.amount
            end
        end
    })
    local GiveItemMenuButton3 = GiveItemMenu:AddButton({
        icon = '',
        label = Lang:t("info.confirm"),
        value = "kick",
        description = Lang:t("desc.confirm_kick"),
        select = function(btn)
            if itemname ~= 'Unknown' and itemamount ~= 0 then
                TriggerServerEvent('QBCore:CallCommand', "giveitem", {player.id, itemname, itemamount})
                itemname = 'Unknown'
                itemamount = 0
            else
                QBCore.Functions.Notify(Lang:t("error.give_item"), 'error')
            end
        end
    })
end

local function OpenSoundMenu(player)
    MenuV:OpenMenu(SoundMenu)
    SoundMenu:ClearItems()
    local SoundMenuButton1 = SoundMenu:AddButton({
        icon = '',
        label = Lang:t("info.sound"),
        value = "reason",
        description = Lang:t("desc.sound"),
        select = function(btn)
            TriggerServerEvent('qb-admin:server:getsounds')
        end
    })
    local SoundMenuButton2 = SoundMenu:AddSlider({
        icon = '',
        label = Lang:t("volume.volume"),
        value = '0.5',
        values = {{
            label = Lang:t("volume.01"),
            value = 0.1,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.02"),
            value = 0.2,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.03"),
            value = 0.3,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.04"),
            value = 0.4,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.05"),
            value = 0.5,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.06"),
            value = 0.6,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.07"),
            value = 0.7,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.08"),
            value = 0.8,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.09"),
            value = 0.9,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.1.0"),
            value = 1.0,
            description = Lang:t("volume.volume")
        }, {
            label = Lang:t("volume.self"),
            value = "self",
            description = Lang:t("volume.volume")
        }},
        description = Lang:t("volume.volume_desc"),
        select = function(btn, newValue, oldValue)
            if newValue == "self" then
                local dialog = exports['qb-input']:ShowInput({
                    header = Lang:t("volume.volume_desc"),
                    submitText = "Confirm",
                    inputs = {
                        {
                            text = "0.6",
                            name = "volume",
                            type = "text",
                            isRequired = true
                        }
                    }
                })
                if dialog then
                    soundvolume = tonumber(dialog.volume)
                end
            else
                soundvolume = newValue
            end
        end
    })
    local SoundMenuButton3 = SoundMenu:AddSlider({
        icon = '',
        label = Lang:t("volume.radius"),
        value = '0.5',
        values = {{
            label = Lang:t("volume.10"),
            value = 10,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.20"),
            value = 20,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.30"),
            value = 30,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.40"),
            value = 40,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.50"),
            value = 50,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.60"),
            value = 60,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.70"),
            value = 70,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.80"),
            value = 80,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.90"),
            value = 90,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.100"),
            value = 100,
            description = Lang:t("volume.radius")
        }, {
            label = Lang:t("volume.self"),
            value = "self",
            description = Lang:t("volume.radius")
        }},
        description = Lang:t("volume.radius_desc"),
        select = function(btn, newValue, oldValue)
            if newValue == "self" then
                local dialog = exports['qb-input']:ShowInput({
                    header = Lang:t("volume.radius_desc"),
                    submitText = "Confirm",
                    inputs = {
                        {
                            text = "30",
                            name = "volume",
                            type = "number",
                            isRequired = true
                        }
                    }
                })
                if dialog then
                    soundrange = tonumber(dialog.volume)
                end
            else
                soundrange = newValue
            end
        end
    })
    local SoundMenuButton4 = SoundMenu:AddButton({
        icon = '',
        label = Lang:t("info.confirm_play"),
        value = '',
        description = Lang:t("desc.confirm_play"),
        select = function(btn)
            if soundname ~= 'Unknown' and soundvolume ~= 0 then
                TriggerServerEvent('InteractSound_SV:PlayOnOne', player.id, soundname, soundvolume)
            else
                QBCore.Functions.Notify(Lang:t("error.give_item"), 'error')
            end
        end
    })
    local SoundMenuButton5 = SoundMenu:AddButton({
        icon = '',
        label = Lang:t("info.confirm_play_radius"),
        value = '',
        description = Lang:t("desc.confirm_play_radius"),
        select = function(btn)
            if soundname ~= 'Unknown' and soundvolume ~= 0 and soundrange ~= 0 then
                TriggerServerEvent('qb-admin:server:playsound', player.id, soundname, soundvolume, soundrange)
            else
                QBCore.Functions.Notify(Lang:t("error.give_item"), 'error')
            end
        end
    })
end

local function OpenPlayerMenus(player)
    local Players = MenuV:CreateMenu(false, player.cid ..' '.. Lang:t("info.options"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv') -- Players Sub Menu
    Players:ClearItems()
    MenuV:OpenMenu(Players)
    local PlayersButton1 = Players:AddButton({
        icon = '🛠️',
        label = Lang:t("menu.player_general"),
        value = PlayerGeneralMenu,
        description = Lang:t("desc.admin_options_desc")
    })
    PlayersButton1:On('select', function(item)
        PlayerGeneralMenu:ClearItems()
        local elements = {
            [1] = {
                icon = '💀',
                label = Lang:t("menu.kill"),
                value = "kill",
                description = Lang:t("menu.kill").. " " .. player.cid
            },
            [2] = {
                icon = '🏥',
                label = Lang:t("menu.revive"),
                value = "revive",
                description = Lang:t("menu.revive") .. " " .. player.cid
            },
            [3] = {
                icon = '🥶',
                label = Lang:t("menu.freeze"),
                value = "freeze",
                description = Lang:t("menu.freeze") .. " " .. player.cid
            },
            [4] = {
                icon = '👀',
                label = Lang:t("menu.spectate"),
                value = "spectate",
                description = Lang:t("menu.spectate") .. " " .. player.cid
            },
            [5] = {
                icon = '➡️',
                label = Lang:t("info.goto"),
                value = "goto",
                description = Lang:t("info.goto") .. " " .. player.cid .. Lang:t("info.position")
            },
            [6] = {
                icon = '⬅️',
                label = Lang:t("menu.bring"),
                value = "bring",
                description = Lang:t("menu.bring") .. " " .. player.cid .. " " .. Lang:t("info.your_position")
            },
            [7] = {
                icon = '🚗',
                label = Lang:t("menu.sit_in_vehicle"),
                value = "intovehicle",
                description = Lang:t("desc.sit_in_veh_desc") .. " " .. player.cid .. " " .. Lang:t("desc.sit_in_veh_desc2")
            }
        }
        for k, v in ipairs(elements) do
            local PlayerGeneralButton = PlayerGeneralMenu:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    TriggerServerEvent('qb-admin:server:'..values, player)
                end
            })
        end    
    end)

    local PlayersButton2 = Players:AddButton({
        icon = '🧾',
        label = Lang:t("menu.player_administration"),
        value = PlayerAdminMenu,
        description = Lang:t("desc.player_administration")
    })
    PlayersButton2:On('select', function(item)
        PlayerAdminMenu:ClearItems()
        local elements = {
            [1] = {
                icon = '🥾',
                label = Lang:t("menu.kick"),
                value = "kick",
                description = Lang:t("menu.kick") .. " " .. player.cid .. " " .. Lang:t("info.reason")
            },
            [2] = {
                icon = '🚫',
                label = Lang:t("menu.ban"),
                value = "ban",
                description = Lang:t("menu.ban") .. " " .. player.cid .. " " .. Lang:t("info.reason")
            },
            [3] = {
                icon = '🎟️',
                label = Lang:t("menu.permissions"),
                value = "perms",
                description = Lang:t("info.give") .. " " .. player.cid .. " " .. Lang:t("menu.permissions")
            }
        }
        for k, v in ipairs(elements) do
            local PlayerAdminButton = PlayerAdminMenu:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    if values == 'ban' then
                        OpenBanMenu(player)
                    elseif values == 'kick' then
                        OpenKickMenu(player)                   
                    elseif values == 'perms' then
                        OpenPermsMenu(player)                    
                    end
                end
            })
        end    
    end)

    local PlayersButton3 = Players:AddButton({
        icon = '🕹️',
        label = Lang:t("menu.player_extra"),
        value = PlayerExtraMenu,
        description = Lang:t("desc.player_extra_desc")
    })
    PlayersButton3:On('select', function(item)
        PlayerExtraMenu:ClearItems()
        local elements = {
            [1] = {
                icon = '🎒',
                label = Lang:t("menu.open_inv"),
                value = "inventory",
                description = Lang:t("info.open") .. " " .. player.cid .. Lang:t("info.inventories")
            },
            [2] = {
                icon = '👕',
                label = Lang:t("menu.give_clothing_menu"),
                value = "cloth",
                description = Lang:t("desc.clothing_menu_desc") .. " " .. player.cid
            },
            [3] = {
                icon = '🏒',
                label = Lang:t("menu.give_item_menu"),
                value = "giveitem",
                description = Lang:t("desc.give_item_menu_desc") .. " " .. player.cid
            },
            [4] = {
                icon = '🎵',
                label = Lang:t("menu.play_sound"),
                value = "sound",
                description = Lang:t("desc.play_sound") .. " " .. player.cid
            },
        }
        for k, v in ipairs(elements) do
            local PlayerExtraButton = PlayerExtraMenu:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    if values == 'inventory' then
                        TriggerEvent('qb-admin:client:inventory', player.id)
                    elseif values == 'giveitem' then
                        OpenGiveItemMenu(player)
                    elseif values == 'sound' then
                        OpenSoundMenu(player)
                    else
                        TriggerServerEvent('qb-admin:server:'..values, player)
                    end
                end
            })
        end    
    end)
end

MainMenuButton2:On('select', function(item)
    PlayerMenu:ClearItems()
    QBCore.Functions.TriggerCallback('qb-adminmenu:callback:getplayers', function(players)
        for k, v in pairs(players) do
            local menu_button10 = PlayerMenu:AddButton({
                label = Lang:t("info.id") .. v["id"] .. ' | ' .. v["name"],
                value = v,
                description = Lang:t("info.player_name"),
                select = function(btn)
                    local select = btn.Value -- get all the values from v!
                    OpenPlayerMenus(select) -- only pass what i select nothing else
                end
            })
        end
    end)
end)

-- ServerMenu
local ServerMenuButton1 = ServerMenu:AddButton({
    icon = '🌡️',
    label = Lang:t("menu.weather_options"),
    value = WeatherMenu,
    description = Lang:t("desc.weather_desc")
})
ServerMenuButton1:On("select",function()
    WeatherMenu:ClearItems()
    local elements = {
        [1] = {
            icon = '☀️',
            label = Lang:t("weather.extra_sunny"),
            value = "EXTRASUNNY",
            description = Lang:t("weather.extra_sunny_desc")
        },
        [2] = {
            icon = '☀️',
            label = Lang:t("weather.clear"),
            value = "CLEAR",
            description = Lang:t("weather.clear_desc")
        },
        [3] = {
            icon = '☀️',
            label = Lang:t("weather.neutral"),
            value = "NEUTRAL",
            description = Lang:t("weather.neutral_desc")
        },
        [4] = {
            icon = '🌁',
            label = Lang:t("weather.smog"),
            value = "SMOG",
            description = Lang:t("weather.smog_desc")
        },
        [5] = {
            icon = '🌫️',
            label = Lang:t("weather.foggy"),
            value = "FOGGY",
            description = Lang:t("weather.foggy_desc")
        },
        [6] = {
            icon = '⛅',
            label = Lang:t("weather.overcast"),
            value = "OVERCAST",
            description = Lang:t("weather.overcast_desc")
        },
        [7] = {
            icon = '☁️',
            label = Lang:t("weather.clouds"),
            value = "CLOUDS",
            description = Lang:t("weather.clouds_desc")
        },
        [8] = {
            icon = '🌤️',
            label = Lang:t("weather.clearing"),
            value = "CLEARING",
            description = Lang:t("weather.clearing_desc")
        },
        [9] = {
            icon = '☂️',
            label = Lang:t("weather.rain"),
            value = "RAIN",
            description = Lang:t("weather.rain_desc")
        },

        [10] = {
            icon = '⛈️',
            label = Lang:t("weather.thunder"),
            value = "THUNDER",
            description = Lang:t("weather.thunder_desc")
        },
        [11] = {
            icon = '❄️',
            label = Lang:t("weather.snow"),
            value = "SNOW",
            description = Lang:t("weather.snow_desc")
        },
        [12] = {
            icon = '🌨️',
            label = Lang:t("weather.blizzard"),
            value = "BLIZZARD",
            description = Lang:t("weather.blizzed_desc")
        },
        [13] = {
            icon = '❄️',
            label = Lang:t("weather.light_snow"),
            value = "SNOWLIGHT",
            description = Lang:t("weather.light_snow_desc")
        },
        [14] = {
            icon = '🌨️',
            label = Lang:t("weather.heavy_snow"),
            value = "XMAS",
            description = Lang:t("weather.heavy_snow_desc")
        },
        [15] = {
            icon = '🎃',
            label = Lang:t("weather.halloween"),
            value = "HALLOWEEN",
            description = Lang:t("weather.halloween_desc")
        }
    }
    for k, v in ipairs(elements) do
        local WeatherButton = WeatherMenu:AddButton({icon = v.icon,label = v.label,value = v,description = v.description,select = function(btn)
            local selection = btn.Value
            TriggerServerEvent('qb-weathersync:server:setWeather', selection.value)
            QBCore.Functions.Notify(Lang:t("weather.weather_changed", {value = selection.label}))
        end})
    end
end)

local ServerMenuButton2 = ServerMenu:AddSlider({
    icon = '⏲️',
    label = Lang:t("menu.server_time"),
    value = GetClockHours(),
    values = {{
        label = '00',
        value = '00',
        description = Lang:t("menu.time")
    }, {
        label = '01',
        value = '01',
        description = Lang:t("menu.time")
    }, {
        label = '02',
        value = '02',
        description = Lang:t("menu.time")
    }, {
        label = '03',
        value = '03',
        description = Lang:t("menu.time")
    }, {
        label = '04',
        value = '04',
        description = Lang:t("menu.time")
    }, {
        label = '05',
        value = '05',
        description = Lang:t("menu.time")
    }, {
        label = '06',
        value = '06',
        description = Lang:t("menu.time")
    }, {
        label = '07',
        value = '07',
        description = Lang:t("menu.time")
    }, {
        label = '08',
        value = '08',
        description = Lang:t("menu.time")
    }, {
        label = '09',
        value = '09',
        description = Lang:t("menu.time")
    }, {
        label = '10',
        value = '10',
        description = Lang:t("menu.time")
    }, {
        label = '11',
        value = '11',
        description = Lang:t("menu.time")
    }, {
        label = '12',
        value = '12',
        description = Lang:t("menu.time")
    }, {
        label = '13',
        value = '13',
        description = Lang:t("menu.time")
    }, {
        label = '14',
        value = '14',
        description = Lang:t("menu.time")
    }, {
        label = '15',
        value = '15',
        description = Lang:t("menu.time")
    }, {
        label = '16',
        value = '16',
        description = Lang:t("menu.time")
    }, {
        label = '17',
        value = '17',
        description = Lang:t("menu.time")
    }, {
        label = '18',
        value = '18',
        description = Lang:t("menu.time")
    }, {
        label = '19',
        value = '19',
        description = Lang:t("menu.time")
    }, {
        label = '20',
        value = '20',
        description = Lang:t("menu.time")
    }, {
        label = '21',
        value = '21',
        description = Lang:t("menu.time")
    }, {
        label = '22',
        value = '22',
        description = Lang:t("menu.time")
    }, {
        label = '23',
        value = '23',
        description = Lang:t("menu.time")
    }}
})
ServerMenuButton2:On("select", function(item, value)
    TriggerServerEvent("qb-weathersync:server:setTime", value, value)
    QBCore.Functions.Notify(Lang:t("time.changed", {time = value}))
end)

-- Vehicle Menu
local function OpenCarModelsMenu(category)
    VehNameMenu:ClearItems()
    MenuV:OpenMenu(VehNameMenu)
    for k, v in pairs(category) do
        local menu_button10 = VehNameMenu:AddButton({
            label = v["name"],
            value = k,
            description = 'Spawn ' .. v["name"],
            select = function(btn)
                TriggerServerEvent('qb-admin:server:spawnVehicle', k)
            end
        })
    end
end

local VehicleMenuButton1 = VehicleMenu:AddButton({
    icon = '🚗',
    label = Lang:t("menu.spawn_vehicle"),
    value = VehCategorieMenu,
    description = Lang:t("desc.spawn_vehicle_desc")
})
local vehicles = {}
VehicleMenuButton1:On('Select', function(item)
    VehCategorieMenu:ClearItems()
    for k, v in pairs(QBCore.Shared.Vehicles) do
        local category = v["category"]
        if vehicles[category] == nil then
            vehicles[category] = { }
        end
        vehicles[category][k] = v
    end
    for k, v in pairs(vehicles) do
        local menu_button10 = VehCategorieMenu:AddButton({
            label = k,
            value = v,
            description = Lang:t("menu.category_name"),
            select = function(btn)
                local select = btn.Value
                OpenCarModelsMenu(select)
            end
        })
    end
end)

local VehicleMenuButton2 = VehicleMenu:AddButton({
    icon = '🔧',
    label = Lang:t("menu.fix_vehicle"),
    value = 'fix',
    description = Lang:t("desc.fix_vehicle_desc")
})
VehicleMenuButton2:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "fix", {})
end)

local VehicleMenuButton3 = VehicleMenu:AddButton({
    icon = '💲',
    label = Lang:t("menu.buy"),
    value = 'buy',
    description = Lang:t("desc.buy_desc")
})
VehicleMenuButton3:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "admincar", {})
end)

local VehicleMenuButton4 = VehicleMenu:AddButton({
    icon = '☠',
    label = Lang:t("menu.remove_vehicle"),
    value = 'remove',
    description = Lang:t("desc.remove_vehicle_desc")
})
VehicleMenuButton4:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "dv", {})
end)

-- Dealer Menu
local function OpenDealerMenu(dealer)
    local EditDealer = MenuV:CreateMenu(false, Lang:t("menu.edit_dealer") .. dealer["name"], menuLocation, r, g, b, menuSize, 'qbcore', 'menuv')
    EditDealer:ClearItems()
    MenuV:OpenMenu(EditDealer)
    local elements = {
        [1] = {
            icon = '➡️',
            label = Lang:t("info.goto") .. " " .. dealer["name"],
            value = "goto",
            description = Lang:t("desc.dealergoto_desc") .. " " .. dealer["name"]
        },
        [2] = {
            icon = "☠",
            label = Lang:t("info.remove") .. " " .. dealer["name"],
            value = "remove",
            description = Lang:t("desc.dealerremove_desc") .. " " .. dealer["name"]
        }
    }
    for k, v in ipairs(elements) do
        local EditDealerButton = EditDealer:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values == "goto" then
                    TriggerServerEvent('QBCore:CallCommand', "dealergoto", { dealer["name"] })
                elseif values == "remove" then
                    TriggerServerEvent('QBCore:CallCommand', "deletedealer", { dealer["name"] })
                    EditDealer:Close()
                    DealerMenu:Close()
                end
            end
        })
    end
end

MainMenuButton5:On('Select', function(item)
    DealerMenu:ClearItems()
    QBCore.Functions.TriggerCallback('qb-adminmenu:callback:getdealers', function(dealers)
        for k, v in pairs(dealers) do
            local DealerMenuButton1 = DealerMenu:AddButton({
                label = v["name"],
                value = v,
                description = Lang:t("menu.dealer_name"),
                select = function(btn)
                    local select = btn.Value
                    OpenDealerMenu(select)
                end
            })
        end
    end)
end)

-- Developer Menu
local function round(input, decimalPlaces)
    return tonumber(string.format("%." .. (decimalPlaces or 0) .. "f", input))
end

local function CopyToClipboard(dataType)
    local ped = PlayerPedId()
    if dataType == 'coords3' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        SendNUIMessage({
            string = string.format('vector3(%s, %s, %s)', x, y, z)
        })
        QBCore.Functions.Notify(Lang:t("success.coords_copied"), "success")
    elseif dataType == 'coords4' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({
            string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
        })
        QBCore.Functions.Notify(Lang:t("success.coords_copied"), "success")
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({
            string = h
        })
        QBCore.Functions.Notify(Lang:t("success.heading_copied"), "success")
    end
end

local function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end

local function ToggleShowCoordinates()
    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    CreateThread(function()
        while showCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = round(coords.x, 2)
            c.y = round(coords.y, 2)
            c.z = round(coords.z, 2)
            heading = round(heading, 2)
            Wait(0)
            Draw2DText(string.format('~w~'..Lang:t("info.ped_coords") .. '~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end

local function ToggleVehicleDeveloperMode()
    local x = 0.4
    local y = 0.888
    vehicleDevMode = not vehicleDevMode
    CreateThread(function()
        while vehicleDevMode do
            local ped = PlayerPedId()
            Wait(0)
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local netID = VehToNet(vehicle)
                local hash = GetEntityModel(vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                local eHealth = GetVehicleEngineHealth(vehicle)
                local bHealth = GetVehicleBodyHealth(vehicle)
                Draw2DText(Lang:t("info.vehicle_dev_data"), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
                Draw2DText(string.format(Lang:t("info.ent_id") .. '~b~%s~s~ | ' .. Lang:t("info.net_id") .. '~b~%s~s~', vehicle, netID), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.025)
                Draw2DText(string.format(Lang:t("info.model") .. '~b~%s~s~ | ' .. Lang:t("info.hash") .. '~b~%s~s~', modelName, hash), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.050)
                Draw2DText(string.format(Lang:t("info.eng_health") .. '~b~%s~s~ | ' .. Lang:t("info.body_health") .. '~b~%s~s~', round(eHealth, 2), round(bHealth, 2)), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.075)
            end
        end
    end)
end

local DevMenuButton1 = DevMenu:AddButton({
    icon = '📋',
    label = Lang:t("menu.copy_vector3"),
    value = 'coords',
    description = Lang:t("desc.vector3_desc")
})
DevMenuButton1:On("select", function()
    CopyToClipboard('coords3')
end)

local DevMenuButton2 = DevMenu:AddButton({
    icon = '📋',
    label = Lang:t("menu.copy_vector4"),
    value = 'coords',
    description = Lang:t("desc.vector4_desc")
})
DevMenuButton2:On("select", function()
    CopyToClipboard('coords4')
end)

local DevMenuButton3 = DevMenu:AddCheckbox({
    icon = '📍',
    label = Lang:t("menu.display_coords"),
    value = nil,
    description = Lang:t("desc.display_coords_desc")
})
DevMenuButton3:On('change', function()
    ToggleShowCoordinates()
end)

local DevMenuButton4 = DevMenu:AddButton({
    icon = '📋',
    label = Lang:t("menu.copy_heading"),
    value = 'heading',
    description = Lang:t("desc.copy_heading_desc")
})
DevMenuButton4:On("select", function()
    CopyToClipboard('heading')
end)

local DevMenuButton5 = DevMenu:AddButton({
    icon = '🚘',
    label = Lang:t("menu.vehicle_dev_mode"),
    value = nil,
    description = Lang:t("desc.vehicle_dev_mode_desc")
})
DevMenuButton5:On('select', function()
    ToggleVehicleDeveloperMode()
end)

local DevMenuButton6 = DevMenu:AddCheckbox({
    icon = '⚫',
    label = Lang:t("menu.hud_dev_mode"),
    value = DevMenu,
    description = Lang:t("desc.hud_dev_mode_desc")
})
local dev = false
DevMenuButton6:On('change', function(item, newValue, oldValue)
    dev = not dev
    TriggerEvent('qb-admin:client:ToggleDevmode')
    if dev then
        SetPlayerInvincible(PlayerId(), true)
        while dev do
            TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + 10)
            TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + 10)    
            Wait(5000)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)

local DevMenuButton7 = DevMenu:AddCheckbox({
    icon = '🔫',
    label = Lang:t("menu.delete_laser"),
    value = DevMenu,
    description = Lang:t("desc.delete_laser_desc")
})
local deleteLazer = false
DevMenuButton7:On('change', function(item, newValue, oldValue)
    deleteLazer = not deleteLazer
end)

local DevMenuButton8 = DevMenu:AddCheckbox({
    icon = '🎥',
    label = Lang:t("menu.noclip"),
    value = DevMenu,
    description = Lang:t("desc.noclip_desc")
})
DevMenuButton8:On('change', function(item, newValue, oldValue)
    ToggleNoClipMode()
end)

-- NetEvents
RegisterNetEvent('qb-admin:client:openMenu', function()
    MenuV:OpenMenu(MainMenu)
end)

RegisterNetEvent('qb-admin:client:ToggleCoords', function()
    QBCore.Functions.TriggerCallback('qb-adminmenu:callback:haspermission', function(has)
        if has then
            ToggleShowCoordinates()
        end
    end)
end)

RegisterNetEvent('qb-admin:client:openSoundMenu', function(data)
    soundname = data.name
end)

RegisterNetEvent('qb-admin:client:playsound', function(name, volume, radius)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', radius, name, volume)
end)

-- Functions
local function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

local function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim =
	{
		x = 0.5*(max.x - min.x),
		y = 0.5*(max.y - min.y),
		z = 0.5*(max.z - min.z)
	}

    local FUR =
    {
		x = position.x + dim.y*rightVector.x + dim.x*forwardVector.x + dim.z*upVector.x,
		y = position.y + dim.y*rightVector.y + dim.x*forwardVector.y + dim.z*upVector.y,
		z = 0
    }

    local FUR_bool, FUR_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    FUR.z = FUR_z
    FUR.z = FUR.z + 2 * dim.z

    local BLL =
    {
        x = position.x - dim.y*rightVector.x - dim.x*forwardVector.x - dim.z*upVector.x,
        y = position.y - dim.y*rightVector.y - dim.x*forwardVector.y - dim.z*upVector.y,
        z = 0
    }
    local BLL_bool, BLL_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    BLL.z = BLL_z

    -- DEBUG
    local edge1 = BLL
    local edge5 = FUR

    local edge2 =
    {
        x = edge1.x + 2 * dim.y*rightVector.x,
        y = edge1.y + 2 * dim.y*rightVector.y,
        z = edge1.z + 2 * dim.y*rightVector.z
    }

    local edge3 =
    {
        x = edge2.x + 2 * dim.z*upVector.x,
        y = edge2.y + 2 * dim.z*upVector.y,
        z = edge2.z + 2 * dim.z*upVector.z
    }

    local edge4 =
    {
        x = edge1.x + 2 * dim.z*upVector.x,
        y = edge1.y + 2 * dim.z*upVector.y,
        z = edge1.z + 2 * dim.z*upVector.z
    }

    local edge6 =
    {
        x = edge5.x - 2 * dim.y*rightVector.x,
        y = edge5.y - 2 * dim.y*rightVector.y,
        z = edge5.z - 2 * dim.y*rightVector.z
    }

    local edge7 =
    {
        x = edge6.x - 2 * dim.z*upVector.x,
        y = edge6.y - 2 * dim.z*upVector.y,
        z = edge6.z - 2 * dim.z*upVector.z
    }

    local edge8 =
    {
        x = edge5.x - 2 * dim.z*upVector.x,
        y = edge5.y - 2 * dim.z*upVector.y,
        z = edge5.z - 2 * dim.z*upVector.z
    }

    DrawLine(edge1.x, edge1.y, edge1.z, edge2.x, edge2.y, edge2.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge3.x, edge3.y, edge3.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge6.x, edge6.y, edge6.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge7.x, edge7.y, edge7.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge5.x, edge5.y, edge5.z, color.r, color.g, color.b, color.a)
    DrawLine(edge4.x, edge4.y, edge4.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
end

CreateThread(function()	-- While loop needed for delete lazer
	while true do
		sleep = 1000
		if deleteLazer then
		    sleep = 5
		    local color = {r = 255, g = 50, b = 50, a = 200} -- Changes the color of the lines (currently red)
		    local position = GetEntityCoords(PlayerPedId())
		    local hit, coords, entity = RayCastGamePlayCamera(1000.0)
		    -- If entity is found then verifie entity
		    if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                local entityCoord = GetEntityCoords(entity)
                DrawEntityBoundingBox(entity, color)
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                Draw2DText(Lang:t("info.health") .. ': ~g~'..GetEntityHealth(entity)..' ~w~' .. Lang:t("info.speed") .. ': ~b~'..GetEntitySpeed(entity)..'~w~', 4, {255, 255, 255}, 0.4, 0.55, 0.888 - 0.050)
                Draw2DText(Lang:t("info.networked") .. ': ~b~'..tostring(NetworkGetEntityIsNetworked(entity))..' ~w~' .. Lang:t("info.networked_owner_id") ..': ~b~'..GetPlayerServerId(NetworkGetEntityOwner(entity))..'~w~', 4, {255, 255, 255}, 0.4, 0.55, 0.888 - 0.025)
                Draw2DText(Lang:t("info.obj") .. ': ~b~' .. entity .. '~w~ ' .. Lang:t("info.model") .. ': ~b~' .. GetEntityModel(entity), 4, {255, 255, 255}, 0.4, 0.55, 0.888)
                Draw2DText(Lang:t("info.delete_object_info"), 4, {255, 255, 255}, 0.4, 0.55, 0.888 + 0.025)

                if IsControlJustReleased(0, 38) then -- When E pressed then remove targeted entity
                    SetEntityAsMissionEntity(entity, true, true) -- Set as missionEntity so the object can be remove (Even map objects)
                    NetworkRequestControlOfEntity(entity) -- Request Network control so we own the object
                    Wait(250) -- Safety Wait
                    DeleteEntity(entity) -- Delete the object
                    DeleteObject(entity) -- Delete the object (failsafe)
                    SetEntityAsNoLongerNeeded(entity) -- Tells the engine this prop isnt needed anymore
                end
		    -- Only draw of not center of map
		    elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
			    -- Draws line to targeted position
			    DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
			    DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
            end
		end
		Wait(sleep)
	end
end)
