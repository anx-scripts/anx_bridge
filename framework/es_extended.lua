local func = { client = {}, server = {}, object = exports['es_extended']:getSharedObject() }

func.client.getPlayerData = function()
    local player = func.object.GetPlayerData()

    return {
        identifier = player.identifier or '',
        name = ('%s %s'):format(player.firstName, player.lastName) or '',
        job = {
            name = player.job.name or '',
            label = player.job.label or '',
            grade = player.job.grade or 0,
            gradeName = player.job.grade_name or '',
            onDuty = player.job.onDuty or false,
        },
        metadata = player.metadata or {},
    }
end

if not isServer and isBridge then
    RegisterNetEvent('esx:playerLoaded', function()
        LocalPlayer.state:set('anx_bridge:isLoggedIn', true, true)
        TriggerEvent('anx_bridge:onPlayerLoad')
    end)

    RegisterNetEvent('esx:onPlayerLogout', function()
        LocalPlayer.state:set('anx_bridge:isLoggedIn', false, true)
        TriggerEvent('anx_bridge:onPlayerUnload')
    end)

    RegisterNetEvent('esx:setJob', function(job)
        TriggerEvent('anx_bridge:onJobUpdate', {
            name = job.name or '',
            label = job.label or '',
            grade = job.grade or 0,
            gradeName = job.grade_name or '',
            onDuty = job.onDuty or false,
        })
    end)
end

func.server.getPlayerData = function(src)
    local player = func.object.GetPlayerFromId(src)

    return {
        identifier = player.identifier or '',
        name = player.name,
        job = {
            name = player.job.name or '',
            label = player.job.label or '',
            grade = player.job.grade or 0,
            gradeName = player.job.grade_name or '',
            onDuty = player.job.onDuty or false,
        },
        metadata = player.metadata or {},
    }
end

func.server.getSourceByIdentifier = function(identifier)
    local player = func.object.GetPlayerFromIdentifier(identifier)

    return player and player.source or nil
end

func.server.getPlayerMoney = function(src, type)
    local type = type == 'cash' and 'money' or type
    local player = func.object.GetPlayerFromId(src)

    if not player then return 0 end

    local accounts = player.getAccounts(true)

    return accounts[type] or 0
end

func.server.addPlayerMoney = function(src, type, amount)
    local type = type == 'cash' and 'money' or type
    local player = func.object.GetPlayerFromId(src)

    if not player then return false end

    player.addAccountMoney(type, amount)

    return true
end

func.server.removePlayerMoney = function(src, type, amount)
    local type = type == 'cash' and 'money' or type
    local player = func.object.GetPlayerFromId(src)

    if not player then return false end

    if func.server.getPlayerMoney(src, type) < amount then
        return false
    end

    player.removeAccountMoney(type, amount)

    return true
end

func.server.createUseableItem = function(name, cb)
    func.object.RegisterUsableItem(name, cb)
end

return func
