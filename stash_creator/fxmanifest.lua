fx_version 'cerulean'
game 'gta5'

description 'stash creator by noxilis_'

client_script 'client.lua'
server_script 'server.lua'

shared_script 'config.lua'

dependencies {
    'ox_target',
    'ox_inventory',
    'es_extended', -- ou 'qb-core', en fonction de ce que tu utilises
}
