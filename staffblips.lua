StaffBlipsModule = setmetatable({}, StaffBlipsModule)

StaffBlipsModule.__call = function()
    return "StaffBlipsModule"
end

StaffBlipsModule.__index = StaffBlipsModule

function StaffBlipsModule.Load()
    return setmetatable({
        isStaff = false,
        blipTracker = {}
    }, StaffBlipsModule)
end

function StaffBlipsModule:RegisterEvents()
    isStaff = Player(Client.serverId).state.onDutyDepartment and Player(Client.serverId).state.onDutyDepartment == "Staff" or false

    AddStateBagChangeHandler("job", nil, function(bagName, key, job) 
        local player = GetPlayerFromStateBagName(bagName)

        if player == Client.handle then
            isStaff = job and job.name == "Staff" or false
        end
    end)
end

function StaffBlipsModule:Run()
    if isStaff then 
        for _, player in ipairs(GetActivePlayers()) do
            local job = Player(GetPlayerServerId(player)).state.onDutyDepartment
            if player ~= Client.handle then
                local ped = GetPlayerPed(player)
                local currentBlip = GetBlipFromEntity(ped)
                if job and job == "Staff" and currentBlip == 0 then
                    local blip = AddBlipForEntity(ped)

                    SetBlipSprite(blip, 280)
                    SetBlipColour(blip, 6)
                    SetBlipDisplay(blip, 2)
                    SetBlipSecondaryColour(blip, 71, 111, 191)
                    ShowHeightOnBlip(blip, true)
                    SetBlipScale(blip, 1.1)
                    SetBlipShowCone(blip, true)
                    SetBlipNameToPlayerName(blip, player)

                    table.insert(self.blipTracker, blip)
                elseif not job or (job ~= "Staff" and currentBlip ~= 0) then
                    RemoveBlip(currentBlip)
                end
            end
        end
    else
        if #self.blipTracker > 0 then
            for _, blip in ipairs(self.blipTracker) do
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                end
            end

            self.blipTracker = {}
        end
    end
end