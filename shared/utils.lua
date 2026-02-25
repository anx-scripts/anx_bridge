local shared = {}

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

local formatTable

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
		return formatTable(v, (indent or 0) + 1)
	else
		return string.format("^0%s^0", tostring(v))
	end
end

formatTable = function(t, indent)
	indent = indent or 0
	local pad = string.rep('    ', indent)
	local padInner = string.rep('    ', indent + 1)

	if isTableEmpty(t) then
		return pad .. '^6{^0\n' .. pad .. '^6}^0'
	end

	local lines = { pad .. '^6{^0' }
	for k, v in pairs(t) do
		table.insert(lines, string.format('%s%s = %s,', padInner, formatKey(k), formatValue(v, indent)))
	end
	table.insert(lines, pad .. '^6}^0')

	return table.concat(lines, '\n')
end

shared.dump = function(...)
	local n = select('#', ...)
	for i = 1, n do
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

local LOG_COLORS = {
	error = "^1",
	success = "^2",
	info = "^3",
	warn = "^4",
}

shared.log = function(message, type)
	local color = LOG_COLORS[type] or "^7"
	print(string.format("%s[%s]^7 %s", color, type:upper(), tostring(message)))
end

return shared
