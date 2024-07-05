fx_version 'cerulean'
game 'gta5'

author 'iBoss21'
description 'TheLuxEmpire Core'
version '1.0.0'

shared_scripts {
    'shared/main.lua',
    'shared/functions.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

dependencies {
    'qb-core',
    'oxmysql'
}

lua54 'yes'
