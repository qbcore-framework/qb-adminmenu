local FreezeEntities        = false
local EntityViewDistance    = 10
local EntityViewEnabled     = false

local EntityFreeAim         = false
local EntityPedView         = false
local EntityObjectView      = false
local EntityVehicleView     = false

local CanEntityBeUsed = function(ped)
    if ped == PlayerPedId() then
        return false
    end
    return true
end

local RoundFloat = function(number, num)
    return math.floor(number*math.pow(10,num)+0.5) / math.pow(10,num)
end

local RoundVector3 = function(vector, num)
    return 'vector3('..RoundFloat(vector.x, num).. ', '..RoundFloat(vector.y, num).. ', '..RoundFloat(vector.z, num)..')'
end

local DrawTitle = function(text, width, height)
    SetTextScale(0.50, 0.50)
    SetTextFont(4)
    SetTextDropshadow(1.0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextColour(255, 255, 255, 215)
    SetTextJustification(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.02)

    local topPadding = 0.01
    local offSetY = height/2+topPadding
    DrawRect(0.5, offSetY, width, height, 11, 11, 11, 200)
end

local RotationToDirection = function(rotation)
	local adjustedRotation = {
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction = {
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local RayCastGamePlayCamera = function(distance)
    -- Checks to see if the Gameplay Cam is Rendering or another is rendering (no clip functionality)
    local currentRenderingCam = false
    if not IsGameplayCamRendering() then
        currentRenderingCam = GetRenderingCam()      
    end

    local cameraRotation = not currentRenderingCam and GetGameplayCamRot() or GetCamRot(currentRenderingCam, 2)
    local cameraCoord = not currentRenderingCam and GetGameplayCamCoord() or GetCamCoord(currentRenderingCam)
	local direction = RotationToDirection(cameraRotation)
	local destination =	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

local DrawEntityBoundingBox = function(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim =	{
		x = 0.5*(max.x - min.x),
		y = 0.5*(max.y - min.y),
		z = 0.5*(max.z - min.z)
	}

    local FUR = {
		x = position.x + dim.y*rightVector.x + dim.x*forwardVector.x + dim.z*upVector.x,
		y = position.y + dim.y*rightVector.y + dim.x*forwardVector.y + dim.z*upVector.y,
		z = 0
    }

    local FUR_bool, FUR_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    FUR.z = FUR_z
    FUR.z = FUR.z + 2 * dim.z

    local BLL = {
        x = position.x - dim.y*rightVector.x - dim.x*forwardVector.x - dim.z*upVector.x,
        y = position.y - dim.y*rightVector.y - dim.x*forwardVector.y - dim.z*upVector.y,
        z = 0
    }
    local BLL_bool, BLL_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    BLL.z = BLL_z

    -- DEBUG
    local edge1 = BLL
    local edge5 = FUR

    local edge2 = {
        x = edge1.x + 2 * dim.y*rightVector.x,
        y = edge1.y + 2 * dim.y*rightVector.y,
        z = edge1.z + 2 * dim.y*rightVector.z
    }

    local edge3 = {
        x = edge2.x + 2 * dim.z*upVector.x,
        y = edge2.y + 2 * dim.z*upVector.y,
        z = edge2.z + 2 * dim.z*upVector.z
    }

    local edge4 = {
        x = edge1.x + 2 * dim.z*upVector.x,
        y = edge1.y + 2 * dim.z*upVector.y,
        z = edge1.z + 2 * dim.z*upVector.z
    }

    local edge6 = {
        x = edge5.x - 2 * dim.y*rightVector.x,
        y = edge5.y - 2 * dim.y*rightVector.y,
        z = edge5.z - 2 * dim.y*rightVector.z
    }

    local edge7 = {
        x = edge6.x - 2 * dim.z*upVector.x,
        y = edge6.y - 2 * dim.z*upVector.y,
        z = edge6.z - 2 * dim.z*upVector.z
    }

    local edge8 = {
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

local GetEntityInfo = function(entity, coords)
    local playerCoords  = GetEntityCoords(PlayerPedId())
    local entityType    = GetEntityType(entity)
    local entityData    = {
        'Entity Information',
        '',
        'Model Hash: ~y~'..GetEntityModel(entity),
        ' ',
        'Object ID: ~y~'..entity,
        'Network ID: ~y~'..(NetworkGetEntityIsNetworked(entity) and NetworkGetNetworkIdFromEntity(entity) or "Not Registered"),
        'Entity Owner: ~y~'..GetPlayerServerId(NetworkGetEntityOwner(entity)),
        ' '
    }

    if entityType == 1 then
        table.insert(entityData, 'Current Health: ~y~'..GetEntityHealth(entity))
        table.insert(entityData, 'Max Health: ~y~'..GetPedMaxHealth(entity))
        table.insert(entityData, 'Armour: ~y~'..GetPedArmour(entity))
        table.insert(entityData, 'Relation Group: ~y~'..GetPedRelationshipGroupHash(entity))
    elseif entityType == 2 then
        table.insert(entityData, 'Rpm: ~y~'..RoundFloat(GetVehicleCurrentRpm(entity), 2))
        table.insert(entityData, 'Kph: ~y~'..RoundFloat((GetEntitySpeed(entity)*3.6),0))
        table.insert(entityData, 'Current Gear: ~y~'..GetVehicleCurrentGear(entity))
        table.insert(entityData, 'Acceleration: ~y~'..RoundFloat(GetVehicleAcceleration(entity), 2))
        table.insert(entityData, 'Body Health: ~y~'..GetVehicleBodyHealth(entity))
        table.insert(entityData, 'Engine Health: ~y~'..GetVehicleEngineHealth(entity))
    elseif entityType == 3 then
        table.insert(entityData, 'Health: ~y~'..GetEntityHealth(entity))
    end 
    local entityCoords = GetEntityCoords(entity)

    table.insert(entityData, ' ')
    table.insert(entityData, 'Dist: ~y~'.. RoundFloat(#(playerCoords-entityCoords), 2).. " meters")
    table.insert(entityData, 'Heading: ~y~'.. RoundFloat(GetEntityHeading(entity), 2))
    table.insert(entityData, 'Coords: ~y~'.. RoundVector3(entityCoords, 2))
    table.insert(entityData, 'Rotation: ~y~'.. RoundVector3(GetEntityRotation(entity), 2))
    table.insert(entityData, 'Velocity: ~y~'.. RoundVector3(GetEntityVelocity(entity), 2))

    return entityData
end

local DrawEntityViewText = function(entity, coords)
    local data          = GetEntityInfo(entity, coords)
    local count         = #data
    local titleOffsetY  = 0.03
    local textOffsetY   = 0.022
    local bottomPadding = 0.01
    local offSetCount   = (((count) * textOffsetY)+titleOffsetY)/count 
    local posX, posY    = 0.70, 0.50
    local rectWidth     = 0.18
    local rectHeight    = ((count-1) * offSetCount)+bottomPadding
    DrawRect(posX, posY, rectWidth, rectHeight, 11, 11, 11, 200)

    local offsetY =  (1.0-rectHeight)/2
    for k, v in ipairs(data) do
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextDropshadow(1.0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextColour(255, 255, 255, 215)
        SetTextJustification(1)
        SetTextEntry("STRING")
        AddTextComponentString(v)
        if k == 1 then
            SetTextScale(0.50, 0.50)
            DrawText(posX-0.035, offsetY)
            offsetY = offsetY + titleOffsetY
        else
            SetTextScale(0.35, 0.35)
            DrawText(posX-0.086, offsetY)
            offsetY = offsetY + textOffsetY
        end        
    end
end

local DrawEntityViewTextInWorld = function(entity, coords)
    local onScreen, posX, posY = World3dToScreen2d(coords.x, coords.y, coords.z)
    if onScreen then
        local dist = #(coords-GetEntityCoords(PlayerPedId()))
        local data = GetEntityInfo(entity, coords)
        local count = #data
        local textOffsetY   = 0.015
        local leftPadding   = 0.005
        local topPadding    = 0.01
        local botPadding    = 0.02
        local offSetCount   = (((count-2) * textOffsetY))/count 
        local rectWidth     = 0.12
        local rectHeight    = ((count) * offSetCount)+botPadding

        DrawRect(posX, posY, rectWidth, rectHeight, 11, 11, 11, 200)

        local offsetY =  (1.0-rectHeight)/2

        for k, v in ipairs(data) do
            if k ~= 1 and k ~= 2 then
                SetTextScale(0.25, 0.25)
                SetTextFont(4)
                SetTextDropshadow(1.0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextColour(255, 255, 255, 215)
                SetTextJustification(1)
                SetTextEntry("STRING")
                AddTextComponentString(v)
                DrawText(posX-rectWidth/2+leftPadding, posY-rectHeight/2+topPadding)
                posY = posY + textOffsetY
            end
        end
    end
end

local GetVehicle = function(playerPed, playerCoords)
    local handle, vehicle = FindFirstVehicle()
    local success
    local rped = nil
    repeat
        local pos = GetEntityCoords(vehicle)
        local distance = #(playerCoords-pos)
        if distance < EntityViewDistance  then
            rped = vehicle

            FreezeEntityPosition(vehicle, FreezeEntities)
            DrawEntityViewTextInWorld(vehicle, pos)
        end
        success, vehicle = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

local GetObject = function(playerPed, playerCoords)
    local handle, object = FindFirstObject()
    local success
    local robject = nil
    repeat
        local pos = GetEntityCoords(object)
        local distance = #(playerCoords-pos)
        if distance < EntityViewDistance then
            robject = object

            FreezeEntityPosition(object, FreezeEntities)
            DrawEntityViewTextInWorld(object, pos)
        end

        success, object = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return robject
end

local GetNPC = function(playerPed, playerCoords)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords-pos)
        if CanEntityBeUsed(ped) and distance < EntityViewDistance  then
            rped = ped
            
            FreezeEntityPosition(ped, FreezeEntities)
            DrawEntityViewTextInWorld(ped, pos)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

ToggleEntityFreeView = function()
    EntityFreeAim = not EntityFreeAim
    if EntityFreeAim and not EntityViewEnabled then
        RunEntityViewThread()
    end
end

ToggleEntityObjectView = function()
    EntityObjectView = not EntityObjectView
    if EntityObjectView and not EntityViewEnabled then
        RunEntityViewThread()
    end
end

ToggleEntityVehicleView = function()
    EntityVehicleView = not EntityVehicleView
    if EntityVehicleView and not EntityViewEnabled then
        RunEntityViewThread()
    end
end

ToggleEntityPedView = function()
    EntityPedView = not EntityPedView
    if EntityPedView and not EntityViewEnabled then
        RunEntityViewThread()
    end
end

GetCurrentEntityViewDistance = function()
    return EntityViewDistance / 5
end

SetEntityViewDistance = function(data)
    EntityViewDistance = tonumber(data)
end

RunEntityViewThread = function()
    EntityViewEnabled = true
    Citizen.CreateThread(function()
        while EntityViewEnabled do         
            Citizen.Wait(0)
            local freezeDesc = (EntityObjectView or EntityPedView or EntityVehicleView)
            DrawTitle("~y~ENTITY VIEW~w~\n"..(EntityFreeAim and "\n[~y~E~w~] - Delete Entity~w~" or "").. (freezeDesc and '\n[~y~G~w~] - Freeze All Entities' or ''), 0.15, freezeDesc and 0.14 or 0.11)

            local entity        = nil
            local playerPed     = PlayerPedId()
            local playerCoords  = GetEntityCoords(playerPed)            

            if EntityPedView then
                GetNPC(playerPed, playerCoords)
            end

            if EntityObjectView then
                GetObject(playerPed, playerCoords)
            end
            
            if EntityVehicleView then
                GetVehicle(playerPed, playerCoords)
            end

            if EntityFreeAim then
                local color = {r = 255, g = 200, b = 0, a = 200}
                local position = GetEntityCoords(PlayerPedId())
                hit, coords, entity = RayCastGamePlayCamera(1000.0)
                -- If entity is found then verify entity
                if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                    local entityCoord = GetEntityCoords(entity)
                    local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
                    DrawEntityBoundingBox(entity, color)
                    DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                    DrawEntityViewText(entity, entityCoord)
                end
            end

            if IsControlJustReleased(0, 38) then -- Delete entity
                -- Set as missionEntity so the object can be remove (Even map objects)
			    SetEntityAsMissionEntity(entity, true, true)
			    DeleteEntity(entity)

                if not DoesEntityExist(entiy) then
                    QBCore.Functions.Notify('Entity Deleted', 'success')
                end          
            end

            if EntityPedView or EntityVehicleView or EntityObjectView then
                if IsControlJustReleased(0, 47) then -- Freeze entities
                    FreezeEntities = not FreezeEntities


                    QBCore.Functions.Notify('Freeze all entities now '.. (FreezeEntities and "enabled" or "disabled"), FreezeEntities and 'success' or 'error')        
                end
            end

            if EntityPedView == false and EntityObjectView == false and EntityVehicleView == false and EntityFreeAim == false then
                EntityViewEnabled = false
            end
        end
    end)
end