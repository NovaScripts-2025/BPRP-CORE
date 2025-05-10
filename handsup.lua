HandsUpModule = setmetatable({}, HandsUpModule)

HandsUpModule.__call = function()
    return "HandsUpModule"
end

HandsUpModule.__index = HandsUpModule

function HandsUpModule.Load()
    return setmetatable({
        dict = "missminuteman_1ig_2",
        handsup = false
    }, HandsUpModule)
end

function HandsUpModule:RegisterKeys()
    RegisterKeyMapping("+handsup", "Put your hands up", "keyboard", "X")

    RegisterCommand("+handsup", function()
        if not self.handsup then
            Client:LoadAnimDict(self.dict)
            TaskPlayAnim(Client.ped, self.dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
            SetCurrentPedWeapon(Client.ped, `weapon_unarmed`, true)
            SetPedCanSwitchWeapon(Client.ped, false)
            self.handsup = true
            LocalPlayer.state:set('HandsUp', true, true)
        else
            self.handsup = false
            SetPedCanSwitchWeapon(Client.ped, true)
            ClearPedTasks(Client.ped)
            RemoveAnimDict(self.dict)
            LocalPlayer.state:set('HandsUp', false, true)
        end
    end)

    RegisterCommand("-handsup", function() end)
end
