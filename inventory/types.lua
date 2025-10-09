bridge.inventory = {client = {}, server = {}}

--- Gets the label, description and image of an item
--- @param name string Item name to get the details for
--- @return table table containing the label, description, and image of the item
bridge.inventory.client.item = function(name) end

--- Opens a stash inventory
---@param identifier string Unique identifier for the stash
bridge.inventory.client.openStash = function(identifier) end

--- Checks if the player has a specific item
--- @param name string Item name to check
--- @param count number Amount of the item to check
--- @return boolean boolean True if the player has the item with provided count, false otherwise
bridge.inventory.client.hasItem = function(name, count) end

--- Gets the label, description and image of an item
--- @param name string Item name to get the details for
--- @return table table containing the label and description of the item
bridge.inventory.server.item = function(name) end

--- Creates a stash inventory
--- @param identifier string Unique identifier for the stash
--- @param label string Display label/name for the stash
--- @param slots number Maximum number of slots in the stash
--- @param weight number Maximum weight capacity of the stash
bridge.inventory.server.createStash = function(identifier, label, slots, weight) end

--- Checks if a player can carry a specific item
--- @param src number Player source ID
--- @param item string Item name to check
--- @param count number Amount of the item to check
bridge.inventory.server.canCarryItem = function(src, item, count) end

--- Gets all items with a specific name in a player's inventory
--- @param src number Player source ID
--- @param name string Item name to search for
--- @return table table containing all items with the specified slot, count and metadata
bridge.inventory.server.getItems = function(src, name) end

--- Gets the count of a specific item in a player's inventory
--- @param src number Player source ID
--- @param item string Item name to check
--- @param metadata table|nil Optional metadata for the item
--- @param shouldMatch boolean|nil If true, metadata must match exactly; if false, at least one key-value pair must match, If nil, it will be set to true
bridge.inventory.server.getItemCount = function(src, item, metadata, shouldMatch) end

--- Gets an item by its slot in a player's inventory
--- @param src number Player source ID
--- @param slot number Slot number to get the item from
--- @return table|nil table containing the item details (name, metadata, count) or nil if not found
bridge.inventory.server.getItemBySlot = function(src, slot) end

--- Adds an item to a player's inventory
--- @param src number Player source ID
--- @param item string Item name to add
--- @param count number Amount of the item to add
--- @param metadata table|nil Optional metadata for the item (if metadata value is string or number and display is true, it will display metadata values in inventory)
bridge.inventory.server.addItem = function(src, item, count, metadata) end

--- Removes an item from a player's inventory (you can not provide a slot and metadata at the same time)
--- @param src number Player source ID
--- @param item string Item name to remove
--- @param count number Amount of the item to remove
--- @param slot number|nil Optional slot number to remove the item from, if nil it will remove from any slot
--- @param metadata table|nil Optional metadata for the item
--- @param shouldMatch boolean|nil If true, metadata must match exactly; if false, at least one key-value pair must match, If nil, it will be set to true
bridge.inventory.server.removeItem = function(src, item, count, slot, metadata, shouldMatch) end

--- Sets metadata for an item in a player's inventory
--- @param src number Player source ID
--- @param slot number Slot number of the item to set metadata for
--- @param metadata table|nil Metadata to set for the item (if metadata value is string or number and display is true, it will display metadata values in inventory)
bridge.inventory.server.setMetadata = function(src, slot, metadata) end