PickupsModule = setmetatable({}, PickupsModule)

PickupsModule.__call = function()
    return "PickupsModule"
end

PickupsModule.__index = PickupsModule

function PickupsModule.Load()
    return setmetatable({
        weaponPickups = {}
    }, PickupsModule)
end

function PickupsModule:RegisterEvents()
    RegisterNetEvent("RSRPCore:Client:Pickups:CreateWeaponDrop", function(data)
        self:CreateWeaponDrop(data)
    end)

    TriggerServerEvent("RSRPCore:Server:Pickups:SyncWeaponDrops")
    RegisterNetEvent("RSRPCore:Client:Pickups:SyncWeaponDrops", function(pickupData)
        for _, data in ipairs(pickupData) do
            self:CreateWeaponDrop(data)
        end
    end)

    RegisterNetEvent("RSRPCore:Server:Pickups:RemoveWeaponDrop", function(id)
        for k, data in ipairs(self.weaponPickups) do
            if data.id == id then 
                RemovePickup(data.pickup)
                table.remove(self.weaponPickups, k)
            end
        end
    end)
end

function PickupsModule:CreateWeaponDrop(pickupData)
    local pickupHash = GetPickupHashFromWeapon(pickupData.weapon)
    local pickup = CreatePickupRotate(pickupHash, pickupData.coords, 0.0, 0.0, 0.0, 8, 0, false, 0)
    table.insert(self.weaponPickups, {
        id = pickupData.id,
        coords = pickupData.coords,
        pickup = pickup
    })

    CreateThread(function()
        while DoesPickupExist(pickup) do
            Wait(50)

            if not IsPedDeadOrDying(PlayerPedId()) and HasPickupBeenCollected(pickup) then
                TriggerServerEvent("RSRPCore:Server:Pickups:TryPickupWeapon", pickupData.id)
                break
            end
        end
    end)
end
