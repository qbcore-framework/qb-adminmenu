fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kakarot'
description 'Provides a menu for server and player management'
version '1.2.0'

ui_page 'html/index.html'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

client_scripts {
    '@menuv/menuv.lua',
    'client/noclip.lua',
    'client/entity_view.lua',
    'client/blipsnames.lua',
    'client/client.lua',
    'client/events.lua',
    'entityhashes/entity.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

files {
    'html/index.html',
    'html/index.js'
}

dependency 'menuv'
