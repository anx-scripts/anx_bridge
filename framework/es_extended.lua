---@type FrameworkModule
---@diagnostic disable-next-line: missing-fields
local framework = { client = {}, server = {}, object = exports["es_extended"]:getSharedObject() }

framework.client.getPlayerData = function()
  local player = framework.object.GetPlayerData()

  if not LocalPlayer.state["anx_bridge:isLoggedIn"] then
    return nil
  end

  return {
    identifier = player.identifier,
    name = ("%s %s"):format(player.firstName, player.lastName),
    job = {
      name = player.job.name,
      label = player.job.label,
      grade = player.job.grade,
      gradeLabel = player.job.grade_label,
      onDuty = player.job.onDuty,
    },
    metadata = player.metadata,
  }
end

if not Bridge.isServer and Bridge.isBridge then
  RegisterNetEvent("esx:playerLoaded", function()
    LocalPlayer.state:set("anx_bridge:isLoggedIn", true, true)
    TriggerEvent("anx_bridge:onPlayerLoad")
  end)

  RegisterNetEvent("esx:onPlayerLogout", function()
    LocalPlayer.state:set("anx_bridge:isLoggedIn", false, true)
    TriggerEvent("anx_bridge:onPlayerUnload")
  end)

  RegisterNetEvent("esx:setJob", function(job)
    TriggerEvent("anx_bridge:onJobUpdate", {
      name = job.name,
      label = job.label,
      grade = job.grade,
      gradeLabel = job.grade_label,
      onDuty = job.onDuty,
    })
  end)
end

framework.server.getPlayerData = function(src)
  local player = framework.object.GetPlayerFromId(src)

  if not player or not Player(src).state["anx_bridge:isLoggedIn"] then
    return nil
  end

  return {
    identifier = player.identifier,
    name = player.name,
    job = {
      name = player.job.name,
      label = player.job.label,
      grade = player.job.grade,
      gradeLabel = player.job.grade_label,
      onDuty = player.job.onDuty,
    },
    metadata = player.metadata,
  }
end

framework.server.getSourceByIdentifier = function(identifier)
  local player = framework.object.GetPlayerFromIdentifier(identifier)

  return player and player.source or nil
end

framework.server.getPlayerMoney = function(src, type)
  local account = type == "cash" and "money" or type
  local player = framework.object.GetPlayerFromId(src)

  if not player then
    return 0
  end

  local accounts = player.getAccounts(true)

  return accounts[account] or 0
end

framework.server.addPlayerMoney = function(src, type, amount)
  local account = type == "cash" and "money" or type
  local player = framework.object.GetPlayerFromId(src)

  if not player then
    return false
  end

  player.addAccountMoney(account, amount)

  return true
end

framework.server.removePlayerMoney = function(src, type, amount)
  local account = type == "cash" and "money" or type
  local player = framework.object.GetPlayerFromId(src)

  if not player then
    return false
  end

  if framework.server.getPlayerMoney(src, type) < amount then
    return false
  end

  player.removeAccountMoney(account, amount)

  return true
end

framework.server.createUseableItem = function(name, cb)
  framework.object.RegisterUsableItem(name, cb)
end

return framework
