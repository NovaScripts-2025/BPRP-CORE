AutoModModule = setmetatable({}, AutoModModule)

AutoModModule.__call = function()
    return "AutoModModule"
end

AutoModModule.__index = AutoModModule

function AutoModModule.Load()
    return setmetatable({
        afkTime = 0,
        previousCoords = nil,
        prefix = "^8[^7Automod^8] "
    }, AutoModModule)
end

function AutoModModule:StartAfkTick()
    CreateThread(function()
        while true do
            if DoesEntityExist(Client.ped) then
                local coords = GetEntityCoords(Client.ped)
                if coords == self.previousCoords then
                    if self.afkTime > 0 then
                        if Config.Modules.AutoMod.Settings.AfkKickWarning and self.afkTime == math.ceil(Config.Modules.AutoMod.Settings.SecondsUntilAfkKicked / 4) then
                            --TriggerEvent('ns_notify:sendNotify', "Auto Mod", "You will be kicked in "..self.afkTime.." seconds!", 5000, 'warning')
                            TriggerEvent("413x-notify:Alert", "warning", "Auto Mod", "You will be kicked in "..self.afkTime.." seconds!", 5000)
                        end
                        self.afkTime = self.afkTime - 1
                    else
                        TriggerServerEvent("RSRPCore:Server:AutoMod:AfkKickPlayer")
                    end
                else
                    self.afkTime = Config.Modules.AutoMod.Settings.SecondsUntilAfkKicked
                end
                self.previousCoords = coords
            end
            Wait(1000)
        end
    end)
end