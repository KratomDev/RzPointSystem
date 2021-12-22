
fx_version 'bodacious'
games {'gta5'}
name 'PointSystemForKoolKids'
author 'Kratom#9999'
version 'v0.0.1'


shared_script "config.lua"


client_script 'client/*.lua'
server_script 'server/*.lua'

client_script 'BaseEvents/deathevents.lua'
client_script 'BaseEvents/vehiclechecker.lua'
server_script 'BaseEvents/server.lua'