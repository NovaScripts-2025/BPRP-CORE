CompassModule = setmetatable({}, CompassModule)

CompassModule.__call = function()
    return "CompassModule"
end

CompassModule.__index = CompassModule

function CompassModule.Load()
    return setmetatable({
        
    }, CompassModule)
end

function CompassModule:DegreesToIntercardinalDirection(dgr)
    dgr = dgr % 360.0
	
	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return "N "
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "NE"
	elseif dgr >= 67.5 and dgr < 112.5 then
		return "E"
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "SE"
	elseif dgr >= 157.5 and dgr < 202.5 then
		return "S"
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "SW"
	elseif dgr >= 247.5 and dgr < 292.5 then
		return "W"
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "NW"
	end
end

function CompassModule:DrawText(str, x, y, style)
    if style == nil then
		style = {}
	end
	
	SetTextFont( (style.font ~= nil) and style.font or 0 )
	SetTextScale( 0.0, (style.size ~= nil) and style.size or 1.0 )
	SetTextProportional( 1 )
	
	if style.colour ~= nil then
		SetTextColour( style.colour.R ~= nil and style.colour.R or 255, style.colour.G ~= nil and style.colour.G or 255, style.colour.B ~= nil and style.colour.B or 255, style.colour.A ~= nil and style.colour.A or 255 )
	else
		SetTextColour( 255, 255, 255, 255 )
	end
	
	if style.shadow ~= nil then
		SetTextDropShadow( style.shadow.distance ~= nil and style.shadow.distance or 0, style.shadow.r ~= nil and style.shadow.r or 0, style.shadow.g ~= nil and style.shadow.g or 0, style.shadow.b ~= nil and style.shadow.b or 0, style.shadow.a ~= nil and style.shadow.a or 255 )
	else
		SetTextDropShadow( 0, 0, 0, 0, 255 )
	end
	
	if style.border ~= nil then
		SetTextEdge( style.border.size ~= nil and style.border.size or 1, style.border.r ~= nil and style.border.r or 0, style.border.g ~= nil and style.border.g or 0, style.border.b ~= nil and style.border.b or 0, style.border.a ~= nil and style.shadow.a or 255 )
	end
	
	if style.centered ~= nil and style.centered == true then
		SetTextCentre( true )
	end
	
	if style.outline ~= nil and style.outline == true then
		SetTextOutline()
	end
	
	SetTextEntry( "STRING" )
	AddTextComponentString( str )
	
	DrawText( x, y )
end

function CompassModule:StartStreetNameTick()
    CreateThread(function()
        local lastStreetA = 0
        local lastStreetB = 0

        while Config.Modules.Compass.Settings.StreetName.Show do
            Wait(0)
            

            local streetA, streetB = GetStreetNameAtCoord(Client.position.x, Client.position.y, Client.position.z)
            local street = {}
            
            if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
                -- Ignores the switcharoo while doing circles on intersections
                lastStreetA = streetA
                lastStreetB = streetB
            end
            
            if lastStreetA ~= 0 then
                table.insert(street, GetStreetNameFromHashKey(lastStreetA))
            end
            
            if lastStreetB ~= 0 then
                table.insert(street, GetStreetNameFromHashKey(lastStreetB))
            end
            
            self.DrawText(table.concat(street, " & "), Config.Modules.Compass.Settings.StreetName.Position.X, Config.Modules.Compass.Settings.StreetName.Position.Y, {
                size = Config.Modules.Compass.Settings.StreetName.TextSize,
                colour = Config.Modules.Compass.Settings.StreetName.TextColor,
                outline = true,
                centered = Config.Modules.Compass.Settings.StreetName.Position.Centered
            })
        end
    

    end)
end

