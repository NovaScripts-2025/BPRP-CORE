
PresenceModule = setmetatable({}, PresenceModule)

PresenceModule.__call = function()
    return "PresenceModule"
end

PresenceModule.__index = PresenceModule

function PresenceModule.Load()
    return setmetatable({
        appId = "1020023103549616198"
    }, PresenceModule)
end

function PresenceModule:RegisterEvents()
    RegisterNetEvent('RSRPCore:Presence:Client:UpdateData')
    AddEventHandler('RSRPCore:Presence:Client:UpdateData', function(players, slots)
        SetRichPresence("["..players.."/"..slots.."]  (ID: "..Client.serverId..") "..Client.name)
    end)
end

function PresenceModule:Setup()
    SetDiscordAppId(self.appId)

    SetDiscordRichPresenceAction(0, 'Riverside Roleplay Discord!', 'https://discord.gg/rsrp')
    SetDiscordRichPresenceAction(1, 'Play Riverside Roleplay!', 'fivem://connect/cfx.re/join/x6y3jm')

    SetDiscordRichPresenceAsset('rsrpmain')
    SetDiscordRichPresenceAssetText('Riverside Roleplay Dev')

    TriggerServerEvent('RSRPCore:Presence:Server:LoadPresenceData')
end