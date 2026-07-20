---@type FrameworkModule
---@diagnostic disable-next-line: missing-fields
local framework = { client = {}, server = {} }

framework.client.getPlayerData = function()
    print("^1[FALLBACK] ^7Using fallback for ^1getPlayerData^7.")

    return nil
end

framework.server.getPlayerData = function()
    print("^1[FALLBACK] ^7Using fallback for ^1getPlayerData^7.")

    return nil
end

framework.server.getSourceByIdentifier = function()
    print("^1[FALLBACK] ^7Using fallback for ^1getSourceByIdentifier^7.")

    return nil
end

framework.server.getPlayerMoney = function()
    print("^1[FALLBACK] ^7Using fallback for ^1getPlayerMoney^7.")

    return 0
end

framework.server.addPlayerMoney = function()
    print("^1[FALLBACK] ^7Using fallback for ^1addPlayerMoney^7.")

    return false
end

framework.server.removePlayerMoney = function()
    print("^1[FALLBACK] ^7Using fallback for ^1removePlayerMoney^7.")

    return false
end

framework.server.createUseableItem = function()
    print("^1[FALLBACK] ^7Using fallback for ^1createUseableItem^7.")
end

return framework
