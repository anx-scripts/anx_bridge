local func = { client = {}, server = { useableItems = {} } }

func.client.item = function(name)
    local item = exports['ox_inventory']:Items(name)

    return {
        label = item and item.label or name,
        description = item and item.description or nil,
        image = item and item.client and item.client.image or nil,
    }
end

func.client.openStash = function(identifier)
    exports['ox_inventory']:openInventory('stash', identifier)
end

func.client.hasItem = function(name, count)
    return (exports['ox_inventory']:Search('count', name) or 0) >= count
end

func.server.item = function(name)
    local item = exports['ox_inventory']:Items(name)

    return {
        label = item and item.label or name,
        description = item and item.description or nil,
    }
end

func.server.createStash = function(identifier, label, slots, weight)
    exports['ox_inventory']:RegisterStash(identifier, label, slots, weight)
end

func.server.canCarryItem = function(src, name, count)
    return exports['ox_inventory']:CanCarryItem(src, name, count) or false
end

func.server.getItems = function(src, name)
    local newItems = {}
    local items = exports['ox_inventory']:GetSlotsWithItem(src, name) or {}

    for _, v in ipairs(items) do
        table.insert(newItems, {
            metadata = v.metadata,
            count = v.count,
            slot = v.slot,
        })
    end

    return newItems
end

func.server.getItemCount = function(src, name, metadata, shouldMatch)
    if not metadata then
        return exports['ox_inventory']:Search(src, 'count', name) or 0
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
    local item = exports['ox_inventory']:GetSlot(src, slot)

    return item and {
        name = item.name,
        metadata = item.metadata,
        count = item.count,
    } or nil
end

func.server.addItem = function(src, item, count, metadata)
    exports['ox_inventory']:AddItem(src, item, count, metadata)

    if metadata and metadata.display == true then
        local file = bridge.shared.loadFile('anx_bridge', 'inventory/displayMetadata.json', true) or {}

        if type(file) == 'string' then file = json.decode(file) end

        local display = {}

        for k, v in pairs(metadata) do
            local valType = type(v)

            if k ~= 'display' and (valType == 'string' or valType == 'number') and not file[k] then
                file[k] = true
                table.insert(display, k)
            end
        end

        if #display > 0 then
            TriggerClientEvent('anx_bridge:ox_inventory:displayMetadata', -1, display)
            SaveResourceFile('anx_bridge', 'inventory/displayMetadata.json', json.encode(file), -1)
        end
    end
end

if not isServer then
    RegisterNetEvent('anx_bridge:ox_inventory:displayMetadata', function(display)
        for _, v in ipairs(display) do
            exports['ox_inventory']:displayMetadata(v, v)
        end
    end)

    if isBridge then
        local file = bridge.shared.loadFile('anx_bridge', 'inventory/displayMetadata.json', true)

        if file then
            file = json.decode(file)

            for k, _ in pairs(file) do
                exports['ox_inventory']:displayMetadata(k, k)
            end
        end
    end
end

func.server.removeItem = function(src, item, count, slot, metadata, shouldMatch)
    if not slot and not metadata then
        exports['ox_inventory']:RemoveItem(src, item, count)
    elseif slot and not metadata then
        exports['ox_inventory']:RemoveItem(src, item, count, nil, slot)
    elseif not slot and metadata then
        local shouldMatch = shouldMatch == nil and true or shouldMatch

        if shouldMatch then
            exports['ox_inventory']:RemoveItem(src, item, count, metadata)
        else
            local items = bridge.inventory.server.getItems(src, item)

            for _, v in ipairs(items) do
                if v.metadata and next(v.metadata) then
                    for key, value in pairs(metadata) do
                        if v.metadata[key] and v.metadata[key] == value then
                            exports['ox_inventory']:RemoveItem(src, item, count, nil, v.slot)
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

    exports['ox_inventory']:SetMetadata(src, slot, metadata)

    if metadata and metadata.display == true then
        local file = bridge.shared.loadFile('anx_bridge', 'inventory/displayMetadata.json', true) or {}

        if type(file) == 'string' then file = json.decode(file) end

        local display = {}

        for k, v in pairs(metadata) do
            local valType = type(v)

            if k ~= 'display' and (valType == 'string' or valType == 'number') and not file[k] then
                file[k] = true
                table.insert(display, k)
            end
        end

        if #display > 0 then
            TriggerClientEvent('anx_bridge:ox_inventory:displayMetadata', -1, display)
            SaveResourceFile('anx_bridge', 'inventory/displayMetadata.json', json.encode(file), -1)
        end
    end
end

func.server.createUseableItem = function(name, cb)
    func.server.useableItems[name] = cb
end

if isServer then
    AddEventHandler('ox_inventory:usedItem', function(src, itemName, slot, metadata)
        local callback = func.server.useableItems[itemName]

        if callback then
            callback(src, slot, metadata)
        end
    end)
end

return func
