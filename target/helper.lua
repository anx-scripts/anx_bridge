local helper = {}

---Default interaction distance used when a caller does not provide one.
helper.DEFAULT_DISTANCE = 2.0

---Extracts the list of identifiers used to remove options from the target
---resource. qb-target removes by `label`, ox-target removes by `name`.
---@param options TargetRemoveOptions[]
---@param key "label"|"name"
---@return string[]
function helper.pluck(options, key)
    local result = {}

    for _, v in ipairs(options) do
        result[#result + 1] = v[key]
    end

    return result
end

return helper
