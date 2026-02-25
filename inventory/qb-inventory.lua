local inventory = { client = {}, server = {} }

local qb_inventory = exports["qb-inventory"]

inventory.client.item = function(name)
	local item = bridge.framework.object.Shared.Items[name]

	return {
		label = item and item.label or name,
		description = item and item.description or nil,
		image = item and item.image and "nui://qb-inventory/html/images/" .. item.image or nil,
	}
end

inventory.client.items = function()
	local newItems = {}
	local items = bridge.framework.object.Shared.Items

	for item, v in pairs(items) do
		newItems[item] = {
			label = v.label or item,
			description = v.description or nil,
			image = v.image and "nui://qb-inventory/html/images/" .. v.image or nil,
		}
	end

	table.sort(newItems, function(a, b)
		return a.label < b.label
	end)

	return newItems
end

inventory.client.openStash = function(identifier)
	TriggerServerEvent("anx_bridge:qb-inventory:openStash", identifier)
end

if isServer then
	RegisterNetEvent("anx_bridge:qb-inventory:openStash", function(identifier)
		local src = source

		qb_inventory:OpenInventory(src, identifier)
	end)
end

inventory.client.hasItem = function(name, count)
	return qb_inventory:HasItem(name, count) or false
end

inventory.client.setBusy = function(state)
	LocalPlayer.state:set("inv_busy", state, true)
end

inventory.server.item = function(name)
	local item = bridge.framework.object.Shared.Items[name]

	return {
		label = item and item.label or name,
		description = item and item.description or nil,
	}
end

inventory.server.createStash = function(identifier, label, slots, weight)
	qb_inventory:CreateInventory(identifier, { label = label, slots = slots, maxweight = weight })
end

inventory.server.canCarryItem = function(src, name, count)
	return qb_inventory:CanAddItem(src, name, count) or false
end

inventory.server.getItems = function(src, name)
	local newItems = {}
	local items = qb_inventory:GetItemsByName(src, name) or {}

	for _, v in ipairs(items) do
		table.insert(newItems, {
			metadata = v.info,
			count = v.amount,
			slot = v.slot,
		})
	end

	return newItems
end

inventory.server.getItemCount = function(src, name, metadata, shouldMatch)
	if not metadata then
		return qb_inventory:GetItemCount(src, name) or 0
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
	local item = qb_inventory:GetItemBySlot(src, slot)

	return item and {
		name = item.name,
		metadata = item.info,
		count = item.amount,
	} or nil
end

inventory.server.addItem = function(src, item, count, metadata)
	qb_inventory:AddItem(src, item, count, false, metadata)
end

inventory.server.removeItem = function(src, item, count, slot, metadata, shouldMatch)
	if not slot and not metadata then
		qb_inventory:RemoveItem(src, item, count)
	elseif slot and not metadata then
		qb_inventory:RemoveItem(src, item, count, slot)
	elseif not slot and metadata then
		local shouldMatch = shouldMatch == nil and true or shouldMatch
		local items = bridge.inventory.server.getItems(src, item)

		for _, v in ipairs(items) do
			if v.metadata and next(v.metadata) then
				if shouldMatch and lib.table.matches(v.metadata, metadata) then
					qb_inventory:RemoveItem(src, item, count, v.slot)
					return
				elseif not shouldMatch then
					for key, value in pairs(metadata) do
						if v.metadata[key] and v.metadata[key] == value then
							qb_inventory:RemoveItem(src, item, count, v.slot)
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

	for k, v in pairs(metadata) do
		qb_inventory:SetItemData(src, exist.name, k, v, slot)
	end
end

return inventory
