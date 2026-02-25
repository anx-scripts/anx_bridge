local target = { client = {} }

local qb_target = exports["qb-target"]

target.client.addGlobalObject = function(options, distance)
	local newOptions = { distance = distance or 2.0, options = {} }

	for _, v in ipairs(options) do
		table.insert(newOptions.options, {
			label = v.label,
			icon = v.icon,
			action = function(entity)
				v.onSelect(entity)
			end,
			canInteract = v.canInteract and function(entity)
				return v.canInteract(entity)
			end or nil,
		})
	end

	qb_target:AddGlobalObject(newOptions)
end

target.client.removeGlobalObject = function(options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.label)
	end

	qb_target:RemoveGlobalObject(newOptions)
end

target.client.addGlobalPed = function(options, distance)
	local newOptions = { distance = distance or 2.0, options = {} }

	for _, v in ipairs(options) do
		table.insert(newOptions.options, {
			label = v.label,
			icon = v.icon,
			action = function(entity)
				v.onSelect(entity)
			end,
			canInteract = v.canInteract and function(entity)
				return v.canInteract(entity)
			end or nil,
		})
	end

	qb_target:AddGlobalPed(newOptions)
end

target.client.removeGlobalPed = function(options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.label)
	end

	qb_target:RemoveGlobalPed(newOptions)
end

target.client.addGlobalVehicle = function(options, distance)
	local newOptions = { distance = distance or 2.0, options = {} }

	for _, v in ipairs(options) do
		table.insert(newOptions.options, {
			label = v.label,
			icon = v.icon,
			action = function(entity)
				v.onSelect(entity)
			end,
			canInteract = v.canInteract and function(entity)
				return v.canInteract(entity)
			end or nil,
		})
	end

	qb_target:AddGlobalVehicle(newOptions)
end

target.client.removeGlobalVehicle = function(options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.label)
	end

	qb_target:RemoveGlobalVehicle(newOptions)
end

target.client.addModel = function(models, options, distance)
	local newOptions = { distance = distance or 2.0, options = {} }

	for _, v in ipairs(options) do
		table.insert(newOptions.options, {
			label = v.label,
			icon = v.icon,
			action = function(entity)
				v.onSelect(entity)
			end,
			canInteract = v.canInteract and function(entity)
				return v.canInteract(entity)
			end or nil,
		})
	end

	qb_target:AddTargetModel(models, newOptions)
end

target.client.removeModel = function(models, options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.label)
	end

	qb_target:RemoveTargetModel(models, newOptions)
end

target.client.addLocalEntity = function(entities, options, distance)
	local newOptions = { distance = distance or 2.0, options = {} }

	for _, v in ipairs(options) do
		table.insert(newOptions.options, {
			label = v.label,
			icon = v.icon,
			action = function(entity)
				v.onSelect(entity)
			end,
			canInteract = v.canInteract and function(entity)
				return v.canInteract(entity)
			end or nil,
		})
	end

	qb_target:AddTargetEntity(entities, newOptions)
end

target.client.removeLocalEntity = function(entities, options)
	local newOptions = {}

	for _, v in ipairs(options) do
		table.insert(newOptions, v.label)
	end

	qb_target:RemoveTargetEntity(entities, newOptions)
end

return target
