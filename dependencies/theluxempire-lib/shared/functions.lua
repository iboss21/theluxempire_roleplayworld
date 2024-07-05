function TLELib.GetObject()
    return TLELib
end

TLELib.GetRandomPositionInCircle = function(center, radius)
    local angle = math.random() * math.pi * 2
    local r = math.sqrt(math.random()) * radius
    local x = center.x + r * math.cos(angle)
    local y = center.y + r * math.sin(angle)
    return vector3(x, y, center.z)
end

TLELib.GetTableKeys = function(tbl)
    local keys = {}
    for k in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

if not IsDuplicityVersion() then -- Client side
    TLELib.Notify = function(message, notifyType)
        QBCore.Functions.Notify(message, notifyType)
    end

    TLELib.ProgressBar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
        QBCore.Functions.Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    end

    TLELib.PlayAnimation = function(animDict, animName, duration)
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end
        TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, duration, 0, 0, false, false, false)
        RemoveAnimDict(animDict)
    end

    TLELib.StopAnimation = function()
        ClearPedTasks(PlayerPedId())
    end

    TLELib.DrawMarker = function(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, red, green, blue, alpha, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureName, drawOnEnts)
        DrawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, red, green, blue, alpha, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureName, drawOnEnts)
    end

    TLELib.DrawText2D = function(x, y, text, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(scale, scale)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end
end
