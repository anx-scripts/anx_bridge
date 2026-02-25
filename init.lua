Resource = GetCurrentResourceName()
Version = GetResourceMetadata("anx_bridge", "version", 0)
IsBridge = Resource == "anx_bridge"
IsServer = IsDuplicityVersion()
---@type BridgeRoot
---@diagnostic disable-next-line: missing-fields
Bridge = { shared = require("shared.utils") }

local compability = {
	good = "^2good^7",
	average = "^3average^7",
	poor = "^1poor^7",
}

local modules = {
	{
		name = "framework",
		path = {
			{ name = "qb-core",     file = "qb-core",     compat = "good" },
			{ name = "qbx_core",    file = "qb-core",     compat = "good" },
			{ name = "es_extended", file = "es_extended", compat = "good" },
		},
	},
	{
		name = "inventory",
		path = {
			{ name = "qb-inventory", file = "qb-inventory", compat = "good" },
			{ name = "ox_inventory", file = "ox_inventory", compat = "good" },
		},
	},
	{
		name = "target",
		path = {
			{ name = "qb-target", file = "qb-target", compat = "good" },
			{ name = "ox_target", file = "ox_target", compat = "good" },
		},
	},
}

for _, module in ipairs(modules) do
	local convarResource = GetConvar("anx_bridge:" .. module.name, "auto")
	convarResource = convarResource ~= "auto" and not GetResourceState(convarResource) == "started" and "auto" or
			convarResource

	local file, resource, compatibility = "fallback", "fallback", "poor"

	for _, v in ipairs(module.path) do
		if (convarResource == "auto" and GetResourceState(v.name) == "started") or (convarResource == v.name) then
			resource = v.name
			file = v.file
			compatibility = v.compat
			break
		end
	end

	Bridge[module.name] = require(("%s.%s"):format(module.name, file))
	Bridge[module.name].name = resource
	Bridge[module.name].compatibility = compatibility

	if module.name == "inventory" and Bridge[module.name].name == "ox_inventory" and IsServer then
		Bridge.framework.server.createUseableItem = Bridge.inventory.server.createUseableItem
	end

	if IsServer then Bridge[module.name].client = nil else Bridge[module.name].server = nil end
end

if not IsBridge then return end

print(("^2[anx_bridge] ^7version: ^2%s^7 started successfully"):format(Version))

for _, module in ipairs(modules) do
	if Bridge[module.name].client and not IsServer or Bridge[module.name].server and IsServer then
		print(("^2[anx_bridge] ^7%s: %s ^7(Compatibility: %s)"):format(module.name,
			Bridge[module.name].name ~= "fallback" and "^2" .. Bridge[module.name].name or "^1fallback^7",
			compability[Bridge[module.name].compatibility]))
	end
end
