SafezoneModule = setmetatable({}, SafezoneModule)

SafezoneModule.__call = function()
    return "SafezoneModule"
end

SafezoneModule.__index = SafezoneModule

function SafezoneModule.Load()
    return setmetatable({
        disableCollisions = false
    }, SafezoneModule)
end

function SafezoneModule:Run()
    if self.disableCollisions then
        for _, ply in ipairs(GetActivePlayers()) do
            local plyPed = GetPlayerPed(ply)
             if IsPedInAnyVehicle(plyPed, true) then
                local veh = GetVehiclePedIsUsing(plyPed)
                SetEntityNoCollisionEntity(Client.ped, veh, true)
            end
        end

        for _, vehicle in pairs(GetGamePool("CVehicle")) do
            if IsPedInAnyVehicle(Client.ped, true) then
                SetEntityNoCollisionEntity(vehicle, Client.currentVehicle, true)
            end
        end
    end
end

function SafezoneModule:SetupSafezones()
    for name, data in pairs(Config.Modules.Safezone.Settings.Zones) do 
        local zone = PolyZone:Create(data.Points, {
            name=  name,
            minZ = data.MinZ,
            maxZ = data.MaxZ,
            debugPoly = data.Debug,
            gridDivisions = 30,
            lazyGrid = true
        })

        if data.ShowBlip then
            local zoneCenter = zone:getBoundingBoxCenter()

            local blip = AddBlipForCoord(zoneCenter.x, zoneCenter.y, 0)
            SetBlipSprite(blip, 270)
            SetBlipDisplay(blip, 8)
            SetBlipScale(blip, 0.9)
            SetBlipColour(blip, 11)
            SetBlipAsShortRange(blip, false)
        end

        zone:onPlayerInOut(function(isPointInside, point)
            -- Is player inside safezone
            if isPointInside then
                if data.ShowNotifications then
                    TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Safezone", "You have entered the ~y~"..name.." ~w~safezone")
                end
                NetworkSetFriendlyFireOption(false)
				SetEntityCanBeDamaged(Client.currentVehicle, false)
				ClearPlayerWantedLevel(Client.handle)
                DisablePlayerFiring(Client.ped, true)
		        SetPlayerCanDoDriveBy(Client.handle, false)

		        if IsPedInAnyVehicle(Client.ped, false) then
                    SetEntityCanBeDamaged(Client.currentVehicle, false)
                end

                self.disableCollisions = true
            else
                if data.ShowNotifications then
                    TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Safezone", "You have left the ~y~"..name.." ~w~safezone")
                end
                NetworkSetFriendlyFireOption(true)
                SetEntityCanBeDamaged(Client.currentVehicle, true)
                DisablePlayerFiring(Client.ped, false)
		        SetPlayerCanDoDriveBy(Client.handle, true)

		        if IsPedInAnyVehicle(Client.ped, false) then
                    SetEntityCanBeDamaged(Client.currentVehicle, false)
                end

                self.disableCollisions = false
            end
        end)
    end
end