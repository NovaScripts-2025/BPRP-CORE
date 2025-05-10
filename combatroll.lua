CombatRollModule = setmetatable({}, CombatRollModule)

CombatRollModule.__call = function()
    return "CombatRollModule"
end

CombatRollModule.__index = CombatRollModule

function CombatRollModule.Load()
    return setmetatable({}, CombatRollModule)
end

function CombatRollModule:Run()
    if Config.Modules.CombatRoll.Settings.Disable then
        if IsControlPressed(0, 25) then 
            DisableControlAction(0, 22, true)
        end
    end
end