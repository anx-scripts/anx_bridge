local inventory = { client = {}, server = { useableItems = {} } }

local ox_inventory = exports["ox_inventory"]

inventory.client.item = function(name)
	local item = ox_inventory:Items(name)

	return {
		label = item and item.label or name,
		description = item and item.description or nil,
		image = item and item.client and item.client.image or nil,
	}
end

inventory.client.items = function()
	local newItems = {}
	local items = ox_inventory:Items()

	for item, v in pairs(items) do
		newItems[item] = {
			label = v.label or item,
			description = v.description or nil,
			image = v.client and v.client.image or nil,
		}
	end

	table.sort(newItems, function(a, b)
		return a.label < b.label
	end)

	return newItems
end

inventory.client.openStash = function(identifier)
	ox_inventory:openInventory("stash", identifier)
end

inventory.client.hasItem = function(name, count)
	return (ox_inventory:Search("count", name) or 0) >= count
end

inventory.client.setBusy = function(state)
	LocalPlayer.state:set("invBusy", state, true)
end

inventory.server.item = function(name)
	local item = ox_inventory:Items(name)

	return {
		label = item and item.label or name,
		description = item and item.description or nil,
	}
end

inventory.server.createStash = function(identifier, label, slots, weight)
	ox_inventory:RegisterStash(identifier, label, slots, weight)
end

inventory.server.canCarryItem = function(src, name, count)
	return ox_inventory:CanCarryItem(src, name, count) or false
end

inventory.server.getItems = function(src, name)
	local newItems = {}
	local items = ox_inventory:GetSlotsWithItem(src, name) or {}

	for _, v in ipairs(items) do
		table.insert(newItems, {
			metadata = v.metadata,
			count = v.count,
			slot = v.slot,
		})
	end

	return newItems
end

inventory.server.getItemCount = function(src, name, metadata, shouldMatch)
	if not metadata then
		return ox_inventory:Search(src, "count", name) or 0
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

inventory.server.getItemBySlot = function(src, slot)
	local item = ox_inventory:GetSlot(src, slot)

	return item and {
		name = item.name,
		metadata = item.metadata,
		count = item.count,
	} or nil
end

inventory.server.addItem = function(src, item, count, metadata)
	ox_inventory:AddItem(src, item, count, metadata)
end

inventory.server.removeItem = function(src, item, count, slot, metadata, shouldMatch)
	if not slot and not metadata then
		ox_inventory:RemoveItem(src, item, count)
	elseif slot and not metadata then
		ox_inventory:RemoveItem(src, item, count, nil, slot)
	elseif not slot and metadata then
		local shouldMatch = shouldMatch == nil and true or shouldMatch

		if shouldMatch then
			ox_inventory:RemoveItem(src, item, count, metadata)
		else
			local items = bridge.inventory.server.getItems(src, item)

			for _, v in ipairs(items) do
				if v.metadata and next(v.metadata) then
					for key, value in pairs(metadata) do
						if v.metadata[key] and v.metadata[key] == value then
							ox_inventory:RemoveItem(src, item, count, nil, v.slot)
							return
						end
					end
				end
			end
		end
	end
end

inventory.server.setMetadata = function(src, slot, metadata)
	local exist = bridge.inventory.server.getItemBySlot(src, slot)

	if not exist then return end

	ox_inventory:SetMetadata(src, slot, metadata)
end

inventory.server.createUseableItem = function(name, cb)
	inventory.server.useableItems[name] = cb
end

if isServer then
	AddEventHandler("ox_inventory:usedItem", function(src, itemName, slot, metadata)
		local callback = inventory.server.useableItems[itemName]

		if callback then
			callback(src, slot, metadata)
		end
	end)
end

return inventory
