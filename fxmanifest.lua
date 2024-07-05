
fx_version 'cerulean'
game 'gta5'

author 'iBoss21'
description 'TheLuxEmpire Roleplay World - Expanded Roleplay Experience'
version '2.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'shared/locales/en.lua',
    'shared/locales/ge.lua',
    'shared/locales/es.lua',
    'shared/config.lua',
    'shared/utils.lua',
    'shared/functions.lua',
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
    'client/cargo.lua',
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
    'server/cargo.lua',
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
