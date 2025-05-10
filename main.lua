
local ClientClass = setmetatable({}, ClientClass)

ClientClass.__call = function()
    return "ClientClass"
end

ClientClass.__index = ClientClass

function ClientClass.Load()
    local client = {}
    client.ped = PlayerPedId()
    client.position = GetEntityCoords(client.ped)
    client.handle = PlayerId()
    client.isDead = IsEntityDead(client.ped)
    client.serverId = GetPlayerServerId(client.handle)
    client.name = GetPlayerName(client.handle)
    client.currentVehicle = GetVehiclePedIsIn(client.ped, false)
    client.modules = {}
    return setmetatable(client, ClientClass)
end

function ClientClass:LoadModules()
    if Config.Modules.DiscordPresence.Enabled then
        self.modules.Presence = PresenceModule.Load()
        self.modules.Presence:RegisterEvents()
        self.modules.Presence:Setup()
    end

    if Config.Modules.TextureReload.Enabled then
        self.modules.TextureReload = TextureReloadModule.Load()
        self.modules.TextureReload:RegisterCommands()
    end

    if Config.Modules.StaffBlips.Enabled then
        self.modules.StaffBlips = StaffBlipsModule.Load()
        self.modules.StaffBlips:RegisterEvents()
    end

    if Config.Modules.NoDriveBy.Enabled then 
        self.modules.NoDriveBy = NoDriveByModule.Load()
    end

    if Config.Modules.NeverWanted.Enabled then 
        self.modules.NeverWanted = NeverWantedModule.Load()
    end

    if Config.Modules.Drilling.Enabled then
        self.modules.Drilling = DrillingModule.Load()
        self.modules.Drilling:RegisterCommands()
        self.modules.Drilling:RegisterEvents()
        self.modules.Drilling:StartLockpickTick()
    end

    if Config.Modules.KeepDoorsOpen.Enabled then 
        self.modules.KeepDoorsOpen = KeepDoorsOpenModule.Load()
    end

    if Config.Modules.GasMask.Enabled then
        self.modules.GasMask = GasMaskModule.Load()
        self.modules.GasMask:RegisterCommands()
        self.modules.GasMask:RegisterEvents()
    end

    if Config.Modules.NVG.Enabled then
        self.modules.NVG = NVGModule.Load()
        self.modules.NVG:RegisterKeys()
        self.modules.NVG:RegisterEvents()
    end

    if Config.Modules.Flashlight.Enabled then
        self.modules.Flashlight = FlashlightModule.Load()
    end

    if Config.Modules.SeatShuffle.Enabled then 
        self.modules.SeatShuffle = SeatShuffleModule.Load()
        self.modules.SeatShuffle:RegisterCommands()
    end

    if Config.Modules.Crouch.Enabled then 
        self.modules.Crouch = CrouchModule.Load()
    end

    if Config.Modules.Fuel.Enabled then 
        self.modules.Fuel = FuelModule.Load()
        self.modules.Fuel:RegisterEvents()
        self.modules.Fuel:ManageFuelTick()
        self.modules.Fuel:NearPumpTick()

        for _, position in pairs(Config.Modules.Fuel.Settings.GasStations) do
			self.modules.Fuel:CreatePumpBlip(position)
		end
    end

    if Config.Modules.BodyBag.Enabled then
        self.modules.BodyBag = BodyBagModule.Load()
        self.modules.BodyBag:RegisterEvents()
        self.modules.BodyBag:BodyBagRemovalTick()
    end

    if Config.Modules.CarHud.Enabled then 
        self.modules.CarHud = CarHudModule.Load()
    end

    if Config.Modules.GamerTags.Enabled then 
        self.modules.GamerTags = GamerTagsModule.Load()
    end

    if Config.Modules.SaveWheelPos.Enabled then 
        self.modules.SaveWheelPos = SaveWheelPosModule.Load()
    end

    if Config.Modules.DV.Enabled then 
        self.modules.DV = DVModule.Load()
        self.modules.DV:RegisterCommands()
    end

    if Config.Modules.Pickups.Enabled then 
        self.modules.Pickups = PickupsModule.Load()
        self.modules.Pickups:RegisterEvents()
    end

    if Config.Modules.Permissions.Enabled then 
        self.modules.Permissions = PermissionsModule.Load()
        self.modules.Permissions:RegisterEvents()
    end

    if Config.Modules.Compass.Enabled then 
        self.modules.Compass = CompassModule.Load()
        self.modules.Compass:StartCompassTick()
        self.modules.Compass:StartStreetNameTick()
    end

    if Config.Modules.HandsUp.Enabled then 
        self.modules.HandsUp = HandsUpModule.Load()
        self.modules.HandsUp:RegisterKeys()
    end

    if Config.Modules.WastedScreen.Enabled then
        self.modules.WastedScreen = WastedScreenModule.Load()
        self.modules.WastedScreen:RegisterEvents()
    end

    if Config.Modules.AutoMod.Enabled then
        self.modules.AutoMod = AutoModModule.Load()
        self.modules.AutoMod:StartAfkTick()
    end

    if Config.Modules.Safezone.Enabled then
        self.modules.Safezone = SafezoneModule.Load()
        self.modules.Safezone:SetupSafezones()
    end

    if Config.Modules.CombatRoll.Enabled then 
        self.modules.CombatRoll = CombatRollModule.Load()
    end

    if Config.Modules.BlindFire.Enabled then 
        self.modules.BlindFire = BlindFireModule.Load()
    end

    if Config.Modules.KnockOut.Enabled then
        self.modules.KnockOut = KnockoutModule.Load()
        self.modules.KnockOut:RegisterEvents()
    end
