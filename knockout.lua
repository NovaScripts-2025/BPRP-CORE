KnockoutModule = setmetatable({}, KnockoutModule)

KnockoutModule.__call = function()
    return "KnockoutModule"
end

KnockoutModule.__index = KnockoutModule

function KnockoutModule.Load()
    return setmetatable({
        active = false,
        prev = 200,
        health = 200,
        damage = 0,
        timer = 0,
        reducing = false
    }, KnockoutModule)
end

function KnockoutModule:RegisterEvents()
    AddEventHandler("RSRPWI:Client:InteractedWithWorldEntity", function(entity)
        if IsEntityAPed(entity) and IsPedAPlayer(entity) then
            local player = NetworkGetPlayerIndexFromPed(entity)
            local serverId = GetPlayerServerId(player)
            if Player(serverId).state.knockedOut then
                TriggerServerEvent("RSRPCore:Server:Knockout:HelpPlayer", serverId)
            end
        end
    end)

    RegisterNetEvent("RSRPCore:Client:Knockout:HelpPlayer", function()
        self.active = false
        self.timer = 0
        self.damage = 0
        SetPedToRagdoll(Client.ped, 100, 100, 0, 0, 0, 0)
        if Config.Modules.KnockOut.Settings.BlackoutScreen then
            DoScreenFadeIn(8000)
        end
    end)
end

function KnockoutModule:KnockoutPlayer(length)
    self.timer = length
    self.active = true
    SetPedToRagdoll(Client.ped, 6000, 6000, 0, 0, 0, 0)
    LocalPlayer.state:set("knockedOut", true, true)
    if Config.Modules.KnockOut.Settings.BlackoutScreen then DoScreenFadeOut(1000) end

    CreateThread(function()
        while self.active do
            Wait(5000)
            self.timer = self.timer - 5
            if self.timer <= 0 then
                if Config.Modules.KnockOut.Settings.BlackoutScreen then
                    DoScreenFadeIn(10000)
                end
                self.damage = 0
                self.active = false
                LocalPlayer.state:set("knockedOut", false, true)
            else
                SetPedToRagdoll(Client.ped, 6000, 6000, 0, 0, 0, 0)
                ResetPedRagdollTimer(Client.ped)
            end
        end
    end)
end

function KnockoutModule:ReduceDamage()
    if not self.reducing and Config.Modules.KnockOut.Settings.ReduceDamageAmount > 0 then
        self.reducing = true
        CreateThread(function()
            while self.damage > 0 do
                Wait(5000)
                self.damage = self.damage - Config.Modules.KnockOut.Settings.ReduceDamageAmount
                if self.damage < 0 then
                    self.damage = 0
                end
            end
            self.reducing = false
        end)
    end
end

function KnockoutModule:Run()
    self.health = GetEntityHealth(Client.ped)

    if self.active and not Config.Modules.KnockOut.Settings.BlackoutScreen then
        DisablePlayerFiring(Client.handle, true)
    end

    if self.active and Config.Modules.KnockOut.Settings.DieAfterKnockout then
        -- Ignore
    else
        if self.health < self.prev then
            if HasEntityBeenDamagedByWeapon(Client.ped, 0xA2719263, 0) then -- Fists
                self.damage = self.damage + (self.prev - self.health)
                self:ReduceDamage()
                ClearPedLastWeaponDamage(Client.ped)
                SetEntityHealth(Client.ped, self.prev)
                if self.damage > Config.Modules.KnockOut.Settings.MaximumDamageKnockout then
                    self:KnockoutPlayer(Config.Modules.KnockOut.Settings.KnockoutLengthFist)
                end
            elseif not Config.Modules.KnockOut.Settings.FistsOnly then
                if HasEntityBeenDamagedByWeapon(Client.ped, 0, 1) then -- Blunt Melee
                    self.damage = self.damage + (self.prev - self.health)
                    self:ReduceDamage()
                    ClearPedLastWeaponDamage(Client.ped)
                    SetEntityHealth(Client.ped, self.prev)
                    if self.damage > Config.Modules.KnockOut.Settings.MaximumDamageKnockout then
                        self:KnockoutPlayer(Config.Modules.KnockOut.Settings.KnockoutLengthMelee)
                    end
                end
            end
        end
    end
    self.prev = self.health
 end


