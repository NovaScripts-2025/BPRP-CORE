GasMaskModule = setmetatable({}, GasMaskModule)

GasMaskModule.__call = function()
    return "GasMaskModule"
end

GasMaskModule.__index = GasMaskModule

function GasMaskModule.Load()
    return setmetatable({
        gasMaskOn = false,
        wearingMask = false,
        isAllowed = false
    }, GasMaskModule)
end

function GasMaskModule:RegisterEvents()
    TriggerServerEvent("RSRPCore:Server:GasMask:GetPermissions")

    RegisterNetEvent("RSRPCore:Client:GasMask:ReturnPermissions", function(isAllowed)
        self.isAllowed = isAllowed
    end)
end

function GasMaskModule:RegisterCommands()
    RegisterCommand("gasmask", function(source, args)
        if self.isAllowed then
            if args[1] == "on" then
                if not self.gasMaskOn then
                    self:PlayEmote()
                    SetPedComponentVariation(Client.ped, 1, Config.Modules.GasMask.Settings.Mask, 0, 1)
                else
                    TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Gas Mask", "Your gas mask is already equipped")
                end
            elseif args[1] == "off" then
                if self.gasMaskOn then
                    self:PlayEmote()
                    SetPedComponentVariation(Client.ped, 1, 0, 0, 1)
                    TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Gas Mask", "You have un-equipped your gas mask")
                else
                    TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Gas Mask", "Your gas mask is already un-equipped")
                end
            else
                TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Gas Mask", "Please specify whether you wish to equip or un-equip the mask (on/off)")
            end
        else
            TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Gas Mask", "~r~You are not allowed to wear a gas mask")
        end
    end)
end

function GasMaskModule:PlayEmote()
    Client:LoadAnimDict('mp_masks@standard_car@ds@')
    TaskPlayAnim(Client.ped, 'mp_masks@standard_car@ds@', 'put_on_mask', 8.0, 8.0, 800, 16, 0, false, false, false)
end

function GasMaskModule:StartScreenEffect()
    AnimpostfxPlay("RampageOut", 0, true)
end

function GasMaskModule:StopScreenEffect()
    AnimpostfxStop("RampageOut")
end

function GasMaskModule:Run()
    if Config.Modules.GasMask.Settings.Mask == GetPedDrawableVariation(Client.ped, 1) then
        self.wearingMask = true
    else
        self.wearingMask = false
    end

    if self.wearingMask then
        if self.isAllowed then
            self.gasMaskOn = true
            SetEntityProofs(Client.ped, false, false, false, false, false, false, true, true, false)
            self:StartScreenEffect()
        else
            self.gasMaskOn = false
            SetPedComponentVariation(Client.ped, 1, 0, 0, 1)
            TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Gas Mask", "~r~You are not allowed to wear a gas mask")
        end
    else
        self.gasMaskOn = false
        SetEntityProofs(Client.ped, false, false, false, false, false, false, false, false, false)
        self:StopScreenEffect()
    end
end