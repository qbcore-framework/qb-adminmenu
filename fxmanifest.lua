fx_version 'cerulean'
game 'gta5'

description 'QB-AdminMenu'
version '1.0.0'

client_scripts {
    '@menuv/menuv.lua',
    'client/noclip.lua',
    'client/functions.lua',
    'client/client.lua',
    'client/events.lua'
}

shared_script '@qb-core/import.lua'

server_script 'server/server.lua'

dependencies {
    'menuv'
}