local func = {client = {}}

func.client.addGlobalObject = function(options, distance)
    local newOptions = {distance = distance or 2.0, options = {}}

    for _, v in ipairs(options) do
        table.insert(newOptions.options, {
            label = v.label,
            icon = v.icon,
            action = function(entity)
                v.onSelect(entity)
            end,
            canInteract = v.canInteract and function(entity)
                return v.canInteract(entity)
            end or nil,
        })
    end

    exports['qb-target']:AddGlobalObject(newOptions)
end

func.client.removeGlobalObject = function(options)
    local newOptions = {}

    for _, v in ipairs(options) do
        table.insert(newOptions, v.label)
    end

    exports['qb-target']:RemoveGlobalObject(newOptions)
end

func.client.addGlobalPed = function(options, distance)
    local newOptions = {distance = distance or 2.0, options = {}}

    for _, v in ipairs(options) do
        table.insert(newOptions.options, {
            label = v.label,
            icon = v.icon,
            action = function(entity)
                v.onSelect(entity)
            end,
            canInteract = v.canInteract and function(entity)
                return v.canInteract(entity)
            end or nil,
        })
    end

    exports['qb-target']:AddGlobalPed(newOptions)
end

func.client.removeGlobalPed = function(options)
    local newOptions = {}

    for _, v in ipairs(options) do
        table.insert(newOptions, v.label)
    end

    exports['qb-target']:RemoveGlobalPed(newOptions)
end

func.client.addGlobalVehicle = function(options, distance)
    local newOptions = {distance = distance or 2.0, options = {}}

    for _, v in ipairs(options) do
        table.insert(newOptions.options, {
            label = v.label,
            icon = v.icon,
            action = function(entity)
                v.onSelect(entity)
            end,
            canInteract = v.canInteract and function(entity)
                return v.canInteract(entity)
            end or nil,
        })
    end

    exports['qb-target']:AddGlobalVehicle(newOptions)
end

func.client.removeGlobalVehicle = function(options)
    local newOptions = {}

    for _, v in ipairs(options) do
        table.insert(newOptions, v.label)
    end

    exports['qb-target']:RemoveGlobalVehicle(newOptions)
end

func.client.addModel = function(models, options, distance)
    local newOptions = {distance = distance or 2.0, options = {}}

    for _, v in ipairs(options) do
        table.insert(newOptions.options, {
            label = v.label,
            icon = v.icon,
            action = function(entity)
                v.onSelect(entity)
            end,
            canInteract = v.canInteract and function(entity)
                return v.canInteract(entity)
            end or nil,
        })
    end

    exports['qb-target']:AddTargetModel(models, newOptions)
end

func.client.removeModel = function(models, options)
    local newOptions = {}

    for _, v in ipairs(options) do
        table.insert(newOptions, v.label)
    end

    exports['qb-target']:RemoveTargetModel(models, newOptions)
end

func.client.addLocalEntity = function(entities, options, distance)
    local newOptions = {distance = distance or 2.0, options = {}}

    for _, v in ipairs(options) do
        table.insert(newOptions.options, {
            label = v.label,
            icon = v.icon,
            action = function(entity)
                v.onSelect(entity)
            end,
            canInteract = v.canInteract and function(entity)
                return v.canInteract(entity)
            end or nil,
        })
    end

    exports['qb-target']:AddTargetEntity(entities, newOptions)
end

func.client.removeLocalEntity = function(entities, options)
    local newOptions = {}

    for _, v in ipairs(options) do
        table.insert(newOptions, v.label)
    end

    exports['qb-target']:RemoveTargetEntity(entities, newOptions)
end

return func