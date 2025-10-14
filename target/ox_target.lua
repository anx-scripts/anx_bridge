local func = { client = {} }

func.client.addGlobalObject = function(options, distance)
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

	exports['ox_target']:addGlobalObject(newOptions)
end

func.client.removeGlobalObject = function(options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	exports['ox_target']:removeGlobalObject(newOptions)
end

func.client.addGlobalPed = function(options, distance)
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

	exports['ox_target']:addGlobalPed(newOptions)
end

func.client.removeGlobalPed = function(options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	exports['ox_target']:removeGlobalPed(newOptions)
end

func.client.addGlobalVehicle = function(options, distance)
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

	exports['ox_target']:addGlobalVehicle(newOptions)
end

func.client.removeGlobalVehicle = function(options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	exports['ox_target']:removeGlobalVehicle(newOptions)
end

func.client.addModel = function(models, options, distance)
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

	exports['ox_target']:addModel(models, newOptions)
end

func.client.removeModel = function(models, options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	exports['ox_target']:removeModel(models, newOptions)
end

func.client.addLocalEntity = function(entities, options, distance)
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

	exports['ox_target']:addLocalEntity(entities, newOptions)
end

func.client.removeLocalEntity = function(entities, options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.name)
	end

	exports['ox_target']:removeLocalEntity(entities, newOptions)
end

return func
