local func = {client = {}, server = {}, object = exports['qb-core']:GetCoreObject()}

func.client.getPlayerData = function()
    local player = func.object.Functions.GetPlayerData()

    return {
        identifier = player.citizenid or '',
        name = ('%s %s'):format(player.charinfo.firstname, player.charinfo.lastname) or '',
        job = {
            name = player.job.name or '',
            label = player.job.label or '',
            grade = player.job.grade.level or 0,
            gradeName = player.job.grade.name or '',
            onDuty = player.job.onduty or false,
        },
        metadata = player.metadata or {},
    }
end

if not isServer and isBridge then
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        LocalPlayer.state:set('anx_bridge:isLoggedIn', true, true)
        TriggerEvent('anx_bridge:onPlayerLoad')
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        LocalPlayer.state:set('anx_bridge:isLoggedIn', false, true)
        TriggerEvent('anx_bridge:onPlayerUnload')
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
        TriggerEvent('anx_bridge:onJobUpdate', {
            name = job.name,
            label = job.label,
            grade = job.grade.level,
            gradeName = job.grade.name,
            onDuty = job.onduty
        })
    end)
end

func.server.getPlayerData = function(src)
    local player = func.object.Functions.GetPlayer(src)

    return {
        identifier = player.PlayerData.citizenid or '',
        name = ('%s %s'):format(player.PlayerData.charinfo.firstname, player.PlayerData.charinfo.lastname) or '',
        job = {
            name = player.PlayerData.job.name or '',
            label = player.PlayerData.job.label or '',
            grade = player.PlayerData.job.grade.level or 0,
            gradeName = player.PlayerData.job.grade.name or '',
            onDuty = player.PlayerData.job.onduty or false,
        },
        metadata = player.PlayerData.metadata or {},
    }
end

func.server.getSourceByIdentifier = function(identifier)
    local player = func.object.Functions.GetPlayerByCitizenId(identifier)

    return player and player.PlayerData.source or nil
end

func.server.getPlayerMoney = function(src, type)
    local player = func.object.Functions.GetPlayer(src)
    
    if not player then return 0 end

    return player.Functions.GetMoney(type) or 0
end

func.server.addPlayerMoney = function(src, type, amount)
    local player = func.object.Functions.GetPlayer(src)

    if not player then return false end

    player.Functions.AddMoney(type, amount)

    return true
end

func.server.removePlayerMoney = function(src, type, amount)
    local player = func.object.Functions.GetPlayer(src)

    if not player then return false end

    if func.server.getPlayerMoney(src, type) < amount then
        return false
    end

    player.Functions.RemoveMoney(type, amount)

    return true
end

func.server.createUseableItem = function(name, cb)
    func.object.Functions.CreateUseableItem(name, function(source, item)
        cb(source, item.slot, item.info)
    end)
end

return func