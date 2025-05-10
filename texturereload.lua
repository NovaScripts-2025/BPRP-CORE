TextureReloadModule = setmetatable({}, TextureReloadModule)

TextureReloadModule.__call = function()
    return "TextureReloadModule"
end

TextureReloadModule.__index = TextureReloadModule

function TextureReloadModule.Load()
    return setmetatable({}, TextureReloadModule)
end

function TextureReloadModule:RegisterCommands()
    RegisterCommand("textures", function()
        TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Texture Reload", "~y~Texture reload commencing")
        DoScreenFadeOut(1000)
        Wait(2000)
        RequestCollisionAtCoord(Client.position.x, Client.position.y, Client.position.z)
        RequestAdditionalCollisionAtCoord(Client.position.x, Client.position.y, Client.position.z)

        local startTime = GetGameTimer()
        while not HasCollisionLoadedAroundEntity(Client.ped) do 
            if (GetGameTimer() - startTime) > 2000 then
                break
            end

            Wait(500)
        end

        DoScreenFadeIn(1000)
        Wait(1000)
        TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Texture Reload", "~g~Texture reload finished")
    end, false)

    TriggerEvent("chat:addSuggestion", "/textures", "Reload the map around your ped (May help with texture loss)")
end
