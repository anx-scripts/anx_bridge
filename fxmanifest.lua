fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'

name 'anx_bridge'
author 'anx-scripts'
version '1.0.0'
description 'Framework, inventory and target bridge for anx-scripts resources.'

dependency 'ox_lib'

files {
	'shared/**.lua',
	'framework/**.lua',
	'inventory/**.lua',
	'target/**.lua',
}

shared_scripts {
	'@ox_lib/init.lua',
	'init.lua',
}

ox_libs {
	'table',
}
