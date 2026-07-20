---@type FrameworkModule
---@diagnostic disable-next-line: missing-fields
local framework = { client = {}, server = {}, object = exports["qb-core"]:GetCoreObject() }

framework.client.getPlayerData = function()
    local player = framework.object.Functions.GetPlayerData()

    if not LocalPlayer.state["anx_bridge:isLoggedIn"] then
        return nil
    end

    return {
        identifier = player.citizenid,
        name = ("%s %s"):format(player.charinfo.firstname, player.charinfo.lastname),
        job = {
            name = player.job.name,
            label = player.job.label,
            grade = player.job.grade.level,
            gradeLabel = player.job.grade.name,
            onDuty = player.job.onduty,
        },
        metadata = player.metadata,
    }
end

if not Bridge.isServer and Bridge.isBridge then
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
        LocalPlayer.state:set("anx_bridge:isLoggedIn", true, true)
        TriggerEvent("anx_bridge:onPlayerLoad")
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
        LocalPlayer.state:set("anx_bridge:isLoggedIn", false, true)
        TriggerEvent("anx_bridge:onPlayerUnload")
    end)

    RegisterNetEvent("QBCore:Client:OnJobUpdate", function(job)
        TriggerEvent("anx_bridge:onJobUpdate", {
            name = job.name,
            label = job.label,
            grade = job.grade.level,
            gradeLabel = job.grade.name,
            onDuty = job.onduty,
        })
    end)
end

framework.server.getPlayerData = function(src)
    local player = framework.object.Functions.GetPlayer(src)

    if not player or not Player(src).state["anx_bridge:isLoggedIn"] then
        return nil
    end

    return {
        identifier = player.PlayerData.citizenid,
        name = ("%s %s"):format(
            player.PlayerData.charinfo.firstname,
            player.PlayerData.charinfo.lastname
        ),
        job = {
            name = player.PlayerData.job.name,
            label = player.PlayerData.job.label,
            grade = player.PlayerData.job.grade.level,
            gradeLabel = player.PlayerData.job.grade.name,
            onDuty = player.PlayerData.job.onduty,
        },
        metadata = player.PlayerData.metadata,
    }
end

framework.server.getSourceByIdentifier = function(identifier)
    local player = framework.object.Functions.GetPlayerByCitizenId(identifier)

    return player and player.PlayerData.source or nil
end

framework.server.getPlayerMoney = function(src, type)
    local player = framework.object.Functions.GetPlayer(src)

    if not player then
        return 0
    end

    return player.Functions.GetMoney(type) or 0
end

framework.server.addPlayerMoney = function(src, type, amount)
    local player = framework.object.Functions.GetPlayer(src)

    if not player then
        return false
    end

    player.Functions.AddMoney(type, amount)

    return true
end

framework.server.removePlayerMoney = function(src, type, amount)
    local player = framework.object.Functions.GetPlayer(src)

    if not player then
        return false
    end

    if framework.server.getPlayerMoney(src, type) < amount then
        return false
    end

    player.Functions.RemoveMoney(type, amount)

    return true
end

framework.server.createUseableItem = function(name, cb)
    framework.object.Functions.CreateUseableItem(name, function(source, item)
        cb(source, item.slot, item.info)
    end)
end

return framework
