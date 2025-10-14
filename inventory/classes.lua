bridge.inventory = { client = {}, server = {} }

---@param name string
---@return { label: string, description?: string, image?: string }
bridge.inventory.client.item = function(name) end

---@param identifier string
bridge.inventory.client.openStash = function(identifier) end

---@param name string
---@param count number
---@return boolean
bridge.inventory.client.hasItem = function(name, count) end

---@param name string
---@return { label: string, description?: string }
bridge.inventory.server.item = function(name) end

---@param identifier string
---@param label string
---@param slots number
---@param weight number
bridge.inventory.server.createStash = function(identifier, label, slots, weight) end

---@param src number
---@param item string
---@param count number
---@return boolean
bridge.inventory.server.canCarryItem = function(src, item, count) end

---@param src number
---@param name string
---@return { slot: number, count: number, metadata: table<string, any> }[]
bridge.inventory.server.getItems = function(src, name) end

---@param src number
---@param item string
---@param metadata? table<string, any>
---@param shouldMatch? boolean
---@return number
bridge.inventory.server.getItemCount = function(src, item, metadata, shouldMatch) end

---@param src number
---@param slot number
---@return { name: string, count: number, metadata: table<string, any> }|nil
bridge.inventory.server.getItemBySlot = function(src, slot) end

---@param src number
---@param item string
---@param count number
---@param metadata? table<string, any>
bridge.inventory.server.addItem = function(src, item, count, metadata) end

---@param src number
---@param item string
---@param count number
---@param slot? number
---@param metadata? table<string, any>
---@param shouldMatch boolean
bridge.inventory.server.removeItem = function(src, item, count, slot, metadata, shouldMatch) end

---@param src number
---@param slot number
---@param metadata? table<string, any>
bridge.inventory.server.setMetadata = function(src, slot, metadata) end
