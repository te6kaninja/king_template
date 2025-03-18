fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

name 'king_template'
author 'gadget2'
description 'A script template for FiveM'
version '0.0.1'

shared_scripts {
    '@ox_lib/init.lua',
    'code/core/shared.lua',
    'code/modules/**/shared.lua',
    'code/modules/**/sh_*.lua'
}

client_scripts {
    '@bl_bridge/imports/client.lua',
    'code/core/**/client.lua',
    'code/modules/**/client.lua',
    'code/modules/**/cl_*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@bl_bridge/imports/server.lua',
    'code/core/**/server.lua',
    'code/modules/**/server.lua',
    'code/modules/**/sv_*.lua'
}

files {
    'locales/*.json',
    'data/**'
}

dependencies { 'oxmysql', 'ox_lib', 'bl_bridge' }
ox_lib 'locale'