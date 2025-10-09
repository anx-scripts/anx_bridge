local func = {client = {}, server = {useableItems = {}}}

func.client.item = function(name)
    print('^1[FALLBACK] ^7Using fallback for ^1item^7.')
    return { label = name }
end

func.client.openStash = function(identifier)
    print('^1[FALLBACK] ^7Using fallback for ^1openStash^7.')
end

func.client.hasItem = function(name, count)
    print('^1[FALLBACK] ^7Using fallback for ^1hasItem^7.')
    return false
end

func.server.item = function(name)
    print('^1[FALLBACK] ^7Using fallback for ^1item^7.')
    return { label = name }
end

func.server.createStash = function(identifier, label, slots, weight)
    print('^1[FALLBACK] ^7Using fallback for ^1createStash^7.')
end

func.server.canCarryItem = function(src, name, count)
    print('^1[FALLBACK] ^7Using fallback for ^1canCarryItem^7.')
    return false
end

func.server.getItems = function(src, name)
    print('^1[FALLBACK] ^7Using fallback for ^1getItems^7.')
    return {}
end

func.server.getItemCount = function(src, name, metadata, shouldMatch)
    print('^1[FALLBACK] ^7Using fallback for ^1getItemCount^7.')
    return 0
end

func.server.getItemBySlot = function(src, slot)
    print('^1[FALLBACK] ^7Using fallback for ^1getItemBySlot^7.')
    return nil
end

func.server.addItem = function(src, item, count, metadata)
    print('^1[FALLBACK] ^7Using fallback for ^1addItem^7.')
end

func.server.removeItem = function(src, item, count, slot, metadata, shouldMatch)
    print('^1[FALLBACK] ^7Using fallback for ^1removeItem^7.')
end

func.server.setMetadata = function(src, slot, metadata)
    print('^1[FALLBACK] ^7Using fallback for ^1setMetadata^7.')
end

func.server.createUseableItem = function(name, cb)
    print('^1[FALLBACK] ^7Using fallback for ^1createUseableItem^7.')
end

return func