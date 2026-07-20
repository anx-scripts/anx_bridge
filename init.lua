---@type BridgeRoot
---@diagnostic disable-next-line: missing-fields
Bridge = {
    resource = GetCurrentResourceName(),
    isServer = IsDuplicityVersion(),
    shared = require("shared.utils"),
}

Bridge.version = GetResourceMetadata(Bridge.resource, "version", 0)
Bridge.isBridge = Bridge.resource == "anx_bridge"

local modules = {
    {
        name = "framework",
        path = {
            { name = "qb-core", file = "qb-core" },
            { name = "qbx_core", file = "qb-core" },
            { name = "es_extended", file = "es_extended" },
        },
    },
    {
        name = "inventory",
        path = {
            { name = "qb-inventory", file = "qb-inventory" },
            { name = "ox_inventory", file = "ox_inventory" },
        },
    },
    {
        name = "target",
        path = {
            { name = "qb-target", file = "qb-target" },
            { name = "ox_target", file = "ox_target" },
        },
    },
}

for _, module in ipairs(modules) do
    local convarResource = GetConvar("anx_bridge:" .. module.name, "auto")

    if convarResource ~= "auto" and GetResourceState(convarResource) ~= "started" then
        convarResource = "auto"
    end

    local file, resource = "fallback", "fallback"

    for _, v in ipairs(module.path) do
        if
            (convarResource == "auto" and GetResourceState(v.name) == "started")
            or (convarResource == v.name)
        then
            resource = v.name
            file = v.file
            break
        end
    end

    Bridge[module.name] = require(("%s.%s"):format(module.name, file))
    Bridge[module.name].name = resource

    if
        module.name == "inventory"
        and Bridge[module.name].name == "ox_inventory"
        and Bridge.isServer
    then
        Bridge.framework.server.createUseableItem = Bridge.inventory.server.createUseableItem
    end

    if Bridge.isServer then
        Bridge[module.name].client = nil
    else
        Bridge[module.name].server = nil
    end
end

if not Bridge.isBridge then
    return
end

print(("^2[anx_bridge] ^7version: ^2%s^7 started successfully"):format(Bridge.version))

for _, module in ipairs(modules) do
    if
        Bridge[module.name].client and not Bridge.isServer
        or Bridge[module.name].server and Bridge.isServer
    then
        print(
            ("^2[anx_bridge] ^7%s: %s"):format(
                module.name,
                Bridge[module.name].name ~= "fallback" and "^2" .. Bridge[module.name].name .. "^7"
                    or "^1fallback^7"
            )
        )
    end
end
