BlindFireModule = setmetatable({}, BlindFireModule)

BlindFireModule.__call = function()
    return "BlindFireModule"
end

BlindFireModule.__index = BlindFireModule

function BlindFireModule.Load()
    return setmetatable({}, BlindFireModule)
end

function BlindFireModule:Run()
    if Config.Modules.BlindFire.Settings.Disable then
        if IsPedInCover(Client.ped, 1) and not IsPedAimingFromCover(Client.ped, 1) then 
			DisableControlAction(2, 24, true) 
			DisableControlAction(2, 142, true)
			DisableControlAction(2, 257, true)
		end	
    end
end