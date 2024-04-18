author "JericoFX#3512"
fx_version 'cerulean'
game "gta5"
description "DJ Console"

version "0.0.1"

client_script "client/init.lua"

shared_scripts { '@ox_lib/init.lua' }
server_scripts { "config/config.lua", "server/init.lua" }


lua54 'yes'

use_fxv2_oal 'on'

is_cfxv2 'yes'

dependencies {
    '/onesync',
    "ox_lib",
    "xsound"
}

escrow_ignore {
    "config/config.lua"
}
