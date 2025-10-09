local func = {}

func.loadFile = function(resourceName, filePath, hideWarning)
    local fileContent = LoadResourceFile(resourceName, filePath)

    if not fileContent then
        if not hideWarning then
            print(('^1failed to load file: ^3%s^1 from resource: ^3%s^0'):format(filePath, resourceName))
        end
        return nil
    end

    if filePath:match('%.json$') or filePath:match('%.ini$') then
        return fileContent
    end

    local compiledFunction, compileError = load(fileContent, filePath)

    if not compiledFunction then
        if not hideWarning then
            print(('^1compilation error in file: ^3%s^1 - ^3%s^0'):format(filePath, compileError))
        end
        return nil
    end

    local executionSuccess, executionResult = pcall(compiledFunction)

    if not executionSuccess then
        if not hideWarning then
            print(('^1execution error in file: ^3%s^1 - ^3%s^0'):format(filePath, executionResult))
        end
        return nil
    end

    return executionResult
end

func.isResourceStarted = function(resourceName)
    if GetResourceState(resourceName) == 'started' then
        return true
    end

    return false
end

func.dump = function(...)
    local function isTableEmpty(t)
        return next(t) == nil
    end
    local function formatKey(k)
        if type(k) == 'string' then
            return string.format("^3['%s']^0", k)
        else
            return string.format("^3[%s]^0", tostring(k))
        end
    end
    local function formatValue(v, indent)
        local t = type(v)
        if t == 'string' then
            return string.format("^2'%s'^0", v)
        elseif t == 'number' then
            return string.format("^5%s^0", v)
        elseif t == 'boolean' then
            return string.format("^1%s^0", tostring(v))
        elseif t == 'function' then
            return string.format("^9<%s>^0", tostring(v))
        elseif t == 'table' then
            return formatTable(v, indent + 1)
        else
            return string.format("^0%s^0", tostring(v))
        end
    end
    function formatTable(t, indent)
        indent = indent or 0
        local pad = string.rep('    ', indent)
        local padInner = string.rep('    ', indent + 1)
        if isTableEmpty(t) then
            return pad .. '^6{^0\n' .. pad .. '^6}^0'
        end
        local lines = {pad .. '^6{^0'}
        for k, v in pairs(t) do
            table.insert(lines, string.format('%s%s = %s,', padInner, formatKey(k), formatValue(v, indent)))
        end
        table.insert(lines, pad .. '^6}^0')
        return table.concat(lines, '\n')
    end
    for i = 1, select('#', ...) do
        local arg = select(i, ...)
        if type(arg) == 'table' then
            print(formatTable(arg, 0))
        else
            local t = type(arg)
            if t == 'string' then
                print(string.format("^2'%s'^0", arg))
            elseif t == 'number' then
                print(string.format("^5%s^0", arg))
            elseif t == 'boolean' then
                print(string.format("^1%s^0", tostring(arg)))
            elseif t == 'function' then
                print(string.format("^9<function: %s>^0", tostring(arg)))
            else
                print(arg)
            end
        end
    end
end

return func