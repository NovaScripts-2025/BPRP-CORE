WastedScreenModule = setmetatable({}, WastedScreenModule)

WastedScreenModule.__call = function()
    return "WastedScreenModule"
end

WastedScreenModule.__index = WastedScreenModule

function WastedScreenModule.Load()
    return setmetatable({
        lockSound = false
    }, WastedScreenModule)
end

function WastedScreenModule:RegisterEvents()
    -- Killed by a player
    AddEventHandler("baseevents:onPlayerKilled", function(killerPly)
        local wastedSlogan = Player(killerPly).state.customWastedSlogan
        local wastedMessage = Player(killerPly).state.customWastedMessage

        --StartScreenEffect('DeathFailMPIn', 0, 0)

		if not self.lockSound then
            PlaySoundFrontend(-1, "Bed", "WastedSounds", 0)
			self.lockSound = false
		end

		--[[ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 0.1)
        SetCamEffect(1)]]--

        local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

        while not HasScaleformMovieLoaded(scaleform) do
            Wait(100)
        end

        BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		ScaleformMovieMethodAddParamTextureNameString((wastedMessage and wastedMessage or Config.Modules.WastedScreen.Settings.DefaultWastedMessage))
        ScaleformMovieMethodAddParamTextureNameString((wastedSlogan and wastedSlogan or Config.Modules.WastedScreen.Settings.DefaultWastedSlogan))
        ScaleformMovieMethodAddParamInt(6)
		EndScaleformMovieMethod()

        Wait(750)

        --PlaySoundFrontend(-1, 'MP_Flash', 'WastedSounds', false)

        while IsEntityDead(Client.ped) do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)

            Wait(0)
        end
        
        --SetCamEffect(0)
        --StopScreenEffect('DeathFailMPIn')
        self.lockSound = false

        --[[if IsGameplayCamShaking() then
            StopGameplayCamShaking(false)
        end]]--

        SetFocusEntity(Client.ped)
    end)

    AddEventHandler("baseevents:onPlayerDied", function()
        --StartScreenEffect('DeathFailMPIn', 0, 0)

		--[[if not self.lockSound then
            PlaySoundFrontend(-1, "Bed", "WastedSounds", 0)
			self.lockSound = false
		end]]--

		--ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 0.1)
        --SetCamEffect(1)

        local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

        while not HasScaleformMovieLoaded(scaleform) do
            Wait(100)
        end

        BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		ScaleformMovieMethodAddParamTextureNameString(Config.Modules.WastedScreen.Settings.DefaultWastedMessage)
        ScaleformMovieMethodAddParamTextureNameString(Config.Modules.WastedScreen.Settings.SuicideSlogan)
        ScaleformMovieMethodAddParamInt(6)
		EndScaleformMovieMethod()

        Wait(750)

        --PlaySoundFrontend(-1, 'MP_Flash', 'WastedSounds', false)

        local timer = GetGameTimer()

        while IsEntityDead(Client.ped) do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)

            Wait(0)
        end
        
        SetCamEffect(0)
        StopScreenEffect('DeathFailMPIn')
        --self.lockSound = false

        --[[if IsGameplayCamShaking() then
            StopGameplayCamShaking(false)
        end]]--

        SetFocusEntity(Client.ped)
    end)
end