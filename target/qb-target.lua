---@type TargetModule
---@diagnostic disable-next-line: missing-fields
local target = { client = {} }

local qb_target = exports["qb-target"]
local helper = require("target.helper")

---@param options TargetAddOptions[]
---@param distance? number
local function toOptions(options, distance)
    local result = { distance = distance or helper.DEFAULT_DISTANCE, options = {} }

    for _, v in ipairs(options) do
        result.options[#result.options + 1] = {
            label = v.label,
            icon = v.icon,
            action = function(entity)
                v.onSelect(entity)
            end,
            canInteract = v.canInteract and function(entity)
                return v.canInteract(entity)
            end or nil,
        }
    end

    return result
end

target.client.addGlobalObject = function(options, distance)
    qb_target:AddGlobalObject(toOptions(options, distance))
end

target.client.removeGlobalObject = function(options)
    qb_target:RemoveGlobalObject(helper.pluck(options, "label"))
end

target.client.addGlobalPed = function(options, distance)
    qb_target:AddGlobalPed(toOptions(options, distance))
end

target.client.removeGlobalPed = function(options)
    qb_target:RemoveGlobalPed(helper.pluck(options, "label"))
end

target.client.addGlobalVehicle = function(options, distance)
    qb_target:AddGlobalVehicle(toOptions(options, distance))
end

target.client.removeGlobalVehicle = function(options)
    qb_target:RemoveGlobalVehicle(helper.pluck(options, "label"))
end

target.client.addModel = function(models, options, distance)
    qb_target:AddTargetModel(models, toOptions(options, distance))
end

target.client.removeModel = function(models, options)
    qb_target:RemoveTargetModel(models, helper.pluck(options, "label"))
end

target.client.addLocalEntity = function(entities, options, distance)
    qb_target:AddTargetEntity(entities, toOptions(options, distance))
end

target.client.removeLocalEntity = function(entities, options)
    qb_target:RemoveTargetEntity(entities, helper.pluck(options, "label"))
end

return target
