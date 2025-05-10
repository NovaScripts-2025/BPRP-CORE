DVModule = setmetatable({}, DVModule)

DVModule.__call = function()
    return "DVModule"
end

DVModule.__index = DVModule

function DVModule.Load()
    return setmetatable({}, DVModule)
end

function DVModule:RegisterCommands()
    RegisterCommand("dv", function()
        self:DeleteVehicle()
    end)

    TriggerEvent("chat:addSuggestion", "/dv", "Deletes the vehicle you're sat in, or standing next to.")
end

function DVModule:DeleteVehicle()
    local ped = PlayerPedId()

    if not IsEntityDead(ped) then 
        if IsPedSittingInAnyVehicle(ped) then 
            if GetPedInVehicleSeat(Client.currentVehicle, -1) == ped then 
                TriggerServerEvent("RSRPCore:Server:DeleteEntity", VehToNet(Client.currentVehicle))
            else 
                TriggerEvent("RSRPCore:Client:SendRiversideNotification", "DV", "~r~You must be in the driver's seat")        
            end 
        else
            local vehicle = Client:RaycastGetVehicleInFront()
            if DoesEntityExist(vehicle) then 
                TriggerServerEvent("RSRPCore:Server:DeleteEntity", VehToNet(vehicle))
            else 
                TriggerEvent("RSRPCore:Client:SendRiversideNotification", "DV", "~r~You must be in or near a vehicle to delete it")
            end 
        end 
    end
end