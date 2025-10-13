resource = GetCurrentResourceName()
version = GetResourceMetadata('anx_bridge', 'version')
isBridge = resource == 'anx_bridge'
isServer = IsDuplicityVersion()
bridge = { shared = require('shared.utils') }

local modules = {
    {
        name = 'framework',
        path = {
            { name = 'qb-core',     file = 'qb-core.lua',     compat = 'good' },
            { name = 'qbx_core',    file = 'qb-core.lua',     compat = 'good' },
            { name = 'es_extended', file = 'es_extended.lua', compat = 'good' },
        },
    },
    {
        name = 'inventory',
        path = {
            { name = 'qb-inventory', file = 'qb-inventory.lua', compat = 'good' },
            { name = 'ox_inventory', file = 'ox_inventory.lua', compat = 'good' },
        },
    },
    {
        name = 'target',
        path = {
            { name = 'qb-target', file = 'qb-target.lua', compat = 'good' },
            { name = 'ox_target', file = 'ox_target.lua', compat = 'good' },
        },
    },
}

for _, module in ipairs(modules) do
    local convar = GetConvar('anx_bridge:' .. module.name, 'auto')
    local file, res, compat

    if convar ~= 'auto' and not bridge.shared.isResourceStarted(convar) then
        convar = 'auto'
    end

    for _, v in ipairs(module.path) do
        if (convar == 'auto' and bridge.shared.isResourceStarted(v.name)) or (convar == v.name) then
            res = v.name
            file = v.file
            compat = v.compat
            break
        end
    end

    res = res or 'fallback'
    file = file or 'fallback.lua'
    compat = compat or 'poor'

    local path = ('%s/%s'):format(module.name, file)

    bridge[module.name] = bridge.shared.loadFile('anx_bridge', path)
    bridge[module.name].name = res
    bridge[module.name].compat = compat

    if module.name == 'inventory' and bridge[module.name].name == 'ox_inventory' and isServer then
        bridge.framework.server.createUseableItem = bridge.inventory.server.createUseableItem
    end

    if isServer then bridge[module.name].client = nil else bridge[module.name].server = nil end
end

if not isBridge then return end

print(('^2[anx_bridge] ^7version: ^2%s^7 started successfully'):format(version))

for _, module in ipairs(modules) do
    local moduleName = module.name
    local resName = bridge[moduleName].name
    local compat = bridge[moduleName].compat

    if compat == 'good' then compat = '^2good^7' elseif compat == 'average' then compat = '^3average^7' elseif compat == 'poor' then compat =
        '^1poor^7' end

    if bridge[moduleName].client and not isServer or bridge[moduleName].server and isServer then
        print(('^2[anx_bridge] ^7%s: %s ^7(Compatibility: %s)'):format(moduleName,
            resName ~= 'fallback' and '^2' .. resName or '^1fallback^7', compat))
    end
end
