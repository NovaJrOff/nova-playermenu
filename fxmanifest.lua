fx_version 'cerulean'
game 'gta5'
author 'Nova'
version '1.0.1'
lua54 'yes'
repository 'https://github.com/NovaJrOff/Fivem.git'

client_scripts {
    'client/*.lua'
}
server_scripts {
    'server/*.lua'
}
shared_scripts {
    '@ox_lib/init.lua',
    'locales/*.lua'

}
files {
    'config/*.lua'
}
