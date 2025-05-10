CrouchModule = setmetatable({}, CrouchModule)

CrouchModule.__call = function()
    return "CrouchModule"
end

CrouchModule.__index = CrouchModule

function CrouchModule.Load()
    return setmetatable({
        stances = {
            Idle = 1,
            Stealth = 2,
            Crouch = 3,
            Prone = 4
        },
        controls = {
            ChangeState = 36,  -- CTRL
            FrontToBack = 21,   -- SHIFT
            Cancel = 22,        -- SPACE
            MoveFront = 32,
            MoveBack = 33,
            MoveLeft = 34,
            MoveRight = 35,
        },
        playerStance = 1,
        proneFront = true,
        lastProneChange = 0
    }, CrouchModule)
end

function CrouchModule:CancelState()
    ClearPedTasks(Client.ped)
    ForcePedMotionState(Client.ped, 247561816, 1, 1, 0)
    ResetPedMovementClipset(Client.ped, 0.5)
    ResetPedStrafeClipset(Client.ped)
    ClearPedTasksImmediately(Client.ped)
end

function CrouchModule:LaunchState()
    if self.playerStance == self.stances.Stealth then
        SetPedStealthMovement(Client.ped, true, 0)
    elseif self.playerStance == self.stances.Crouch then
        Client:LoadClipSet("move_m@fire")
        Client:LoadClipSet("move_ped_crouched")
        Client:LoadClipSet("move_ped_crouched_strafing")
        SetPedMovementClipset(Client.ped, "move_m@fire", 0.5)
        SetPedMovementClipset(Client.ped, "move_ped_crouched", 0.5)
        SetPedStrafeClipset(Client.ped, "move_ped_crouched_strafing")
        RemoveClipSet("move_m@fire")
        RemoveClipSet("move_ped_crouched")
        RemoveClipSet("move_ped_crouched_strafing")
    end
end

function CrouchModule:ChangeState()
    if self.playerStance == self.stances.Idle and not GetPedStealthMovement(Client.ped) then
        self.playerStance = self.stances.Stealth
    end

    if self.playerStance == self.stances.Idle then

        self.playerStance = self.stances.Stealth
        self:LaunchState()

    elseif self.playerStance == self.stances.Stealth then

        self.playerStance = self.stances.Crouch
        self:LaunchState()

    elseif self.playerStance == self.stances.Crouch then

        self.playerStance = self.stances.Idle
        self:CancelState()

    elseif self.playerStance == self.stances.Prone then

        self.playerStance = self.stances.Idle
        self:CancelState()

    end
end

function CrouchModule:LaunchProne()
    if IsPedRunning(Client.ped) or IsPedSprinting(Client.ped) then
        self.proneFront = true
        Client:LoadAnimDict("move_jump")
        TaskPlayAnim(Client.ped, "move_jump", "dive_start_run", 8.0, -8.0, -1, 2, 0)
        Wait(1100)
        RemoveAnimDict("move_jump")
    end

    local anim = "onfront_fwd"

    if not self.proneFront then
        anim = "onback_fwd" 
    end

    Client:LoadAnimDict("move_crawl")

    local rotation = GetEntityRotation(Client.ped)

    TaskPlayAnimAdvanced(Client.ped, "move_crawl", anim, Client.position, rotation, 8.0, -8.0, -1, 2, 1000.0, 2, 0)

    RemoveAnimDict("move_crawl")
end

function CrouchModule:HandleProneMovement(front)
    local anim = "onfront_"

    if not self.proneFront then
        anim = "onback_" 
    end

    if front then
        anim = anim .. 'fwd'
    else
        anim = anim .. 'bwd'
    end

    Client:LoadAnimDict("move_crawl")
    
    TaskPlayAnim(playerPed, "move_crawl", anim, 8.0, -8.0, -1, 2, 0)
    Wait((GetAnimDuration("move_crawl", anim) - 0.1) * 1000)

    RemoveAnimDict("move_crawl")
end

function CrouchModule:HandleProneRotation(left)
    local dh = -0.75

    if left then
        dh = 0.75
    end

    SetEntityHeading(Client.ped, GetEntityHeading(Client.ped) + dh)
end

function CrouchModule:Run()
    if not IsPedInAnyVehicle(Client.ped) then
        if IsControlJustPressed(1, self.controls.ChangeState) then
            self:ChangeState()
        end

        if IsControlPressed(1, self.controls.ChangeState) then
            local Timer = 0
            
            while IsControlPressed(1, self.controls.ChangeState) do
                Wait(100)
                Timer = Timer + 100
                if Timer >= 500 then
                    self.playerStance = self.stances.Prone
                    self:LaunchProne()
                end
            end
        end

        if self.playerStance ~= self.stances.Idle then

            DisableControlAction(1, self.controls.Cancel, true)

            if IsDisabledControlJustPressed(1, self.controls.Cancel) then
                self.playerStance = self.stances.Idle
                self:CancelState()
            end
        end

        if self.playerStance == self.stances.Prone then

            if IsControlJustPressed(1, self.controls.FrontToBack) then
                if GetGameTimer() - self.lastProneChange > 2000 then
                    self.proneFront = not self.proneFront
                    self.lastProneChange = GetGameTimer()
                    SetEntityHeading(Client.ped, (GetEntityHeading(Client.ped) + 180) % 360)
                    self:LaunchProne()
                end
            end

            if IsControlPressed(1, self.controls.MoveFront) then
                self:HandleProneMovement(true)
            elseif IsControlPressed(1, self.controls.MoveBack) then
                self:HandleProneMovement(false)
            end

            if IsControlPressed(1, self.controls.MoveLeft) then
                self:HandleProneRotation(true)
            elseif IsControlPressed(1, self.controls.MoveRight) then
                self:HandleProneRotation(false)
            end

        end
    end
end