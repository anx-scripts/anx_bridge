local target = { client = {} }

local ox_target = exports["ox_target"]

target.client.addGlobalObject = function(options, distance)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, {
			name = v.name,
			label = v.label,
			icon = v.icon,
			distance = distance or 2.0,
			onSelect = function(data)
				v.onSelect(data.entity)
			end,
			canInteract = v.canInteract and function(entity, distance, coords, name, bone)
				return v.canInteract(entity)
			end or nil,
		})
	end

	ox_target:addGlobalObject(newOptions)
end

target.client.removeGlobalObject = function(options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	ox_target:removeGlobalObject(newOptions)
end

target.client.addGlobalPed = function(options, distance)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, {
			name = v.name,
			label = v.label,
			icon = v.icon,
			distance = distance or 2.0,
			onSelect = function(data)
				v.onSelect(data.entity)
			end,
			canInteract = v.canInteract and function(entity, distance, coords, name, bone)
				return v.canInteract(entity)
			end or nil,
		})
	end

	ox_target:addGlobalPed(newOptions)
end

target.client.removeGlobalPed = function(options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	ox_target:removeGlobalPed(newOptions)
end

target.client.addGlobalVehicle = function(options, distance)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, {
			name = v.name,
			label = v.label,
			icon = v.icon,
			distance = distance or 2.0,
			onSelect = function(data)
				v.onSelect(data.entity)
			end,
			canInteract = v.canInteract and function(entity, distance, coords, name, bone)
				return v.canInteract(entity)
			end or nil,
		})
	end

	ox_target:addGlobalVehicle(newOptions)
end

target.client.removeGlobalVehicle = function(options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	ox_target:removeGlobalVehicle(newOptions)
end

target.client.addModel = function(models, options, distance)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, {
			name = v.name,
			label = v.label,
			icon = v.icon,
			distance = distance or 2.0,
			onSelect = function(data)
				v.onSelect(data.entity)
			end,
			canInteract = v.canInteract and function(entity, distance, coords, name, bone)
				return v.canInteract(entity)
			end or nil,
		})
	end

	ox_target:addModel(models, newOptions)
end

target.client.removeModel = function(models, options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	ox_target:removeModel(models, newOptions)
end

target.client.addLocalEntity = function(entities, options, distance)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, {
			name = v.name,
			label = v.label,
			icon = v.icon,
			distance = distance or 2.0,
			onSelect = function(data)
				v.onSelect(data.entity)
			end,
			canInteract = v.canInteract and function(entity, distance, coords, name, bone)
				return v.canInteract(entity)
			end or nil,
		})
	end

	ox_target:addLocalEntity(entities, newOptions)
end

target.client.removeLocalEntity = function(entities, options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	ox_target:removeLocalEntity(entities, newOptions)
end

return target
