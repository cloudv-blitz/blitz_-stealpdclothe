ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("cv_stealpdclothe:giveitem1")
AddEventHandler('cv_stealpdclothe:giveitem1', function(source)
    local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('pdclothbagofficer', 1)
end)

RegisterServerEvent("cv_stealpdclothe:giveitem2")
AddEventHandler('cv_stealpdclothe:giveitem2', function(source)
    local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('pdclothbagsergeant', 1)
end)

RegisterServerEvent("cv_stealpdclothe:giveitem3")
AddEventHandler('cv_stealpdclothe:giveitem3', function(source)
    local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('pdclothbagdetective', 1)
end)

ESX.RegisterUsableItem('pdclothbagofficer', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('cv_stealpdclothe:roddyRemoval', source)
    xPlayer.removeInventoryItem("pdclothbagofficer", 1)
    sendToDiscord((''), ('' .. GetPlayerName(source) .. ' hat eine Officer Kleidung angezogen (Geklaut)'),red)
  end)
  
  ESX.RegisterUsableItem('pdclothbagdetective', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('cv_stealpdclothe:roddyRemoval2', source)
    xPlayer.removeInventoryItem("pdclothbagdetective", 1)
    sendToDiscord((''), ('' .. GetPlayerName(source) .. ' hat eine Detective Kleidung angezogen (Geklaut)'),red)
  end)
  
  ESX.RegisterUsableItem('pdclothbagsergeant', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('cv_stealpdclothe:roddyRemoval3', source)
    xPlayer.removeInventoryItem("pdclothbagsergeant", 1)
    sendToDiscord((''), ('' .. GetPlayerName(source) .. ' hat eine Sergeant Kleidung angezogen (Geklaut)'),red)
  end)
  
  ESX.RegisterUsableItem('pdclothbagofficeriii', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('cv_stealpdclothe:roddyRemoval4', source)
    xPlayer.removeInventoryItem("pdclothbagofficeriii", 1)
    sendToDiscord((''), ('' .. GetPlayerName(source) .. ' hat eine Officer III Kleidung angezogen (Geklaut)'),red)
  end)

  RegisterServerEvent('cv_stealpdclothe:getrandom')
AddEventHandler('cv_stealpdclothe:getrandom', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local randomNumber = math.random(0,10)
	if randomNumber == 1 then
		TriggerClientEvent('notifications', source, "#34AD00", "", "Du hast den Spind aufgebrochen, und hast eine Sergeant Kleidung gefunden!")
    sendToDiscord((''), ('' .. GetPlayerName(source) .. ' hat eine Sergeant Kleidung geklaut'),red)
		xPlayer.addInventoryItem('pdclothbagsergeant', 1)
    elseif randomNumber == 2 then
        TriggerClientEvent('notifications', source, "#34AD00", "", "Du hast den Spind aufgebrochen, und hast eine Detective Kleidung gefunden!")
        sendToDiscord((''), ('' .. GetPlayerName(source) .. ' hat eine Detective Kleidung geklaut'),red)
		xPlayer.addInventoryItem('pdclothbagdetective', 1)
    elseif randomNumber == 3 and randomNumber <= 6 then
        TriggerClientEvent('notifications', source, "#34AD00", "", "Du hast den Spind aufgebrochen, und hast eine Officer III Kleidung gefunden!")
        sendToDiscord((''), ('' .. GetPlayerName(source) .. ' hat eine Officer III Kleidung geklaut'),red)
		xPlayer.addInventoryItem('pdclothbagofficeriii', 1)
    else
        TriggerClientEvent('notifications', source, "#34AD00", "", "Du hast den Spind aufgebrochen, und hast eine Officer Kleidung gefunden!")
		xPlayer.addInventoryItem('pdclothbagofficer', 1)
    sendToDiscord((''), ('' .. GetPlayerName(source) .. ' hat eine Officer Kleidung geklaut'),red)
	end
end)
  
local webhook                = "https://discord.com/api/webhooks/812713340689186836/U5A9YDsp7xqSmSRflNMul7UBotCtu-Q8SzAIdDBCQvrtT7OGOIVlVc5vMgD0Cdjo91xv"

function sendToDiscord (name,message,color)
    local DiscordWebHook = webhook

    local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] ="16711680",
        ["footer"]=  {
        ["text"]= "LAPD-Kleidungsdiebstahl-Log",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end