function CompassModule:StartCompassTick()
    CreateThread(function()
        if Config.Modules.Compass.Settings.Position.Centered then 
            Config.Modules.Compass.Settings.Position.X = Config.Modules.Compass.Settings.Position.X - Config.Modules.Compass.Settings.Width / 2
        end

        while Config.Modules.Compass.Settings.Show do 
            Wait(0)

            local pxDegree = Config.Modules.Compass.Settings.Width / Config.Modules.Compass.Settings.Fov
		    local playerHeadingDegrees = 0

            if Config.Modules.Compass.Settings.FollowGameplayCamera then 
                local camRot = GetGameplayCamRot(0)
                playerHeadingDegrees = 360.0 - ((camRot.z + 360.0) % 360.0)
            else 
                playerHeadingDegrees = 360.0 - GetEntityHeading(Client.ped)
            end

            local tickDegree = playerHeadingDegrees - Config.Modules.Compass.Settings.Fov / 2
            local tickDegreeRemainder = Config.Modules.Compass.Settings.TicksBetweenCardinals - (tickDegree % Config.Modules.Compass.Settings.TicksBetweenCardinals)
            local tickPosition = Config.Modules.Compass.Settings.Position.X + tickDegreeRemainder * pxDegree
            
            tickDegree = tickDegree + tickDegreeRemainder

            while tickPosition < Config.Modules.Compass.Settings.Position.X + Config.Modules.Compass.Settings.Width do
                if (tickDegree % 90.0) == 0 then
                    if Config.Modules.Compass.Settings.Cardinal.Tick.Show then
                        DrawRect(tickPosition, Config.Modules.Compass.Settings.Position.Y, Config.Modules.Compass.Settings.Cardinal.Tick.Size.Width, Config.Modules.Compass.Settings.Cardinal.Tick.Size.Height, Config.Modules.Compass.Settings.Cardinal.Tick.Color.R, Config.Modules.Compass.Settings.Cardinal.Tick.Color.G, Config.Modules.Compass.Settings.Cardinal.Tick.Color.B, Config.Modules.Compass.Settings.Cardinal.Tick.Color.A)
                    end
                    
                    self.DrawText(self.DegreesToIntercardinalDirection(tickDegree), tickPosition, Config.Modules.Compass.Settings.Position.Y + Config.Modules.Compass.Settings.Cardinal.Text.Offset, {
                        size = Config.Modules.Compass.Settings.Cardinal.Text.Size,
                        colour = Config.Modules.Compass.Settings.Cardinal.Text.Color,
                        outline = true,
                        centered = true
                    })
                elseif (tickDegree % 45.0) == 0 and Config.Modules.Compass.Settings.Intercardinal.Tick.Show then
                    if Config.Modules.Compass.Settings.Intercardinal.Tick.Show then
                        DrawRect(tickPosition, Config.Modules.Compass.Settings.Position.Y, Config.Modules.Compass.Settings.Intercardinal.Tick.Size.Width, Config.Modules.Compass.Settings.Intercardinal.Tick.Size.Height, Config.Modules.Compass.Settings.Intercardinal.Tick.Color.R, Config.Modules.Compass.Settings.Intercardinal.Tick.Color.G, Config.Modules.Compass.Settings.Intercardinal.Tick.Color.B, Config.Modules.Compass.Settings.Intercardinal.Tick.Color.A)
                    end
                    
                    if Config.Modules.Compass.Settings.Intercardinal.Text.Show then
                        self.DrawText(self.DegreesToIntercardinalDirection(tickDegree), tickPosition, Config.Modules.Compass.Settings.Position.Y + Config.Modules.Compass.Settings.Intercardinal.Text.Offset, {
                            size = Config.Modules.Compass.Settings.Intercardinal.Text.Size,
                            colour = Config.Modules.Compass.Settings.Intercardinal.Text.Color,
                            outline = true,
                            centered = true
                        })
                    end
                else
                    DrawRect(tickPosition, Config.Modules.Compass.Settings.Position.Y, Config.Modules.Compass.Settings.TickSize.Width, Config.Modules.Compass.Settings.TickSize.Height, Config.Modules.Compass.Settings.TickColor.R, Config.Modules.Compass.Settings.TickColor.B, Config.Modules.Compass.Settings.TickColor.A)
                end
                tickDegree = tickDegree + Config.Modules.Compass.Settings.TicksBetweenCardinals
                tickPosition = tickPosition + pxDegree * Config.Modules.Compass.Settings.TicksBetweenCardinals
            end
        end
    end)
end