local func = { client = {}, server = {} }

func.client.item = function(name)
	local item = bridge.framework.object.Shared.Items[name]

	return {
		label = item and item.label or name,
		description = item and item.description or nil,
		image = item and item.image and 'nui://qb-inventory/html/images/' .. item.image or nil,
	}
end

func.client.openStash = function(identifier)
	TriggerServerEvent('anx_bridge:qb-inventory:openStash', identifier)
end

if isServer then
	RegisterNetEvent('anx_bridge:qb-inventory:openStash', function(identifier)
		local src = source

		exports['qb-inventory']:OpenInventory(src, identifier)
	end)
end

func.client.hasItem = function(name, count)
	return exports['qb-inventory']:HasItem(name, count) or false
end

func.server.item = function(name)
	local item = bridge.framework.object.Shared.Items[name]

	return {
		label = item and item.label or name,
		description = item and item.description or nil,
	}
end

func.server.createStash = function(identifier, label, slots, weight)
	exports['qb-inventory']:CreateInventory(identifier, { label = label, slots = slots, maxweight = weight })
end

func.server.canCarryItem = function(src, name, count)
	return exports['qb-inventory']:CanAddItem(src, name, count) or false
end

func.server.getItems = function(src, name)
	local newItems = {}
	local items = exports['qb-inventory']:GetItemsByName(src, name) or {}

	for _, v in ipairs(items) do
		table.insert(newItems, {
			metadata = v.info,
			count = v.amount,
			slot = v.slot,
		})
	end

	return newItems
end

func.server.getItemCount = function(src, name, metadata, shouldMatch)
	if not metadata then
		return exports['qb-inventory']:GetItemCount(src, name) or 0
	else
		local shouldMatch = shouldMatch == nil and true or shouldMatch
		local items = bridge.inventory.server.getItems(src, name)
		local count = 0

		for _, v in ipairs(items) do
			if v.metadata and next(v.metadata) then
				count = shouldMatch and lib.table.matches(v.metadata, metadata) and (count + v.count) or count

				if not shouldMatch then
					for key, value in pairs(metadata) do
						if v.metadata[key] and v.metadata[key] == value then
							count = count + v.count
							break
						end
					end
				end
			end
		end

		return count
	end
end

func.server.getItemBySlot = function(src, slot)
	local item = exports['qb-inventory']:GetItemBySlot(src, slot)

	return item and {
		name = item.name,
		metadata = item.info,
		count = item.amount,
	} or nil
end

func.server.addItem = function(src, item, count, metadata)
	exports['qb-inventory']:AddItem(src, item, count, false, metadata)
end

func.server.removeItem = function(src, item, count, slot, metadata, shouldMatch)
	if not slot and not metadata then
		exports['qb-inventory']:RemoveItem(src, item, count)
	elseif slot and not metadata then
		exports['qb-inventory']:RemoveItem(src, item, count, slot)
	elseif not slot and metadata then
		local shouldMatch = shouldMatch == nil and true or shouldMatch
		local items = bridge.inventory.server.getItems(src, item)

		for _, v in ipairs(items) do
			if v.metadata and next(v.metadata) then
				if shouldMatch and lib.table.matches(v.metadata, metadata) then
					exports['qb-inventory']:RemoveItem(src, item, count, v.slot)
					return
				elseif not shouldMatch then
					for key, value in pairs(metadata) do
						if v.metadata[key] and v.metadata[key] == value then
							exports['qb-inventory']:RemoveItem(src, item, count, v.slot)
							return
						end
					end
				end
			end
		end
	end
end

func.server.setMetadata = function(src, slot, metadata)
	local exist = bridge.inventory.server.getItemBySlot(src, slot)

	if not exist then return end

	for k, v in pairs(metadata) do
		exports['qb-inventory']:SetItemData(src, exist.name, k, v, slot)
	end
end

return func
