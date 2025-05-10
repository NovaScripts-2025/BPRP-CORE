CarHudModule = setmetatable({}, CarHudModule)

CarHudModule.__call = function()
    return "CarHudModule"
end

CarHudModule.__index = CarHudModule

function CarHudModule.Load()
    return setmetatable({
        x =  0.000,
	    y = -0.001
    }, CarHudModule)
end

function CarHudModule:DrawRect(x, y, width, height, r, g, b, a)
    DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function CarHudModule:Run()
    if IsPedInAnyVehicle(Client.ped, false) then

        local plate = GetVehicleNumberPlateText(Client.currentVehicle)
        local vehicleStopped = IsVehicleStopped(Client.currentVehicle)
        local engineHealth = GetVehicleEngineHealth(Client.currentVehicle) 
        local bodyHealth = GetVehicleBodyHealth(Client.currentVehicle)
        local burnout = IsVehicleInBurnout(Client.currentVehicle)

        if Config.Modules.CarHud.Settings.Speed == 'kmh' then
            speed = GetEntitySpeed(Client.currentVehicle) * 3.6
        elseif Config.Modules.CarHud.Settings.Speed == 'mph' then
            speed = GetEntitySpeed(Client.currentVehicle) * 2.236936
        else
            speed = 0.0
        end
        
        if Config.Modules.CarHud.Settings.Top then
            Client:Draw2DText(self.x + 0.563, self.y + 1.2624, 1.0,1.0,0.55, "~w~" .. plate, 255, 255, 255, 255)
            Client:Draw2DText(self.x + 0.619, self.y + 1.245, 1.0,1.0,0.45, "ENG", 114, 219, 165,200)

            if burnout then
                Client:Draw2DText(self.x + 0.535, self.y + 1.266, 1.0,1.0,0.44, "~r~DSC", 255, 255, 255, 200)
            else
                Client:Draw2DText(self.x + 0.535, self.y + 1.266, 1.0,1.0,0.44, "DSC", 255, 255, 255, 150)
            end	

            if (engineHealth > 0) and (engineHealth < 300) then
                Client:Draw2DText(self.x + 0.619, self.y + 1.266, 1.0,1.0,0.45, "~r~Fluid", 255, 255, 255, 200)
                Client:Draw2DText(self.x + 0.514, self.y + 1.266, 1.0,1.0,0.45, "~r~Oil", 255, 255, 255, 200)
                Client:Draw2DText(self.x + 0.645, self.y + 1.266, 1.0,1.0,0.45, "~r~AC", 255, 255, 255, 200)
                Client:Draw2DText(self.x + 0.619, self.y + 1.245, 1.0,1.0,0.45, "~r~ENG", 255, 255, 255, 200)
            elseif engineHealth < 1 then 
                self:DrawRect(self.x + 0.159, self.y + 0.809, 0.005, 0,0,0,0,100)  -- panel damage
                Client:Draw2DText(self.x + 0.619, self.y + 1.266, 1.0,1.0,0.45, "~r~Fluid", 255, 255, 255, 200)
                Client:Draw2DText(self.x + 0.514, self.y + 1.266, 1.0,1.0,0.45, "~r~Oil", 255, 255, 255, 200)
                Client:Draw2DText(self.x + 0.645, self.y + 1.266, 1.0,1.0,0.45, "~r~AC", 255, 255, 255, 200)
                Client:Draw2DText(self.x + 0.619, self.y + 1.245, 1.0,1.0,0.45, "~r~ENG", 255, 255, 255, 200)
            else
                Client:Draw2DText(self.x + 0.619, self.y + 1.266, 1.0,1.0,0.45, "Fluid", 255, 255, 255, 150)
                Client:Draw2DText(self.x + 0.514, self.y + 1.266, 1.0,1.0,0.45, "Oil", 255, 255, 255, 150)
                Client:Draw2DText(self.x + 0.645, self.y + 1.266, 1.0,1.0,0.45, "AC", 255, 255, 255, 150)
                Client:Draw2DText(self.x + 0.619, self.y + 1.245, 1.0,1.0,0.45, "ENG", 87, 158, 113,200)
            end
            if Config.Modules.CarHud.Settings.ParkIndicator then
                if vehicleStopped then
                    Client:Draw2DText(self.x + 0.6605, self.y + 1.262, 1.0,1.0,0.6, "~r~P", 255, 255, 255, 200)
                else
                    Client:Draw2DText(self.x + 0.6605, self.y + 1.262, 1.0,1.0,0.6, "P", 255, 255, 255, 150)
                end
            end
        else
            if Config.Modules.CarHud.Settings.Plate then
                Client:Draw2DText(self.x + 0.61, 	self.y + 1.385, 1.0,1.0,0.55, "~w~" .. plate, 255, 255, 255, 255) 
            end
            if Config.Modules.CarHud.Settings.ParkIndicator then

                if vehicleStopped then
                    Client:Draw2DText(self.x + 0.643, self.y + 1.34, 1.0,1.0,0.6, "~r~P", 255, 255, 255, 200)
                else
                    Client:Draw2DText(self.x + 0.643, self.y + 1.34, 1.0,1.0,0.6, "P", 255, 255, 255, 150)
                end
            end
        end
        if Config.Modules.CarHud.Settings.SpeedIndicator then
            self:DrawRect(self.x + 0.105, 	self.y + 0.932, 0.050,0.03,0,0,0,150) -- Speed panel
            if Config.Modules.CarHud.Settings.Speed == 'kmh' then
                Client:Draw2DText(self.x + 0.605, 	self.y + 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(speed), 255, 255, 255, 255)
                Client:Draw2DText(self.x + 0.636, 	self.y + 1.432, 1.0,1.0,0.4, "~w~ km/h", 255, 255, 255, 255)
            elseif Config.Modules.CarHud.Settings.Speed == 'mph' then
                Client:Draw2DText(self.x + 0.605, 	self.y + 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(speed), 255, 255, 255, 255)
                Client:Draw2DText(self.x + 0.636, 	self.y + 1.432, 1.0,1.0,0.4, "~w~ mph", 255, 255, 255, 255)
            else
                Client:Draw2DText(self.x + 0.81, 	self.y + 1.42, 1.0,1.0,0.64 , [[Carhud ~r~ERROR~w~ ~c~in ~w~HUD Speed~c~ config (something else than ~y~'kmh'~c~ or ~y~'mph'~c~)]], 255, 255, 255, 255)
            end
        end

        if Config.Modules.CarHud.Settings.Fuel then
            self:DrawRect(self.x + 0.105, self.y + 0.900, 0.050,0.03,0,0,0,150) -- Fuel panel
            Client:Draw2DText(self.x + 0.605, self.y + 1.389, 1.0,1.0,0.64 , "~w~" .. math.ceil(Client.modules.Fuel:GetFuel(Client.currentVehicle)), 255, 255, 255, 255)
            Client:Draw2DText(self.x + 0.631, self.y + 1.400, 1.0,1.0,0.4, "~w~% fuel", 255, 255, 255, 255)
        end

        if Config.Modules.CarHud.Settings.Seatbelt then
            self:DrawRect(self.x + 0.105, self.y + 0.868, 0.050,0.03,0,0,0,150) -- Seatbelt panel
            Client:Draw2DText(self.x + 0.605, self.y + 1.358, 1.0,1.0,0.64 , "~w~" ..(LocalPlayer.state.seatbelt and "~g~ON" or "~r~OFF"), 255, 255, 255, 255)
            Client:Draw2DText(self.x + 0.626, self.y + 1.368, 1.0,1.0,0.4, "~w~seatbelt", 255, 255, 255, 255)
        end
    end
end