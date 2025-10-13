bridge.target = { client = {} }

---@class TargetAddOptions
---@field label string
---@field name string
---@field icon? string
---@field onSelect fun(entity: number)
---@field canInteract? fun(entity: number)

---@class TargetRemoveOptions
---@field name string
---@field label string

---@param options TargetAddOptions[]
---@param distance? number
bridge.target.client.addGlobalObject = function(options, distance) end

---@param options TargetRemoveOptions[]
bridge.target.client.removeGlobalObject = function(options) end

---@param options TargetAddOptions[]
---@param distance? number
bridge.target.client.addGlobalPed = function(options, distance) end

---@param options TargetRemoveOptions[]
bridge.target.client.removeGlobalPed = function(options) end

---@param options TargetAddOptions[]
---@param distance? number
bridge.target.client.addGlobalVehicle = function(options, distance) end

---@param options TargetRemoveOptions[]
bridge.target.client.removeGlobalVehicle = function(options) end

---@param models string[]
---@param options TargetAddOptions[]
---@param distance? number
bridge.target.client.addModel = function(models, options, distance) end

---@param models string[]
---@param options TargetRemoveOptions[]
bridge.target.client.removeModel = function(models, options) end

---@param entities number[]
---@param options TargetAddOptions[]
---@param distance? number
bridge.target.client.addLocalEntity = function(entities, options, distance) end

---@param entities number[]
---@param options TargetRemoveOptions[]
bridge.target.client.removeLocalEntity = function(entities, options) end
