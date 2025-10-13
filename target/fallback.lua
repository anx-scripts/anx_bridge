local func = { client = {} }

func.client.addGlobalObject = function(options, distance)
    print('^1[FALLBACK] ^7Using fallback for ^1addGlobalObject^7.')
end

func.client.removeGlobalObject = function(options)
    print('^1[FALLBACK] ^7Using fallback for ^1removeGlobalObject^7.')
end

func.client.addGlobalPed = function(options, distance)
    print('^1[FALLBACK] ^7Using fallback for ^1addGlobalPed^7.')
end

func.client.removeGlobalPed = function(options)
    print('^1[FALLBACK] ^7Using fallback for ^1removeGlobalPed^7.')
end

func.client.addGlobalVehicle = function(options, distance)
    print('^1[FALLBACK] ^7Using fallback for ^1addGlobalVehicle^7.')
end

func.client.removeGlobalVehicle = function(options)
    print('^1[FALLBACK] ^7Using fallback for ^1removeGlobalVehicle^7.')
end

func.client.addModel = function(models, options, distance)
    print('^1[FALLBACK] ^7Using fallback for ^1addModel^7.')
end

func.client.removeModel = function(models, options)
    print('^1[FALLBACK] ^7Using fallback for ^1removeModel^7.')
end

func.client.addLocalEntity = function(entities, options, distance)
    print('^1[FALLBACK] ^7Using fallback for ^1addLocalEntity^7.')
end

func.client.removeLocalEntity = function(entities, options)
    print('^1[FALLBACK] ^7Using fallback for ^1removeLocalEntity^7.')
end

return func
