---@type InventoryModule
---@diagnostic disable-next-line: missing-fields
local inventory = { client = {}, server = {} }

local qb_inventory = exports["qb-inventory"]
local helper = require("inventory.helper")

---@return table<string, table>
local function sharedItems()
    ---@diagnostic disable-next-line
    local object = Bridge.framework.object

    return object and object.Shared.Items or {}
end

inventory.client.item = function(name)
    local item = sharedItems()[name]

    return {
        name = name,
        label = item and item.label or name,
        description = item and item.description or nil,
        image = item and item.image and "nui://qb-inventory/html/images/" .. item.image or nil,
    }
end

inventory.client.items = function()
    local newItems = {}
    local items = sharedItems()

    for item, v in pairs(items) do
        newItems[item] = {
            name = item,
            label = v.label or item,
            description = v.description or nil,
            image = v.image and "nui://qb-inventory/html/images/" .. v.image or nil,
        }
    end

    return newItems
end

inventory.client.hasItem = function(name, count)
    return qb_inventory:HasItem(name, count) or false
end

inventory.client.setBusy = function(state)
    LocalPlayer.state:set("inv_busy", state, true)
end

inventory.client.isBusy = function()
    return LocalPlayer.state.inv_busy == true
end

inventory.server.item = function(name)
    local item = sharedItems()[name]

    return {
        name = name,
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
    end

    shouldMatch = shouldMatch == nil and true or shouldMatch
    local items = Bridge.inventory.server.getItems(src, name)

    return helper.countByMetadata(items, metadata, shouldMatch)
end

inventory.server.getItemBySlot = function(src, slot)
    local item = qb_inventory:GetItemBySlot(src, slot)

    return item and {
        name = item.name,
        metadata = item.info,
        count = item.amount,
    } or nil
end

inventory.server.addItem = function(src, name, count, metadata)
    return qb_inventory:AddItem(src, name, count, false, metadata) or false
end

inventory.server.removeItem = function(src, name, count, slot, metadata, shouldMatch)
    if not slot and not metadata then
        return qb_inventory:RemoveItem(src, name, count) or false
    elseif slot and not metadata then
        return qb_inventory:RemoveItem(src, name, count, slot) or false
    elseif not slot and metadata then
        shouldMatch = shouldMatch == nil and true or shouldMatch

        local items = Bridge.inventory.server.getItems(src, name)
        local plan = helper.planRemoval(items, count, metadata, shouldMatch)

        if not plan then
            return false
        end

        for _, step in ipairs(plan) do
            qb_inventory:RemoveItem(src, name, step.count, step.slot)
        end

        return true
    end

    return false
end

inventory.server.setMetadata = function(src, slot, metadata)
    local exist = Bridge.inventory.server.getItemBySlot(src, slot)

    if not exist or not metadata then
        return
    end

    for k, v in pairs(metadata) do
        qb_inventory:SetItemData(src, exist.name, k, v, slot)
    end
end

return inventory
