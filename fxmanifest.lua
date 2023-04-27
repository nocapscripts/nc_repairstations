fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'KnownScripts'
description 'Car repair spots'
version '1.0.0'

client_scripts {
    'client.lua',

}
server_script 'server.lua'

shared_script '@Framework/imports.lua'

shared_scripts {
    'config.lua',
}


dependencies {
    '/server:6400',                
    '/onesync',                    
}