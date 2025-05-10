KeepDoorsOpenModule = setmetatable({}, KeepDoorsOpenModule)

KeepDoorsOpenModule.__call = function()
    return "KeepDoorsOpenModule"
end

KeepDoorsOpenModule.__index = KeepDoorsOpenModule

function KeepDoorsOpenModule.Load()
    return setmetatable({}, KeepDoorsOpenModule)
end

function KeepDoorsOpenModule:Run()
    if IsPedInAnyVehicle(Client.ped, false) and IsControlPressed(2, 75) and not IsEntityDead(Client.ped) and not IsPauseMenuActive() then
        Wait(150)
        if IsPedInAnyVehicle(Client.ped, false) and IsControlPressed(2, 75) and not IsEntityDead(Client.ped) and not IsPauseMenuActive() then
            TaskLeaveVehicle(Client.ped, Client.currentVehicle, 256)
        end
    end
end