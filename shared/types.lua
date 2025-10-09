bridge.shared = {}

--- Loads and executes a Lua file from a resource
--- @param resourceName string The name of the resource to load the file from
--- @param filePath string The path to the file within the resource
--- @param hideWarning boolean|nil Optional parameter to suppress warnings (default is false)
--- @return any|nil The result of executing the file, or nil if an error occurred
bridge.shared.loadFile = function(resourceName, filePath, hideWarning) end

--- Checks if a resource is started
--- @param resourceName string The name of the resource to check
--- @return boolean True if the resource is started, false otherwise
bridge.shared.isResourceStarted = function(resourceName) end

--- Debug function to print tables and values with colored formatting
--- @param ... any The values to be printed
bridge.shared.dump = function(...) end