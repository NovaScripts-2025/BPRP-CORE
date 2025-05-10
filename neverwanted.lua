NeverWantedModule = setmetatable({}, NeverWantedModule)

NeverWantedModule.__call = function()
    return "NeverWantedModule"
end

NeverWantedModule.__index = NeverWantedModule

function NeverWantedModule.Load()
    return setmetatable({}, NeverWantedModule)
end

function NeverWantedModule:Run()
    if GetPlayerWantedLevel(Client.handle) ~= 0 then
        SetPlayerWantedLevel(Client.handle, 0, false)
        SetPlayerWantedLevelNow(Client.handle, false)
        SetPlayerWantedLevelNoDrop(Client.handle, 0, false)
    end
end