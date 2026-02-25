local target = { client = {} }

target.client.addGlobalObject = function()
  print('^1[FALLBACK] ^7Using fallback for ^1addGlobalObject^7.')
end

target.client.removeGlobalObject = function()
  print('^1[FALLBACK] ^7Using fallback for ^1removeGlobalObject^7.')
end

target.client.addGlobalPed = function()
  print('^1[FALLBACK] ^7Using fallback for ^1addGlobalPed^7.')
end

target.client.removeGlobalPed = function()
  print('^1[FALLBACK] ^7Using fallback for ^1removeGlobalPed^7.')
end

target.client.addGlobalVehicle = function()
  print('^1[FALLBACK] ^7Using fallback for ^1addGlobalVehicle^7.')
end

target.client.removeGlobalVehicle = function()
  print('^1[FALLBACK] ^7Using fallback for ^1removeGlobalVehicle^7.')
end

target.client.addModel = function()
  print('^1[FALLBACK] ^7Using fallback for ^1addModel^7.')
end

target.client.removeModel = function()
  print('^1[FALLBACK] ^7Using fallback for ^1removeModel^7.')
end

target.client.addLocalEntity = function()
  print('^1[FALLBACK] ^7Using fallback for ^1addLocalEntity^7.')
end

target.client.removeLocalEntity = function()
  print('^1[FALLBACK] ^7Using fallback for ^1removeLocalEntity^7.')
end

return target
