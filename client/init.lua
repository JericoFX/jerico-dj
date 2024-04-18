local QBCore = exports["qb-core"]:GetCoreObject()
local Zone = {}
local Config = {}
local PlayerData = {}
local interior = false
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:SetPlayerData', function(data)
    PlayerData = data
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

local Data = {
    function(name)
        -- Play
        local input = lib.inputDialog('URL', {
            { type = 'input',  label = 'Youtube Label' },
            { type = 'slider', label = 'Volume',       default = 1.0, description = 'Add the volume', icon = 'hashtag', min = 0.1, max = 1.0, step = 0.1 },
        })
        if not input or not input[1] or not input[2] then return end
        lib.callback.await("fx::server::djsound::play", false, name, input[1], input[2], false)
        TriggerServerEvent("qb-log:server:CreateLog", "musica", "Added a Music", "blue",
            ("ID: %s, Nombre: %s \n coloco :%s "):format(PlayerData.citizenid, PlayerData.charinfo.firstname, input[1]),
            false)
    end,
    function(name)
        --Volume
        local input = lib.inputDialog('Volume', {
            { type = 'slider', label = 'Volume', default = 1.0, description = 'Put the volume', icon = 'hashtag', min = 0.1, max = 1.0, step = 0.1 },
        })
        if not input or not input[1] then return end
        lib.callback.await("fx::server::djsound::setVolumen", false, name, input[1])
    end,
    function(name)
        --Pause
        lib.callback.await("fx::server::djsound::pause", false, name, "pause")
    end,
    function(name)
        --Resume
        lib.callback.await("fx::server::djsound::pause", false, name, "play")
    end,
    function(name)
        --Stop
        lib.callback.await("fx::server::djsound::destroy", false, name)
    end,
}


local function RegisterMenu(menu, name)
    lib.registerMenu({
        id = menu,
        title = ("%s DJ Console"):format(name),
        position = 'top-right',
        options = {
            { label = 'Play',   args = {} },
            { label = 'Volume', args = {} },
            { label = 'Pause',  args = {} },
            { label = 'Resume', args = {} },
            { label = 'Stop',   args = {} },
        }
    }, function(selected, scrollIndex, args)
        Data[selected](menu)
    end)
end

local function onEnter(self)
    local auth = self.data.auth
    local name = self.data.name
    if auth and type(auth) == "string" then
        local isInJob = PlayerData.job.name == self.data.auth
        if isInJob then
            interior = true
            lib.showTextUI('[E] - Open Console')
        end
    elseif auth and type(auth) == "table" then
        if Config.Locations[name].auth[PlayerData.citizenid] then
            interior = true
            lib.showTextUI('[E] - Open Console')
        end
    else
        interior = true
        lib.showTextUI('[E] - Open Console')
    end
end

local function onExit(self)
    interior = false
    lib.hideTextUI()
end

local function onInside(self)
    local currentDistance = #(cache.coords - self.coords)
    DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 200, 20, 20,
        50, false, true, 2, false, nil, nil, false)
    if currentDistance < 1 and IsControlJustReleased(0, 38) and interior then
        lib.showMenu(self.name)
    end
end

CreateThread(function()
    Wait(200)
    Config = lib.callback.await("fx::server::djsound::getConfigOptions", false)
    if Config then
        for k, v in pairs(Config.Locations) do
            local el = Config.Locations[k]
            Zone[#Zone + 1] = lib.zones.box({
                name = k,
                coords = el.consola.coords,
                size = el.consola.size,
                debug = false,
                onEnter = onEnter,
                onExit = onExit,
                inside = onInside,
                data = { name = k, label = el.label, distance = el.distance, auth = el.auth }
            })
            RegisterMenu(k, el.label)
        end
    end
end)
