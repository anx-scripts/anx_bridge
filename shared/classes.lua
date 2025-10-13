bridge.shared = {}

---@param resourceName string
---@param filePath string
---@param hideWarning? boolean
---@return any
bridge.shared.loadFile = function(resourceName, filePath, hideWarning) end

---@param resourceName string
bridge.shared.isResourceStarted = function(resourceName) end

---@param ... any
bridge.shared.dump = function(...) end
