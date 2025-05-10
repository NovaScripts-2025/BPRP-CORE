PermissionsModule = setmetatable({}, PermissionsModule)

PermissionsModule.__call = function()
    return "PermissionsModule"
end

PermissionsModule.__index = PermissionsModule

function PermissionsModule.Load()
    return setmetatable({}, PermissionsModule)
end

function PermissionsModule:RegisterEvents()
    TriggerEvent("chat:addSuggestion", "/sync", "Sync your discord role permissions")

    RegisterNetEvent("RSRPCore:Client:Permissions:SetCustomChatTag")
    AddEventHandler("RSRPCore:Client:Permissions:SetCustomChatTag", function()
        local keyboard = exports["nh-keyboard"]:KeyboardInput({
            header = "Create your custom chat tag",
            rows = {
                {
                    id = 0,
                    txt = "Chat Tag Text"
                }
            }
        })
        if keyboard == nil then
            TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Chat Tag", "~r~You need to fill out all the fields")
            return
        end

        TriggerServerCallback {
            eventName = 'RSRPCore:Server:Permissions:ValidateCustomChatTag',
            args = {keyboard},
            callback = function(success, customTag)
                if success then
                    TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Chat Tag", "~g~You have created your custom chat tag")
                    SetResourceKvp('rsrpcore_customchattag', customTag)
                    TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomChatTag", customTag)
                end
            end
        }
            
    end)

    RegisterNetEvent("RSRPCore:Client:Permissions:SetCustomHeadTag")
    AddEventHandler("RSRPCore:Client:Permissions:SetCustomHeadTag", function()
        local keyboard = exports["nh-keyboard"]:KeyboardInput({
            header = "Create your custom head tag",
            rows = {
                {
                    id = 0,
                    txt = "Head Tag Text"
                }
            }
        })
        if keyboard == nil then
            TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Head Tag", "~r~You need to fill out all the fields")
            return
        end

        TriggerServerCallback {
            eventName = 'RSRPCore:Server:Permissions:ValidateCustomHeadTag',
            args = {keyboard},
            callback = function(success, customTag)
                if success then
                    TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Head Tag", "~g~You have created your custom head tag")
                    SetResourceKvp('rsrpcore_customheadtag', customTag)
                    TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomHeadTag", customTag)
                end
            end
        }

    end)

    RegisterNetEvent("RSRPCore:Client:Permissions:SetCustomWastedSlogan")
    AddEventHandler("RSRPCore:Client:Permissions:SetCustomWastedSlogan", function()
        local keyboard = exports["nh-keyboard"]:KeyboardInput({
            header = "Create your custom wasted slogan",
            rows = {
                {
                    id = 0,
                    txt = "Wasted Slogan"
                }
            }
        })

        if keyboard == nil then
            TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Wasted Slogan", "~r~You need to fill out all the fields")
            return
        end

        TriggerServerCallback {
            eventName = 'RSRPCore:Server:Permissions:ValidateCustomWastedSlogan',
            args = {keyboard},
            callback = function(success, wastedSlogan)
                if success then
                    TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Wasted Slogan", "~g~You have created your custom wasted slogan")
                    SetResourceKvp('rsrpcore_customwastedslogan', wastedSlogan)
                    TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomWastedSlogan", wastedSlogan)
                end
            end
        }
    end)

    RegisterNetEvent("RSRPCore:Client:Permissions:SetCustomWastedMessage")
    AddEventHandler("RSRPCore:Client:Permissions:SetCustomWastedMessage", function()
        local keyboard = exports["nh-keyboard"]:KeyboardInput({
            header = "Create your custom wasted message",
            rows = {
                {
                    id = 0,
                    txt = "Wasted Message"
                }
            }
        })

        if keyboard == nil then
            TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Wasted Message", "~r~You need to fill out all the fields")
            return
        end

        TriggerServerCallback {
            eventName = 'RSRPCore:Server:Permissions:ValidateCustomWastedMessage',
            args = {keyboard},
            callback = function(success, wastedMessage)
                if success then
                    TriggerEvent("RSRPCore:Client:SendRiversideNotification", "Wasted Message", "~g~You have created your custom wasted message")
                    SetResourceKvp('rsrpcore_customwastedmessage', wastedMessage)
                    TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomWastedMessage", wastedMessage)
                end
            end
        }
    end)

    AddEventHandler("onClientMapStart", function()
        local customChatTag = GetResourceKvpString('rsrpcore_customchattag')
        if customChatTag then
            TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomChatTag", customChatTag)
        end

        local customHeadTag = GetResourceKvpString('rsrpcore_customheadtag')
        if customHeadTag then
            TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomHeadTag", customHeadTag)
        end

        local customWastedSlogan = GetResourceKvpString('rsrpcore_customwastedslogan')
        if customWastedSlogan then
            TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomWastedSlogan", customWastedSlogan)
        end

        local customWastedMessage = GetResourceKvpString('rsrpcore_customwastedmessage')
        if customWastedMessage then
            TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomWastedMessage", customWastedMessage)
        end

        TriggerServerEvent("RSRPCore:Server:Permissions:SetTagsFirstJoin")
    end)

    RegisterNetEvent("DAP:Client:PermissionsSynced")
    AddEventHandler("DAP:Client:PermissionsSynced", function()
        local customChatTag = GetResourceKvpString('rsrpcore_customchattag')
        if customChatTag then
            TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomChatTag", customChatTag)
        end

        local customHeadTag = GetResourceKvpString('rsrpcore_customheadtag')
        if customHeadTag then
            TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomHeadTag", customHeadTag)
        end

        local customWastedSlogan = GetResourceKvpString('rsrpcore_customwastedslogan')
        if customWastedSlogan then
            TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomWastedSlogan", customWastedSlogan)
        end

        local customWastedMessage = GetResourceKvpString('rsrpcore_customwastedmessage')
        if customWastedMessage then
            TriggerServerEvent("RSRPCore:Server:Permissions:UpdateCustomWastedMessage", customWastedMessage)
        end

        TriggerServerEvent("RSRPCore:Server:Permissions:SetTagsFirstJoin")
    end)
end