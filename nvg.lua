NVGModule = setmetatable({}, NVGModule)

NVGModule.__call = function()
    return "NVGModule"
end

NVGModule.__index = NVGModule

local function EmitSound(sound)
    TriggerServerEvent('InteractSound_SV:PlayOnSource', sound, 0.05)
end

function NVGModule.Load()
    return setmetatable({
        NVGon = false,
        wearingGlasses = false,
        isAllowed = false,
        hasNotified = false
    }, NVGModule)
end

function NVGModule:RegisterEvents()
    TriggerServerEvent("RSRPCore:Server:NVG:GetPermissions")

    RegisterNetEvent("RSRPCore:Client:NVG:ReturnPermissions", function(isAllowed)
        self.isAllowed = isAllowed
    end)
end

function NVGModule:RegisterKeys()
    RegisterKeyMapping("+togglenvgs", "Toggle NVG's", "keyboard", "N")

    RegisterCommand("+togglenvgs", function(source, args)
        if self.wearingGlasses then
            if self.isAllowed then
                if self.NVGon then
                    self:PlayEmote()
                    Wait(500)
                    SetPedPropIndex(Client.ped, Config.Modules.NVG.Settings.Glasses, Config.Modules.NVG.Settings.NVGOffDrawableId, 1)
                    SetNightvision(false)
                    self.NVGon = false
                else
                    self:PlayEmote()
                    Wait(500)
                    SetPedPropIndex(Client.ped, Config.Modules.NVG.Settings.Glasses, Config.Modules.NVG.Settings.NVGOnDrawableId, 1)
                    EmitSound('nvg-on')
                    SetNightvision(true)
                    self.NVGon = true
                end  
            else
                TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Night Vision Goggles", "~r~You are not allowed to toggle NVG's")
            end       
        end
    end)

    RegisterCommand("-togglenvgs", function() end)
end

function NVGModule:PlayEmote()
    Client:LoadAnimDict('mp_masks@standard_car@ds@')
    TaskPlayAnim(Client.ped, 'mp_masks@standard_car@ds@', 'put_on_mask', 8.0, 8.0, 800, 16, 0, false, false, false)
end

function NVGModule:IsPedWearingNVGs()
    if GetPedPropIndex(Client.ped, Config.Modules.NVG.Settings.Glasses) == 1 or GetPedPropIndex(Client.ped, Config.Modules.NVG.Settings.Glasses) == 2 then
        return true
    else
        return false
    end
end

function NVGModule:Run()
    if self:IsPedWearingNVGs() then
        self.wearingGlasses = true

        if not self.hasNotified and self.isAllowed then
            Client:ShowHelpNotification("Press ~INPUT_REPLAY_ENDPOINT~ to toggle your NVG's on and off", false, true)
            self.hasNotified = true
        end
    else
        self.wearingGlasses = false
        self.hasNotified = false
    end

    if self.wearingGlasses and self.isAllowed  then
        SetEntityProofs(Client.ped, false, false, false, false, false, false, true, true, false)
    else
        SetEntityProofs(Client.ped, false, false, false, false, false, false, false, false, false)
    end
end