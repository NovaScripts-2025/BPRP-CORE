FuelModule = setmetatable({}, FuelModule)

FuelModule.__call = function()
    return "FuelModule"
end

FuelModule.__index = FuelModule

function FuelModule.Load()
    return setmetatable({
        IsNearPump = false,
        isFueling = false,
        currentFuel = 0.0,
        fuelSynced = false,
        pumpScaleform = RequestScaleformMovie("PUMP_INFORMATION"),
        tankBones = {
            "petrolcap",
            "petroltank",
            "petroltank_r",
            "petroltank_l",
            "wheel_lr"
        }
    }, FuelModule)
end

function FuelModule:RegisterEvents()
    AddEventHandler("RSRPCore:Client:Fuel:StartFuelUpTick", function(pumpObject, ped, vehicle)
        self.currentFuel = self:GetFuel(vehicle)

        while self.isFueling do 
            Wait(500)

            local oldFuel = Entity(vehicle).state.fuel
            local fuelToAdd = math.random(10, 20) / 10.0

            if not pumpObject then 
                if GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100 >= 0 then
                    self.currentFuel = oldFuel + fuelToAdd
    
                    SetPedAmmo(ped, 883325847, math.floor(GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100))
                else
                    self.isFueling = false
                end
            else
                self.currentFuel = oldFuel + fuelToAdd
            end

            if self.currentFuel > 100.0 then
                self.currentFuel = 100.0
                self.isFueling = false
            end

            self:SetFuel(vehicle, self.currentFuel)
        end
    end)
end

function FuelModule:SetupScaleform()
    while not HasScaleformMovieLoaded(self.pumpScaleform) do 
        Wait(0)
    end

    BeginScaleformMovieMethod(self.pumpScaleform, "SET_MISSION_INFO")
    ScaleformMovieMethodAddParamTextureNameString("Press E To Refuel") --missionName
    ScaleformMovieMethodAddParamTextureNameString("~g~FUEL PUMP") --missionType
    ScaleformMovieMethodAddParamTextureNameString("") --playerInfo (unused)
    ScaleformMovieMethodAddParamTextureNameString("0") -- percentage
    ScaleformMovieMethodAddParamTextureNameString("") --debugValue
    ScaleformMovieMethodAddParamBool(false) --isRockstarVerified
    ScaleformMovieMethodAddParamTextureNameString("") --playersRequired
    ScaleformMovieMethodAddParamInt(0) --RP
    ScaleformMovieMethodAddParamInt(0) --cash
    ScaleformMovieMethodAddParamTextureNameString("") --time
    EndScaleformMovieMethod()
end

function FuelModule:UpdateScaleformData(fuelPercentage, missionType, missionName)
    BeginScaleformMovieMethod(self.pumpScaleform, "SET_MISSION_INFO")
    ScaleformMovieMethodAddParamTextureNameString(missionName) --missionName
    ScaleformMovieMethodAddParamTextureNameString(missionType) --missionType
    ScaleformMovieMethodAddParamTextureNameString("") --playerInfo (unused)
    ScaleformMovieMethodAddParamTextureNameString(tostring(fuelPercentage).."%") -- percentage
    ScaleformMovieMethodAddParamTextureNameString("") --debugValue
    ScaleformMovieMethodAddParamBool(false) --isRockstarVerified
    ScaleformMovieMethodAddParamTextureNameString("") --playersRequired
    ScaleformMovieMethodAddParamInt(0) --RP
    ScaleformMovieMethodAddParamInt(0) --cash
    ScaleformMovieMethodAddParamTextureNameString("") --time
    EndScaleformMovieMethod()
end

function FuelModule:GetFuel(vehicle)
    return Entity(vehicle).state.fuel or 0
end

function FuelModule:SetFuel(vehicle, fuel)
    if type(fuel) == 'number' and fuel >= 0 and fuel <= 100 then
        if Entity(vehicle).state.fuelSynced then
            SetVehicleFuelLevel(vehicle, fuel + 0.0)
            Entity(vehicle).state:set('fuel', GetVehicleFuelLevel(vehicle), true)
        else
            TriggerServerEvent('RSRPCore:Server:Fuel:InitalizeVehicleFuelState', VehToNet(vehicle))

            while not Entity(vehicle).state.fuelSynced do 
                Wait(100)
            end

            SetVehicleFuelLevel(vehicle, fuel + 0.0)
            Entity(vehicle).state:set('fuel', GetVehicleFuelLevel(vehicle), true)
        end
    end
