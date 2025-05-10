BodyBagModule = setmetatable({}, BodyBagModule)

BodyBagModule.__call = function()
    return "BodyBagModule"
end

BodyBagModule.__index = BodyBagModule

function BodyBagModule.Load()
    return setmetatable({
        deadCheck = false,
        attached = false,
        bodyBag = nil
    }, BodyBagModule)
end

function BodyBagModule:RegisterEvents()
    RegisterNetEvent("RSRPCore:Client:BodyBag:ToggleBag", function()
        self:ToggleBag()
    end)
end

function BodyBagModule:ToggleBag()
    self.deadCheck = IsEntityDead(Client.ped)

    if self.deadCheck and not self.attached then
        SetEntityVisible(Client.ped, false, false)

        Client:LoadModel(Config.Modules.BodyBag.Settings.BagModel)
        local bodyBagHash = GetHashKey(Config.Modules.BodyBag.Settings.BagModel)

        self.bodyBag = CreateObject(bodyBagHash, Client.position.x, Client.position.y, Client.position.z, true, true, true)

        AttachEntityToEntity(self.bodyBag, Client.ped, 0, -0.2, 0.75, -0.2, 0.0, 0.0, 0.0, false, false, false, false, 20, false)
        self.attached = true
    elseif self.attached then
        DetachEntity(Client.ped, true, false)
        SetEntityVisible(Client.ped, true, true)
        DeleteEntity(self.bodyBag)

        self.bodyBag = nil
        self.attached = false
    end
end

function BodyBagModule:BodyBagRemovalTick()
    CreateThread(function()
        while true do
            self.deadCheck = IsEntityDead(Client.ped)

            if not self.deadCheck and self.attached then
                DetachEntity(Client.ped, true, false)
                SetEntityVisible(Client.ped, true, true)
                DeleteEntity(self.bodyBag)

                self.bodyBag = nil
                self.attached = false
            end

            Wait(1000)
        end
    end)
end