SeatShuffleModule = setmetatable({}, SeatShuffleModule)

SeatShuffleModule.__call = function()
    return "SeatShuffleModule"
end

SeatShuffleModule.__index = SeatShuffleModule

function SeatShuffleModule.Load()
    return setmetatable({
        disableShuffle = true
    }, SeatShuffleModule)
end

function SeatShuffleModule:RegisterCommands()
    RegisterCommand('shuff', function()
        self.disableShuffle = not self.disableShuffle
    end)
end

function SeatShuffleModule:Run()
    if IsPedInAnyVehicle(Client.ped, false) and self.disableShuffle then
        if GetPedInVehicleSeat(Client.currentVehicle, 0) == Client.ped then
            if GetIsTaskActive(Client.ped, 165) then
                SetPedIntoVehicle(Client.ped, Client.currentVehicle, 0)
            end
        end
    end
end