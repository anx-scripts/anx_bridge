bridge.framework = {client = {}, server = {}}

---@class PlayerData
---@field identifier string
---@field name string
---@field job { name: string, label: string, grade: number, gradeName: string, onDuty: boolean }
---@field metadata table<string, any>

---@alias MoneyTypes "cash"|"bank"

---@return PlayerData
bridge.framework.client.getPlayerData = function() end

---@param src number
---@return PlayerData
bridge.framework.server.getPlayerData = function(src) end

---@param identifier string
---@return number|nil
bridge.framework.server.getSourceByIdentifier = function(identifier) end

---@param src number
---@param type MoneyTypes
---@return number
bridge.framework.server.getPlayerMoney = function(src, type) end

---@param src number
---@param type MoneyTypes
---@param amount number
---@return boolean
bridge.framework.server.addPlayerMoney = function(src, type, amount) end

---@param src number
---@param type MoneyTypes
---@param amount number
---@return boolean
bridge.framework.server.removePlayerMoney = function(src, type, amount) end

---@param name string
---@param cb fun(src: number, slot: number, metadata?: table<string, any>)
bridge.framework.server.createUseableItem = function(name, cb) end