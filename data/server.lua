ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('craft:hasItem', function(source, callback, item, amount)

  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)

  if xPlayer.getInventoryItem(item) then
    if xPlayer.getInventoryItem(item).count >= amount then
      callback(true)
    else
      callback(false)
    end
  else
    callback(false)
  end
end)

RegisterServerEvent('craft:removeItem')
AddEventHandler('craft:removeItem', function(item, amount)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  xPlayer.removeInventoryItem(item, amount)
end)


RegisterServerEvent('craft:addItem')
AddEventHandler('craft:addItem', function(item, amount)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  xPlayer.addInventoryItem(item, amount)
end)
