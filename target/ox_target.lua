---@type TargetModule
---@diagnostic disable-next-line: missing-fields
local target = { client = {} }

local ox_target = exports["ox_target"]
local helper = require("target.helper")

---@param options TargetAddOptions[]
---@param distance? number
local function toOptions(options, distance)
  local result = {}

  for _, v in ipairs(options) do
    result[#result + 1] = {
      name = v.name,
      label = v.label,
      icon = v.icon,
      distance = distance or helper.DEFAULT_DISTANCE,
      onSelect = function(data)
        v.onSelect(data.entity)
      end,
      canInteract = v.canInteract and function(entity, dist, coords, name, bone)
        return v.canInteract(entity)
      end or nil,
    }
  end

  return result
end

target.client.addGlobalObject = function(options, distance)
  ox_target:addGlobalObject(toOptions(options, distance))
end

target.client.removeGlobalObject = function(options)
  ox_target:removeGlobalObject(helper.pluck(options, "name"))
end

target.client.addGlobalPed = function(options, distance)
  ox_target:addGlobalPed(toOptions(options, distance))
end

target.client.removeGlobalPed = function(options)
  ox_target:removeGlobalPed(helper.pluck(options, "name"))
end

target.client.addGlobalVehicle = function(options, distance)
  ox_target:addGlobalVehicle(toOptions(options, distance))
end

target.client.removeGlobalVehicle = function(options)
  ox_target:removeGlobalVehicle(helper.pluck(options, "name"))
end

target.client.addModel = function(models, options, distance)
  ox_target:addModel(models, toOptions(options, distance))
end

target.client.removeModel = function(models, options)
  ox_target:removeModel(models, helper.pluck(options, "name"))
end

target.client.addLocalEntity = function(entities, options, distance)
  ox_target:addLocalEntity(entities, toOptions(options, distance))
end

target.client.removeLocalEntity = function(entities, options)
  ox_target:removeLocalEntity(entities, helper.pluck(options, "name"))
end

return target
