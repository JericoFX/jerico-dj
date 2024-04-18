local player = {}
local QBCore = exports["qb-core"]:GetCoreObject()
local Sound = require "server.data.sound"
local Config = require "config.config"

lib.callback.register("fx::server::djsound::play", function(source, name, url, volume, loop)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player or not Config.Locations[name] then return end
    local coords = Config.Locations[name].consola.stereo ~= nil and Config.Locations[name].consola.stereo or
        Config.Locations[name].consola.coords
    local sounds = Sound.new({
        source = -1,
        name = name,
        url = url,
        volume = volume,
        position = coords,
        loop = false
    })

    if player[name] then
        player[name]:Destroy()
        player[name] = nil
    end
    player[name] = sounds
    sounds:Play()
end)

lib.callback.register("fx::server::djsound::pause", function(source, name, status)
    local players = player[name]
    if not players then return end
    local s = players:getStatus()
    if status == "play" and s == "pause" then
        players:Resume()
    elseif status == "pause" and s == "play" then
        players:Pause()
    else
        return
    end
end)

lib.callback.register("fx::server::djsound::destroy", function(source, name)
    local players = player[name]
    if not players then return end
    players:Destroy()
    player[name] = nil
end)

lib.callback.register("fx::server::djsound::setVolumen", function(source, name, volumen)
    local players = player[name]
    if not players then return end
    players:Volumen(volumen)
end)

lib.callback.register("fx::server::djsound::getConfigOptions", function(source)
    return Config
end)

lib.callback.register("fx::server:djsound::setState", function(source, name, state)
    if not Config.Locations[name] then return false end
    Config.Locations[name].active = state
    return true
end)

lib.callback.register("fx::server:djsound::getState", function(source, name, state)
    return Config.Locations[name].active
end)

AddEventHandler("onResourceStop", function(res)
    if res == GetCurrentResourceName() then
        local P = #player
        for i = 1, P do
            local el = player[i]
            if el and el:getStatus() == "play" or el:getStatus() == "resume" then
                el:Destroy()
            end
        end
    end
end)
