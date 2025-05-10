GamerTagsModule = setmetatable({}, GamerTagsModule)

GamerTagsModule.__call = function()
    return "GamerTagsModule"
end

GamerTagsModule.__index = GamerTagsModule

function GamerTagsModule.Load()
    return setmetatable({
        disableHeadTag = false,
        showTags = true
    }, GamerTagsModule)
end


function GamerTagsModule:DrawHeadTagText(position, text)
    local onScreen,_x, _y = GetScreenCoordFromWorldCoord(position.x, position.y, position.z + 0.35)
    local pCoords = GetGameplayCamCoords()
    local dist = #(pCoords - position)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(4)
        SetTextProportional(true)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(50, 210, 210, 210, 255)
		SetTextOutline()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GamerTagsModule:Run()
    if IsControlJustPressed(0, 212) then
        self.showTags = not self.showTags
    end

    if self.showTags then
        for _, ply in ipairs(GetActivePlayers()) do 
            local ped = GetPlayerPed(ply)
            local position = GetEntityCoords(ped)
            local serverId = GetPlayerServerId(ply)
            local disableHeadTag = Player(serverId).state.disableHeadTag
            local staffHeadTag = Player(serverId).state.staffHeadTag
            local customHeadTag = Player(serverId).state.customHeadTag

            if not disableHeadTag then
                local dist = #(Client.position - position)

                if dist < 18 and HasEntityClearLosToEntity(Client.ped, ped, 17) then 
                    local boneCoords = GetPedBoneCoords(ped, 31086, 0, 0, 0)
                    local name = GetPlayerName(ply)
                    if staffHeadTag then
                        if NetworkIsPlayerTalking(ply) then
                            self:DrawHeadTagText(boneCoords, "~y~[~g~"..serverId.."~y~] "..(customHeadTag and "~w~["..customHeadTag.."~w~]" or "").." ~w~["..staffHeadTag.."~w~] ~w~"..name)
                        else
                            self:DrawHeadTagText(boneCoords, "~y~[~w~"..serverId.."~y~] "..(customHeadTag and "~w~["..customHeadTag.."~w~]" or "").." ~w~["..staffHeadTag.."~w~] ~w~"..name)
                        end
                    else
                        if NetworkIsPlayerTalking(ply) then
                            self:DrawHeadTagText(boneCoords, "~y~[~g~"..serverId.."~y~] "..(customHeadTag and "~w~["..customHeadTag.."~w~]" or "").." ~w~"..name)
                        else
                            self:DrawHeadTagText(boneCoords, "~y~[~w~"..serverId.."~y~] "..(customHeadTag and "~w~["..customHeadTag.."~w~]" or "").." ~w~"..name)
                        end
                    end
                end
            end
        end
    end
end