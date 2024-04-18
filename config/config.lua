local Config = {
    Debug = false,
    Locations = {
        --[[
        ["Test"] = { -- ID of the zone, must be unique.
        name = "Test",-- Name of the menu.
        consola = {coords = vector3(0,0,0),size = vec3(3,3,3)} --First vector is the console coords, second is the size of the Zone.
        stereo =  vector3(0,0,0) -- if not false, is the position where the sound will play.
        distance = 10, -- Distance in meter.
        active = false,
        auth = "rt/" -- if false, anyone can play the song, if string, put the name of the job, if array put the citizenid authorized to play songs.
        -- auth = {
        ["ASDJERICO"] = true
        }
        },
        --]]
        --[[LasPlagas = {                                                                             -- ID of the zone, must be unique.
        label = "Las Plagas DJ ZONE",                                                         -- Name of the menu.
        consola = { coords = vector3(3798.66, 4456.86, 4.88), size = vec3(3, 3, 3) },         --First vector is the console coords, second is the size of the Zone.
        stereo = vector3(3798.66, 4456.86, 4.88),                                             -- if not false, is the position where the sound will play.
        distance = 30,                                                                        -- Distance in meter.
        active = false,
        auth = false                                                                          -- if false, anyone can play the song, if string, put the name of the job, if array put the citizenid authorized to play songs.
        },--]]

        Bennys = {                                                                                -- ID of the zone, must be unique.
            label = "Bennys DJ ZONE",                                                             -- Name of the menu.
            consola = { coords = vector3(-191.5033, -1325.9258, 34.9898), size = vec3(3, 3, 3) }, --First vector is the console coords, second is the size of the Zone.
            stereo = vector3(-206.8791, -1326.5219, 31.3005),                                     -- if not false, is the position where the sound will play.
            distance = 30,                                                                        -- Distance in meter.
            active = false,                                                                       -- Dont touch it
            auth =
            "bennys"                                                                              -- AUTH: if false, anyone can play the song, if string, put the name of the job, if array put the citizenid authorized to play songs.
        },
    },

}
return Config
