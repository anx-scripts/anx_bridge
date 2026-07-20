---@type InventoryModule
---@diagnostic disable-next-line: missing-fields
local inventory = { client = {}, server = {} }

local ox_inventory = exports["ox_inventory"]
local helper = require("inventory.helper")

---@type table<string, fun(src: number, slot: number, metadata?: table<string, any>)>
local useableItems = {}

inventory.client.item = function(name)
    local item = ox_inventory:Items(name)

    return {
        name = name,
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
            name = item,
            label = v.label or item,
            description = v.description or nil,
            image = v.client and v.client.image or nil,
        }
    end

    return newItems
end

inventory.client.hasItem = function(name, count)
    return (ox_inventory:Search("count", name) or 0) >= count
end

inventory.client.setBusy = function(state)
    LocalPlayer.state:set("invBusy", state, true)
end

inventory.client.isBusy = function()
    return LocalPlayer.state.invBusy == true
end

inventory.server.item = function(name)
    local item = ox_inventory:Items(name)

    return {
        name = name,
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
        return ox_inventory:Search(src, "count", name) --[[@as number]] or 0
    end

    shouldMatch = shouldMatch == nil and true or shouldMatch
    local items = Bridge.inventory.server.getItems(src, name)

    return helper.countByMetadata(items, metadata, shouldMatch)
end

inventory.server.getItemBySlot = function(src, slot)
    local item = ox_inventory:GetSlot(src, slot)

    return item
            and {
                name = item.name,
                metadata = item.metadata,
                count = item.count,
            }
        or nil
end

inventory.server.addItem = function(src, name, count, metadata)
    local success = ox_inventory:AddItem(src, name, count, metadata)

    return success or false
end

inventory.server.removeItem = function(src, name, count, slot, metadata, shouldMatch)
    if not slot and not metadata then
        return ox_inventory:RemoveItem(src, name, count) or false
    elseif slot and not metadata then
        return ox_inventory:RemoveItem(src, name, count, nil, slot) or false
    elseif not slot and metadata then
        shouldMatch = shouldMatch == nil and true or shouldMatch

        ---@diagnostic disable-next-line: redundant-parameter
        return ox_inventory:RemoveItem(src, name, count, metadata, nil, false, shouldMatch) or false
    end

    return false
end

inventory.server.setMetadata = function(src, slot, metadata)
    local exist = Bridge.inventory.server.getItemBySlot(src, slot)

    if not exist or not metadata then
        return
    end

    ox_inventory:SetMetadata(src, slot, metadata)
end

inventory.server.createUseableItem = function(name, cb)
    useableItems[name] = cb
end

if Bridge.isServer then
    AddEventHandler("ox_inventory:usedItem", function(src, itemName, slot, metadata)
        local callback = useableItems[itemName]

        if callback then
            callback(src, slot, metadata)
        end
    end)
end

return inventory
