bridge.target = {client = {}}

---@class targetAddOptions
---@field label string Display label for the target option
---@field name string Unique name for the target option
---@field icon string|nil Icon to display for the target option
---@field onSelect fun(entity: number) Callback function to execute when the target option is selected
---@field canInteract fun(entity: number) Optional function to determine if the target option can be interacted with

---@class targetRemoveOptions
---@field name string Unique name for the target option to remove
---@field label string Display label for the target option

--- Adds a global object to the target system
--- @param options targetAddOptions[] Array of target options
--- @param distance number|nil Optional distance for the target interaction
bridge.target.client.addGlobalObject = function(options, distance) end

--- Removes global objects from the target system
--- @param options targetRemoveOptions[] Array of target options to remove
bridge.target.client.removeGlobalObject = function(options) end

--- Adds a global ped to the target system
--- @param options targetAddOptions[] Array of target options
--- @param distance number|nil Optional distance for the target interaction
bridge.target.client.addGlobalPed = function(options, distance) end

--- Removes global peds from the target system
--- @param options targetRemoveOptions[] Array of target options to remove
bridge.target.client.removeGlobalPed = function(options) end

--- Adds a global vehicle to the target system
--- @param options targetAddOptions[] Array of target options
--- @param distance number|nil Optional distance for the target interaction
bridge.target.client.addGlobalVehicle = function(options, distance) end

--- Removes global vehicles from the target system
--- @param options targetRemoveOptions[] Array of target options to remove
bridge.target.client.removeGlobalVehicle = function(options) end

--- Adds a model to the target system
--- @param models string[] Array of model names to add
--- @param options targetAddOptions[] Array of target options for the interaction
--- @param distance number|nil Optional distance for the target interaction
bridge.target.client.addModel = function(models, options, distance) end

--- Removes models from the target system
--- @param models string[] Array of model names to remove
--- @param options targetRemoveOptions[] Array of target options to remove
bridge.target.client.removeModel = function(models, options) end

--- Adds a local entity to the target system
--- @param entities number[] Array of entity names to add
--- @param options targetAddOptions[] Array of target options for the interaction
--- @param distance number|nil Optional distance for the target interaction
bridge.target.client.addLocalEntity = function(entities, options, distance) end

--- Removes local entities from the target system
--- @param entities number[] Array of entity names to remove
--- @param options targetRemoveOptions[] Array of target options to remove
bridge.target.client.removeLocalEntity = function(entities, options) end