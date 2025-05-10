fx_version 'cerulean'

game 'gta5'

name 'RSRPCore'
description 'Core of Riverside Roleplay'
author 'Lxk3y'
version '0.1.0'

lua54 'yes'

server_scripts {
    'server/modules/*.lua',
    'server/main.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    'client/modules/*.lua',
    'client/main.lua'
}

shared_scripts {
    '@pmc-callbacks/import.lua',
    'config.lua'
}

