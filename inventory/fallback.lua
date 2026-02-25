local inventory = { client = {}, server = {} }

inventory.client.item = function(name)
  print("^1[FALLBACK] ^7Using fallback for ^1item^7.")
  return { label = name }
end

inventory.client.items = function()
  print("^1[FALLBACK] ^7Using fallback for ^1items^7.")
  return {}
end

inventory.client.openStash = function()
  print("^1[FALLBACK] ^7Using fallback for ^1openStash^7.")
end

inventory.client.hasItem = function()
  print("^1[FALLBACK] ^7Using fallback for ^1hasItem^7.")
  return false
end

inventory.client.setBusy = function()
  print("^1[FALLBACK] ^7Using fallback for ^1setBusy^7.")
end

inventory.server.item = function(name)
  print("^1[FALLBACK] ^7Using fallback for ^1item^7.")
  return { label = name }
end

inventory.server.createStash = function()
  print("^1[FALLBACK] ^7Using fallback for ^1createStash^7.")
end

inventory.server.canCarryItem = function()
  print("^1[FALLBACK] ^7Using fallback for ^1canCarryItem^7.")
  return false
end

inventory.server.getItems = function()
  print("^1[FALLBACK] ^7Using fallback for ^1getItems^7.")
  return {}
end

inventory.server.getItemCount = function()
  print("^1[FALLBACK] ^7Using fallback for ^1getItemCount^7.")
  return 0
end

inventory.server.getItemBySlot = function()
  print("^1[FALLBACK] ^7Using fallback for ^1getItemBySlot^7.")
  return nil
end

inventory.server.addItem = function()
  print("^1[FALLBACK] ^7Using fallback for ^1addItem^7.")
end

inventory.server.removeItem = function()
  print("^1[FALLBACK] ^7Using fallback for ^1removeItem^7.")
end

inventory.server.setMetadata = function()
  print("^1[FALLBACK] ^7Using fallback for ^1setMetadata^7.")
end

inventory.server.createUseableItem = function()
  print("^1[FALLBACK] ^7Using fallback for ^1createUseableItem^7.")
end

return inventory
