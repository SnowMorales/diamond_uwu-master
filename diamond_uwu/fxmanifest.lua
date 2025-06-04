fx_version 'bodacious'
game 'gta5'

author 'Snow Morales'
decription 'Script created or modified by Diamond District for the Diamond District server'
version '1.0.0'

dependencies {
    'PolyZone',
    'esx_society',
    'ox_target'
}

client_script {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client.lua'

}

server_script {
	'server.lua'
}

shared_script 'shared.lua'