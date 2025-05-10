FlashlightModule = setmetatable({}, FlashlightModule)

FlashlightModule.__call = function()
    return "FlashlightModule"
end

FlashlightModule.__index = FlashlightModule

function FlashlightModule.Load()
    return setmetatable({
        --[[
        flashlightVectors = {
            [`COMPONENT_AT_AR_FLSH`] = {
                vector3(0.5, 0.03, 0.05),
                vector3(1.0, -0.16, 0.145)
            },
            [`COMPONENT_AT_PI_FLSH`] = {
                vector3(0.28, 0.04, 0.0),
                vector3(1.0, -0.12, 0.05)
            },
            [`COMPONENT_AT_PI_FLSH_02`] = {
                vector3(0.28, 0.04, 0.0),
                vector3(1.0, -0.135, 0.05)
            },
            [`COMPONENT_AT_PI_FLSH_03`] = {
                vector3(0.28, 0.04, 0.0),
                vector3(1.0, -0.135, 0.05)
            },
            [`COMPONENT_HK416_SPEC_FLSH`] = {
                vector3(0.5, 0.03, 0.05),
                vector3(1.0, -0.16, 0.145)
            },
            [`COMPONENT_HK417_FLSH_01`] = {
                vector3(0.5, 0.03, 0.05),
                vector3(1.0, -0.16, 0.145)
            },
            [`COMPONENT_HK417_FLSH_02`] = {
                vector3(0.5, 0.03, 0.05),
                vector3(1.0, -0.16, 0.145)
            },
            [`COMPONENT_HK417_FLSH_03`] = {
                vector3(0.5, 0.03, 0.05),
                vector3(1.0, -0.16, 0.145)
            },
        }
        ]]--
        flashlightEnabled = false
    }, FlashlightModule)
end

-- Runs every tick
function FlashlightModule:FlashlightToggle()
    local weaponHash = GetSelectedPedWeapon(Client.ped)
    for _, componentHash in ipairs(Config.Modules.Flashlight.Settings.ComponentList) do
        if not IsEntityDead(Client.ped) and HasPedGotWeaponComponent(Client.ped, weaponHash, componentHash) then
            if IsControlJustPressed(0, 54) then
                self.flashlightEnabled = not self.flashlightEnabled
                PlaySoundFrontend(-1, "COMPUTERS_MOUSE_CLICK", "", true)
                if self.flashlightEnabled then  
                    SetFlashLightEnabled(Client.ped, false)
                    SetFlashLightKeepOnWhileMoving(false)
                else
                    SetFlashLightEnabled(Client.ped, true)
                    SetFlashLightKeepOnWhileMoving(true)
                end
                break
            end
        end
    end
end

function FlashlightModule:RenderFlashlight()
    --[[
    for _, player in ipairs(GetActivePlayers()) do
        local serverId = GetPlayerServerId(player)
        local playerPed = GetPlayerPed(player)
        if playerPed ~= 0 then
            if Player(serverId).state["ToggleWeaponFlashlight"] then
                local weaponHash = GetSelectedPedWeapon(playerPed)
                if Config.Modules.Flashlight.Settings.WeaponList[weaponHash] then
                    local componentHash = Config.Modules.Flashlight.Settings.WeaponList[weaponHash]
                    if HasPedGotWeaponComponent(playerPed, weaponHash, componentHash) then
                         if not IsPedInAnyVehicle(playerPed, true) then
                            local vectors = self.flashlightVectors[componentHash]
                            if vectors then               
                                local pos = GetPedBoneCoords(playerPed, 0xDEAD, vectors[1])
                                local dir = GetPedBoneCoords(playerPed, 0xDEAD, vectors[2])
                                local dirVector = dir - pos
                                local vectorMag = Vmag2(dirVector)
                                local posEnd = vector3(dirVector.x / vectorMag, dirVector.y / vectorMag, dirVector.z / vectorMag)

                                DrawSpotLight(pos, posEnd, 255, 175, 145, 40.0, 2.0, 2.0, 10.0, 15.0)
                                --DrawLightWithRange(pos, 255, 175, 145, 0.5, 60.0)
                            end
                        end
                    end
                end
            end
        end
    end
    ]]--
end

function FlashlightModule:Run()
    self:FlashlightToggle()
    --self:RenderFlashlight()
end