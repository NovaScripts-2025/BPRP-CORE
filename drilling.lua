DrillingModule = setmetatable({}, DrillingModule)

DrillingModule.__call = function()
    return "DrillingModule"
end

DrillingModule.__index = DrillingModule

function DrillingModule.Load()
    return setmetatable({
        disabledControls = {30,31,32,33,34,35},
        active = false,
        scaleform = nil,
        drillSpeed = 0.0,
        drillPos = 0.0,
        drillTemp = 0.0,
        holeDepth = 0.1,
        result = false,
        scene = nil,
        drill = nil
    }, DrillingModule)
end

function DrillingModule:RegisterCommands()
    RegisterCommand("drill", function()
        local data = exports['cd_doorlock']:GetDoorDataFull_closest()
        print(json.encode(data))

        TriggerEvent("RSRPCore:Client:StartDrilling", function(success)
            if (success) then
                print("Drilling complete.")
              else
                print("Drilling failed.")
              end
        end)
    end)
end

function DrillingModule:RegisterEvents()
    AddEventHandler("RSRPCore:Client:StartDrilling", function(callback)
        self:Start(callback)
    end)
end

function DrillingModule:StartDrillingAnimation()
    local dict = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@"
    local drillModel = GetHashKey("ch_prop_vault_drill_01a")
    Client:LoadModel(drillModel)
    Client:LoadAnimDict(dict)
    self.drill = CreateObject(drillModel, GetEntityCoords(Client.ped), true, false, false)
    self.scene = NetworkCreateSynchronisedScene(
        GetEntityCoords(Client.ped), -- FiveM unwraps this to X, Y, Z
        GetEntityRotation(Client.ped), -- ^
        2, 
        false, 
        true, 
        1.0,
        0.0, 
        1.0  
    )
    NetworkAddPedToSynchronisedScene(Client.ped, self.scene, dict, "action", 8.0, 8.0, 0, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(self.drill, self.scene, dict, "action_ch_prop_vault_drill_01a", 8.0, 8.0, 0)
    NetworkStartSynchronisedScene(self.scene)
end

function DrillingModule:StopDrillingAnimation()
    if self.scene and self.drill then
        local dict = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@"
        self.scene = NetworkCreateSynchronisedScene(
            GetEntityCoords(Client.ped), -- FiveM unwraps this to X, Y, Z
            GetEntityRotation(Client.ped), -- ^
            2, 
            true, 
            false, 
            1.0,
            0.0, 
            1.0  
        )

        NetworkAddPedToSynchronisedScene(Client.ped, self.scene, dict, "exit", 8.0, 8.0, 0, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(self.drill, self.scene, dict, "exit_ch_prop_vault_drill_01a", 8.0, 8.0, 0)
        NetworkStartSynchronisedScene(self.scene)
        Wait(0)
        local localScene = NetworkGetLocalSceneFromNetworkId(self.scene)
        repeat Wait(0) until not IsSynchronizedSceneRunning(localScene)
        DeleteEntity(self.drill)
        self.scene = nil
        self.drill = nil
    end
end

function DrillingModule:StartLockpickTick()
    CreateThread(function()
        while true do
            if not self.active then
                local data = exports['cd_doorlock']:GetDoorDataFull_closest()

                -- Close to a door, but not close enough
                if data.door_data then
                    if data.distance <= 2.0 and data.state == true then
                        Client:ShowHelpNotification("Press ~INPUT_DETONATE~ to drill out the doorlock", true, true, -1)

                        if IsControlJustPressed(0, 47) then
                            self:StartDrillingAnimation()
                            self:Start(function(success)
                                self:StopDrillingAnimation()
                                if success then
                                    TriggerEvent('cd_doorlock:SetDoorState_closest', false)
                                else
                                    print("Failed")
                                end
                            end)
                        end
                    end
                end
            end

            Wait(0)
        end
    end)
end

function DrillingModule:UnloadMovie(scaleform)
    SetScaleformMovieAsNoLongerNeeded(scaleform)
end

function DrillingModule:LoadMovie(name)
    local scaleform = RequestScaleformMovie(name)
    while not HasScaleformMovieLoaded(scaleform) do 
        Wait(0) 
    end
    return scaleform
end

function DrillingModule:PopFloat(scaleform, method, val)
    PushScaleformMovieFunction(scaleform, method)
    PushScaleformMovieFunctionParameterFloat(val)
    PopScaleformMovieFunctionVoid()
end

function DrillingModule:Start(callback)
    if not self.active then
        self.active = true
        self:Init()
        self:Update(callback)
    end
end

function DrillingModule:Init()
    if self.scaleform then
        self:UnloadMovie(self.scaleform)
    end

    self.scaleform = self:LoadMovie("DRILLING")

    self.drillSpeed = 0.0
    self.drillPos = 0.0
    self.drillTemp = 0.0
    self.holeDepth = 0.1

    self:PopFloat(self.scaleform, "SET_SPEED", 0.0)
    self:PopFloat(self.scaleform, "SET_DRILL_POSITION", 0.0)
    self:PopFloat(self.scaleform, "SET_TEMPERATURE", 0.0)
    self:PopFloat(self.scaleform, "SET_HOLE_DEPTH", 0.0)
end

function DrillingModule:Update(callback)
    while self.active do
        self:Draw()
        self:DisableControls()
        self:HandleControls()
        PlaySoundFromEntity(GetSoundId(), "Drill", Client.ped, "DLC_HEIST_FLEECA_SOUNDSET", true, 0)
        Wait(0)
    end
    callback(self.result)
end

function DrillingModule:Draw()
    DrawScaleformMovieFullscreen(self.scaleform, 255, 255, 255, 255, 255)
end

function DrillingModule:HandleControls()
    local lastPos = self.drillPos

    if IsControlJustPressed(0, 172) then
        self.drillPos = math.min(1.0, self.drillPos + 0.01)
    elseif IsControlPressed(0, 172) then
        self.drillPos = math.min(1.0, self.drillPos + (0.1 * GetFrameTime() / (math.max(0.1, self.drillTemp) * 10)))
    elseif IsControlJustPressed(0, 173) then
        self.drillPos = math.max(0.0, self.drillPos - 0.01)
    elseif IsControlPressed(0, 173) then
        self.drillPos = math.max(0.0, self.drillPos - (0.1 * GetFrameTime()))
    end

    local lastSpeed = self.drillSpeed

    if IsControlJustPressed(0,175) then
        self.drillSpeed = math.min(1.0, self.drillSpeed + 0.05)
    elseif IsControlPressed(0,175) then
        self.drillSpeed = math.min(1.0, self.drillSpeed + (0.5 * GetFrameTime()))
    elseif IsControlJustPressed(0,174) then
        self.drillSpeed = math.max(0.0, self.drillSpeed - 0.05)
    elseif IsControlPressed(0,174) then
        self.drillSpeed = math.max(0.0, self.drillSpeed - (0.5 * GetFrameTime()))
    end

    if last_speed ~= self.drillSpeed then
        self:PopFloat(self.scaleform, "SET_SPEED", self.drillSpeed)
    end

    local lastTemp = self.drillTemp

    if self.drillPos > self.holeDepth then
        if self.drillSpeed > 0.1  then
            self.drillTemp = math.min(1.0, self.drillTemp + ((1.0 * GetFrameTime()) * self.drillSpeed))
            self.holeDepth = self.drillPos
        else
            self.drillPos = self.holeDepth
        end
    else
        self.drillTemp = math.max(0.0, self.drillTemp - (1.0 * GetFrameTime()))
    end
    
    if self.drillPos ~= lastPos then
        self:PopFloat(self.scaleform, "SET_DRILL_POSITION", self.drillPos)
    end
    
    if lastTemp ~= self.drillTemp then
        self:PopFloat(self.scaleform, "SET_TEMPERATURE", self.drillTemp)
    end
    
    if self.drillTemp >= 1.0 then
        self.result = false
        self.active = false
    elseif self.drillPos >= 1.0 then
        self.result = true
        self.active = false
    end
end

function DrillingModule:DisableControls()
    for _, control in ipairs(self.disabledControls) do
        DisableControlAction(0, control, true)
    end
end

