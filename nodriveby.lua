NoDriveByModule = setmetatable({}, NoDriveByModule)

NoDriveByModule.__call = function()
    return "NoDriveByModule"
end

NoDriveByModule.__index = NoDriveByModule

function NoDriveByModule.Load()
    return setmetatable({}, NoDriveByModule)
end

function NoDriveByModule:Run()
    if Client.currentVehicle then 
        if GetPedInVehicleSeat(Client.currentVehicle, -1) == ped then
            SetPlayerCanDoDriveBy(Client.handle, false)
        elseif Config.Modules.NoDriveBy.Settings.AllowPassengerDriveBy then
            SetPlayerCanDoDriveBy(Client.handle, true)
        else
            SetPlayerCanDoDriveBy(Client.handle, false)
        end
    end
end