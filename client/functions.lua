-- Variables

local blockedPeds = {
  "mp_m_freemode_01",
  "mp_f_freemode_01",
  "tony",
  "g_m_m_chigoon_02_m",
  "u_m_m_jesus_01",
  "a_m_y_stbla_m",
  "ig_terry_m",
  "a_m_m_ktown_m",
  "a_m_y_skater_m",
  "u_m_y_coop",
  "ig_car3guy1_m",
}

local showCoords = false
local vehicleDevMode = false

-- Functions

function ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(0, 1)
end

function LoadPlayerModel(skin)
  RequestModel(skin)
  while not HasModelLoaded(skin) do
    Citizen.Wait(0)
  end
end

function isPedAllowedRandom(skin)
  local retval = false
  for k, v in pairs(blockedPeds) do
      if v ~= skin then
          retval = true
      end
  end
  return retval
end

function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        tprint(v, indent+1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))
      else
        print(formatting .. v)
      end
    end
end

function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0)
    Wait(0)
  end

  if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
      return result
  end
end

function LocalInputInt(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0)
      Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
      local result = GetOnscreenKeyboardResult()
      return tonumber(result)
    end
end

function CopyToClipboard(dataType)
  local ped = PlayerPedId()
  if dataType == 'coords' then
      local coords = GetEntityCoords(ped)
      local x = math.round(coords.x, 2)
      local y = math.round(coords.y, 2)
      local z = math.round(coords.z, 2)
      SendNUIMessage({
          string = string.format('vector3(%s, %s, %s)', x, y, z)
      })
      QBCore.Functions.Notify("Coordinates copied to clipboard!", "success")
  elseif dataType == 'heading' then
      local heading = GetEntityHeading(ped)
      local h = math.round(heading, 2)
      SendNUIMessage({
          string = h
      })
      QBCore.Functions.Notify("Heading copied to clipboard!", "success")
  end
end

function ToggleShowCoordinates()
    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    Citizen.CreateThread(function()
        while showCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = math.round(coords.x, 2)
            c.y = math.round(coords.y, 2)
            c.z = math.round(coords.z, 2)
            heading = math.round(heading, 2)
            Citizen.Wait(0)
            Draw2DText(string.format('~w~Ped Coordinates:~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end

function ToggleVehicleDeveloperMode()
  local x = 0.4
  local y = 0.888
  vehicleDevMode = not vehicleDevMode
  Citizen.CreateThread(function()
      while vehicleDevMode do
          local ped = PlayerPedId()
          Citizen.Wait(0)
          if IsPedInAnyVehicle(ped, false) then
              local vehicle = GetVehiclePedIsIn(ped, false)
              local netID = VehToNet(vehicle)
              local hash = GetEntityModel(vehicle)
              local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
              local eHealth = GetVehicleEngineHealth(vehicle)
              local bHealth = GetVehicleBodyHealth(vehicle)
              Draw2DText('Vehicle Developer Data:', 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
              Draw2DText(string.format('Entity ID: ~b~%s~s~ | Net ID: ~b~%s~s~', vehicle, netID), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.025)
              Draw2DText(string.format('Model: ~b~%s~s~ | Hash: ~b~%s~s~', modelName, hash), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.050)
              Draw2DText(string.format('Engine Health: ~b~%s~s~ | Body Health: ~b~%s~s~', math.round(eHealth, 2), math.round(bHealth, 2)), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.075)
          end
      end
  end)
end

--------------------------------------------------------------------------------------------
-- UTILITY FOR ToggleVehicleDeveloperMode() and Delete Lazer
--------------------------------------------------------------------------------------------

function Draw2DText(content, font, colour, scale, x, y)
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

function math.round(input, decimalPlaces)
  return tonumber(string.format("%." .. (decimalPlaces or 0) .. "f", input))
end