end

function FuelModule:FindNearestFuelPump()
    local fuelPumps = {}

    for _, object in ipairs(GetGamePool('CObject')) do 
        local model = GetEntityModel(object)
        if Config.Modules.Fuel.Settings.PumpModels[model] then
            table.insert(fuelPumps, object)
        end
    end

    local pumpObject = 0
	local pumpDistance = 1000

    for _, pumpObj in pairs(fuelPumps) do
        local dstcheck = #(Client.position - GetEntityCoords(pumpObj))
        
        if dstcheck < pumpDistance then
            pumpDistance = dstcheck
            pumpObject = pumpObj
        end
    end
        
    return pumpObject, pumpDistance
end

function FuelModule:CreatePumpBlip(position)
    local blip = AddBlipForCoord(position)

    SetBlipSprite(blip, 361)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 4)
    SetBlipDisplay(blip, 4)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gas Station")
    EndTextCommandSetBlipName(blip)

    return blip
end

function FuelModule:GetFuelTankPosition(vehicle)
    local bonePos = nil 
    for _, tankBone in ipairs(self.tankBones) do 
        local boneIndex = GetEntityBoneIndexByName(vehicle, tankBone)

        if boneIndex ~= -1 then 
            bonePos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
            break
        end
    end

    if not bonePos then 
        return GetEntityCoords(vehicle)
    end

    return bonePos
end

function FuelModule:ManageFuelUsage(vehicle)
    local fuelState = Entity(vehicle).state.fuel
    if not fuelState then 
        self:SetFuel(vehicle, math.random(200, 800) / 10)
    else 
        self:SetFuel(vehicle, self:GetFuel(vehicle))

        self.fuelSynced = true
    end

    if IsVehicleEngineOn(vehicle) then 
        self:SetFuel(vehicle, self:GetFuel(vehicle) - Config.Modules.Fuel.Settings.FuelUsage[Client:Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Modules.Fuel.Settings.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
    end
end

function FuelModule:ManageFuelTick()
    CreateThread(function()
        while true do
            if IsPedInAnyVehicle(Client.ped) then
                if GetPedInVehicleSeat(Client.currentVehicle, -1) == Client.ped then
                    self:ManageFuelUsage(Client.currentVehicle)
                end
            else 
                if self.fuelSynced then
                    self.fuelSynced = false
                end
            end 
            Wait(1000)
        end
    end)
end

function FuelModule:NearPumpTick()
    CreateThread(function()
        while true do
            local pumpObject, pumpDistance = self:FindNearestFuelPump()

            if pumpDistance < 2.5 then 
                self.isNearPump = pumpObject
            else 
                self.isNearPump = false
            end 
            Wait(250)
        end
    end)
end

function FuelModule:RefuelFromPump(pumpObject, ped, vehicle)
    TaskTurnPedToFaceEntity(ped, vehicle, 1000)
    Wait(1000)
    SetCurrentPedWeapon(ped, -1569615261, true)
    Client:LoadAnimDict("timetable@gardener@filling_can")
    TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)

    TriggerEvent("RSRPCore:Client:Fuel:StartFuelUpTick", pumpObject, ped, vehicle)

    while self.isFueling do 
        for _, cIndex in pairs(Config.Modules.Fuel.Settings.DisableKeys) do
             DisableControlAction(0, cIndex)
        end
        local pumpCoords = GetEntityCoords(self.isNearPump)
        local minVec, maxVec = GetModelDimensions(GetEntityModel(self.isNearPump))
        local zAddition = #(maxVec - minVec)
        local fuel = self:GetFuel(vehicle)

        local fuelText
        if fuel <= 25 then
            fuelText = "~r~FUEL PUMP"
        elseif fuel > 25 and fuel <= 65 then 
            fuelText = "~y~FUEL PUMP"
        elseif fuel > 65 then
            fuelText = "~g~FUEL PUMP"
        end

        self:UpdateScaleformData(Client:Round(fuel, 1), fuelText, (fuel == 100 and "Tank Full" or "Press E To Refuel"))

        DrawScaleformMovie_3dSolid(
            self.pumpScaleform, 
            pumpCoords.x, 
            pumpCoords.y,
            pumpCoords.z + zAddition,
            GetGameplayCamRot(),
            1.0,
            1.0,
            0.0,
            3.0, 
            2.3,
            1.0,
            0
        )
        
        if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
            TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
        end
        
        if IsControlJustReleased(0, 38) or DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) or (self.isNearPump and GetEntityHealth(pumpObject) <= 0) then
            self.isFueling = false
        end
        
        Wait(0)
    end

    ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end

