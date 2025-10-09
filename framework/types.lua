---@class PlayerData
---@field identifier string Player unique identifier
---@field name string Player character name
---@field job JobData Player job information

---@class JobData
---@field name string Job name
---@field label string Job label
---@field grade number Job grade level
---@field gradeName string Job grade label
---@field onDuty boolean Whether player is on duty

---@class moneyTypes
---@field cash number Amount of cash
---@field bank number Amount of bank money

---@alias moneyType "cash"|"bank"

bridge.framework = {client = {}, server = {}}

--- Gets player data on the client side
---@return PlayerData playerData Player data structure
bridge.framework.client.getPlayerData = function() end

--- Gets player data on the server side
---@param src number Player source ID
---@return PlayerData playerData Player data structure
bridge.framework.server.getPlayerData = function(src) end

--- Gets player source by identifier
---@param identifier string Player identifier to search for
---@return number|nil source Player source ID or nil if not found
bridge.framework.server.getSourceByIdentifier = function(identifier) end

--- Gets player money amount
---@param src number Player source ID
---@param type moneyType Money type ("cash" or "bank")
---@return number amount Money amount
bridge.framework.server.getPlayerMoney = function(src, type) end

--- Adds money to player account
---@param src number Player source ID
---@param type moneyType Money type ("cash" or "bank")
---@param amount number Amount to add
---@return boolean success Whether the operation was successful
bridge.framework.server.addPlayerMoney = function(src, type, amount) end

--- Removes money from player account
---@param src number Player source ID
---@param type moneyType Money type ("cash" or "bank")
---@param amount number Amount to remove
---@return boolean success Whether the operation was successful
bridge.framework.server.removePlayerMoney = function(src, type, amount) end

--- Creates a useable item with callback
---@param name string Item name to make useable
---@param cb fun(src: number, slot: number, metadata?: table) Callback function to execute when item is used
bridge.framework.server.createUseableItem = function(name, cb) end