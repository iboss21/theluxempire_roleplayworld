fx_version 'cerulean'
game 'gta5'

author 'iBoss21'
description 'TheLuxEmpire Roleplay World - Advanced Resource Gathering and Crafting'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Add more locales as needed
    'shared/config.lua',
    'shared/utils.lua',
    '@theluxempire-core/shared/functions.lua',
    '@theluxempire-lib/shared/functions.lua',
    '@qb-target/shared/init.lua',
    '@tgiann-inventory/shared/config.lua'
}

client_scripts {
    'client/main.lua',
    'client/activities.lua',
    'client/crafting.lua',
    'client/market.lua',
    'client/skills.lua',
    'client/events.lua',
    'client/npc.lua',
    '@qb-target/client/init.lua',
    '@tgiann-inventory/client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/activities.lua',
    'server/crafting.lua',
    'server/market.lua',
    'server/skills.lua',
    'server/events.lua',
    'server/commands.lua',
    '@tgiann-inventory/server/main.lua'
}

dependencies {
    'qb-core',
    'oxmysql',
    'theluxempire-core',
    'theluxempire-lib',
    'qb-target',
    'tgiann-inventory'
}

lua54 'yes'
