local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('CTD-Cartheft:Payment')
AddEventHandler('CTD-Cartheft:Payment', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney("cash", Config.Payment, "Payment")
end)