local helper = {}

---Sorts inventory items by their slot number.
---@generic T: { slot: number }
---@param items T[]
---@return T[]
function helper.sortBySlot(items)
    table.sort(items, function(a, b)
        return a.slot < b.slot
    end)

    return items
end

---Whether an item instance's metadata matches the query.
---shouldMatch = true  -> exact match (metadata identical; lib.table.matches)
---shouldMatch = false -> subset: every provided key must be equal,
---                       any remaining item fields are ignored
---@param itemMetadata table<string, any>|nil
---@param metadata table<string, any>
---@param shouldMatch boolean
---@return boolean
function helper.metadataMatches(itemMetadata, metadata, shouldMatch)
    if not itemMetadata or not next(itemMetadata) then
        return false
    end

    if shouldMatch then
        return lib.table.matches(itemMetadata, metadata)
    end

    for key, value in pairs(metadata) do
        if itemMetadata[key] ~= value then
            return false
        end
    end

    return true
end

---Sums the `count` of every instance whose metadata matches.
---@param items InventoryInstanceItem[]
---@param metadata table<string, any>
---@param shouldMatch boolean
---@return number
function helper.countByMetadata(items, metadata, shouldMatch)
    local count = 0

    for _, v in ipairs(items) do
        if helper.metadataMatches(v.metadata, metadata, shouldMatch) then
            count = count + v.count
        end
    end

    return count
end

---Builds a plan to remove `count` units spread across slots matching the metadata.
---Returns a list of steps { slot, count } or nil if the total amount across the
---matching slots is less than `count` (all-or-nothing semantics).
---@param items InventoryInstanceItem[]
---@param count number
---@param metadata table<string, any>
---@param shouldMatch boolean
---@return { slot: number, count: number }[]|nil
function helper.planRemoval(items, count, metadata, shouldMatch)
    local plan = {}
    local remaining = count

    for _, v in ipairs(items) do
        if remaining <= 0 then
            break
        end

        if helper.metadataMatches(v.metadata, metadata, shouldMatch) then
            local take = math.min(remaining, v.count)
            plan[#plan + 1] = { slot = v.slot, count = take }
            remaining = remaining - take
        end
    end

    if remaining > 0 then
        return nil
    end

    return plan
end

return helper