function FuelModule:Run()
    local vehicle = GetPlayersLastVehicle()
    if not self.isFueling and ((self.isNearPump and GetEntityHealth(self.isNearPump) > 0) or (GetSelectedPedWeapon(Client.ped) == 883325847 and not self.isNearPump)) then    
        if IsPedInAnyVehicle(Client.ped) and GetPedInVehicleSeat(vehicle) == Client.ped then
            local pumpCoords = GetEntityCoords(self.isNearPump)
            local minVec, maxVec = GetModelDimensions(GetEntityModel(self.isNearPump))
            local zAddition = #(maxVec - minVec)
            local fuel = self:GetFuel(vehicle)

            local fuelText
            if fuel <= 25 then
                fuelText = "~r~FUEL PUMP"
            elseif fuel > 25 and fuel <= 65 then 
                fuelText = "~y~FUEL PUMP"
            elseif fuel > 65 then
                fuelText = "~g~FUEL PUMP"
            end

            self:UpdateScaleformData(Client:Round(fuel, 1), fuelText, "Exit your vehicle to refuel")

            DrawScaleformMovie_3dSolid(
                self.pumpScaleform, 
                pumpCoords.x, 
                pumpCoords.y,
                pumpCoords.z + zAddition,
                GetGameplayCamRot(),
                1.0,
                1.0,
                0.0,
                3.0, 
                2.3,
                1.0,
                0
            )
        else
            local vehicleCoords = GetEntityCoords(vehicle)

            if DoesEntityExist(vehicle) and #(GetEntityCoords(Client.ped) - vehicleCoords) < 2.5 then
                if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
                    local pumpCoords = GetEntityCoords(self.isNearPump)
                    --local pumpHeight = GetEntityHeight(ELRPCore.Modules.Fuel.IsNearPump, pumpCoords, true, true)
                    local minVec, maxVec = GetModelDimensions(GetEntityModel(self.isNearPump))
                    local zAddition = #(maxVec - minVec)
                    local canFuel = true
                    local fuel = self:GetFuel(vehicle)

                    local fuelText
                    if fuel <= 25 then
                        fuelText = "~r~FUEL PUMP"
                    elseif fuel > 25 and fuel <= 65 then 
                        fuelText = "~y~FUEL PUMP"
                    elseif fuel > 65 then
                        fuelText = "~g~FUEL PUMP"
                    end

                    self:UpdateScaleformData(Client:Round(fuel, 1), fuelText, (fuel == 100 and "Tank Full" or "Press E To Refuel"))

                    DrawScaleformMovie_3dSolid(
                        self.pumpScaleform, 
                        pumpCoords.x, 
                        pumpCoords.y,
                        pumpCoords.z + zAddition,
                        GetGameplayCamRot(),
                        1.0,
                        1.0,
                        0.0,
                        3.0, 
                        2.3,
                        1.0,
                        0
                    )

                    if GetSelectedPedWeapon(Client.ped) == 883325847 then
                        pumpCoords = vehicleCoords

                        if GetAmmoInPedWeapon(Client.ped, 883325847) < 100 then
                            canFuel = false
                        end
                    end

                    if GetVehicleFuelLevel(vehicle) < 95 and canFuel then
                        if IsControlJustReleased(0, 38) then
                            self.isFueling = true

                            self:RefuelFromPump(self.isNearPump, Client.ped, vehicle)
                        end
                    end
                end 
            end
        end
    end
end