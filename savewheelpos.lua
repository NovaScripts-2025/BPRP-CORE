SaveWheelPosModule = setmetatable({}, SaveWheelPosModule)

SaveWheelPosModule.__call = function()
    return "SaveWheelPosModule"
end

SaveWheelPosModule.__index = SaveWheelPosModule

function SaveWheelPosModule.Load()
    return setmetatable({
        angle = 0.0,
        speed = 0.0
    }, SaveWheelPosModule)
end

function SaveWheelPosModule:Run()
    if Client.currentVehicle ~= 0 then
        local tangle = GetVehicleSteeringAngle(Client.currentVehicle)
        if tangle > 10.0 or tangle < -10.0 then
            self.angle = tangle
        end
        self.speed = GetEntitySpeed(veh)
        if self.speed < 0.1 and not GetIsTaskActive(Client.ped, 151) and not GetIsVehicleEngineRunning(Client.currentVehicle) then
            SetVehicleSteeringAngle(Client.currentVehicle, self.angle)
        end
    end
end