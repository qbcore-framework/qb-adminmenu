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
  DisplayOnscreenKeyboard(1, text or "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
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
    DisplayOnscreenKeyboard(1, text or "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0)
      Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
      local result = GetOnscreenKeyboardResult()
      return tonumber(result)
    end
end