end

function ClientClass:LoadAnimDict(dict)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
end

function ClientClass:LoadClipSet(set)
    RequestClipSet(set)

    while not HasClipSetLoaded(set) do
        Wait(100)
    end
end 

function ClientClass:LoadModel(model)
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(100)
    end
end 

function ClientClass:RaycastGetVehicleInFront()
    local entityWorld = GetOffsetFromEntityInWorldCoords(self.ped, 0.0, 3.0, 0.0)
    local rayHandle = StartShapeTestLosProbe(self.position.x, self.position.y, self.position.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, self.ped, 0)
    local a, b, c, d, result
    repeat
        a, b, c, d, result = GetShapeTestResult(rayHandle)
        Wait(0)
    until a == 2    
    return result
end

function ClientClass:Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)

	return math.floor(num * mult + 0.5) / mult
end

function ClientClass:DistanceTo(coords)
    return #(Client.position - coords)
end

function ClientClass:Draw2DText(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function ClientClass:RegisterEvents()
    RegisterNetEvent("RSRPCore:Client:SendRiversideNotification")
    AddEventHandler("RSRPCore:Client:SendRiversideNotification", function(subject, message)
        self:SendRiversideNotification(subject, message)
    end)

    RegisterNetEvent("RSRPCore:Client:SendCustomNotification")
    AddEventHandler("RSRPCore:Client:SendCustomNotification", function(title, subject, message, textureDict, textureName)
        self:SendCustomNotification(title, subject, message, textureDict, textureName)
    end)
end

function ClientClass:SendRiversideNotification(subject, message)
    if not HasStreamedTextureDictLoaded("rsrptextures") then
        RequestStreamedTextureDict("rsrptextures")

        while not HasStreamedTextureDictLoaded("rsrptextures") do
            Wait(100)
        end
    end    
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    EndTextCommandThefeedPostMessagetext("rsrptextures", "rsrplogo", true, 4, "Riverside Roleplay", subject)
    DrawNotification(false, true)
end

function ClientClass:SendCustomNotification(title, subject, message, textureDict, textureName)
    AddTextEntry("RSRPCore:Notification", message)
    BeginTextCommandThefeedPost("RSRPCore:Notification")
    ThefeedSetNextPostBackgroundColor(140)
    EndTextCommandThefeedPostMessagetext(textureDict, textureName, false, 4, title, subject)
    EndTextCommandThefeedPostTicker(true, false)
end

function ClientClass:SendBasicNativeNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)
end 

function ClientClass:ShowHelpNotification(msg, thisFrame, beep, duration)
    AddTextEntry('RSRPCore:HelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('RSRPCore:HelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('RSRPCore:HelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

function ClientClass:StartMasterThread()
    TriggerEvent('chat:removeSuggestion', '/personalstorepurchase')
    TriggerEvent('chat:removeSuggestion', '/globalstorepurchase')

    TriggerEvent('chat:addSuggestion', '/forgotpin', 'Remind yourself of your phone pin')

    SetFlashLightKeepOnWhileMoving(true)
    NetworkSetLocalPlayerSyncLookAt(true)

    CreateThread(function()
        while true do 
            self.ped = PlayerPedId()
            self.position = GetEntityCoords(self.ped)
            self.currentVehicle = GetVehiclePedIsIn(self.ped, false)

            SetPedDropsWeaponsWhenDead(self.ped, true)

            if Config.Modules.NoDriveBy.Enabled then 
                self.modules.NoDriveBy:Run()
            end

            if Config.Modules.StaffBlips.Enabled then
                self.modules.StaffBlips:Run()
            end

            if Config.Modules.NeverWanted.Enabled then 
                self.modules.NeverWanted:Run()
            end

            if Config.Modules.KeepDoorsOpen.Enabled then 
                self.modules.KeepDoorsOpen:Run()
            end

            if Config.Modules.GasMask.Enabled then
                self.modules.GasMask:Run()
            end

            if Config.Modules.NVG.Enabled then
                self.modules.NVG:Run()
            end

            if Config.Modules.Flashlight.Enabled then
                self.modules.Flashlight:Run()
            end

            if Config.Modules.SeatShuffle.Enabled then 
                self.modules.SeatShuffle:Run()
            end

            if Config.Modules.Crouch.Enabled then 
                self.modules.Crouch:Run()
            end

            if Config.Modules.Fuel.Enabled then 
                self.modules.Fuel:Run()
            end

            if Config.Modules.GamerTags.Enabled then 
                self.modules.GamerTags:Run()
            end

            if Config.Modules.CarHud.Enabled then 
                self.modules.CarHud:Run()
            end

            if Config.Modules.SaveWheelPos.Enabled then 
                self.modules.SaveWheelPos:Run()
            end

            if Config.Modules.CombatRoll.Enabled then 
                self.modules.CombatRoll:Run()
            end
        
            if Config.Modules.BlindFire.Enabled then 
                self.modules.BlindFire:Run()
            end

            if Config.Modules.KnockOut.Enabled then
                self.modules.KnockOut:Run()
            end

            if Config.Modules.Safezone.Enabled then
                self.modules.Safezone:Run()
            end
            Wait(0)
        end
    end)
end

CreateThread(function()
    Client = ClientClass.Load()
    Client:RegisterEvents()
    Client:LoadModules()
    Client:StartMasterThread()
end)