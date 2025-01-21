--[[

 ██████╗  ███████╗ ███╗   ██╗ ██████╗ ███████╗ 
 ██╔══██╗ ██╔════╝ ████╗  ██║║██╔════╝██╔════╝ 
 ██████╔╝ █████╗   ██╔██╗ ██║║██║     █████╗   
 ██╔══██╗ ██╔══╝   ██║╚██╗██║║██║     ██╔══╝   
 ██████╔╝ ███████╗ ██║ ╚████║╚██████╗ ███████╗
 ╚═════╝  ╚══════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

]]

fx_version 'cerulean'
game 'gta5'

description 'Starter pack'
author 'Bence'

shared_script 'config.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_script 'client.lua'
