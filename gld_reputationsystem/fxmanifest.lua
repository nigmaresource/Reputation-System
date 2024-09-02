fx_version 'cerulean'
games { 'gta5' }
author 'https://discord.gg/goldscripts'
client_scripts {
    "config.lua",
    'client.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "server.lua"
}

shared_scripts {
    '@es_extended/imports.lua'
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/img/*.png',
}