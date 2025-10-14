fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
games { 'gta5' }

name 'anx_bridge'
author 'anx-scripts'
version '1.0.0'
description 'A bridge designed to simplify the creation, configuration, and installation of the script.'

files {
	'**.lua',
	'**.json',
}

shared_scripts {
	'@ox_lib/init.lua',
	'init.lua',
}

ox_libs {
	'table',
	'callback',
}
