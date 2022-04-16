local QBCore = exports['qb-core']:GetCoreObject()
local InCoolDown = 0
local CoolDownTime = 1800 * 1000 --30 mins

RegisterServerEvent('CTD-Cartheft:Payment')
AddEventHandler('CTD-Cartheft:Payment', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney("cash", Config.Payment, "Payment")
end)

RegisterServerEvent('CTD-Cartheft:setcooldown')
AddEventHandler('CTD-Cartheft:setcooldown', function()
	InCoolDown = 1
	Citizen.Wait(CoolDownTime)
	InCoolDown = 0
end)

RegisterServerEvent('CTD-Cartheft:checkcooldown')
AddEventHandler('CTD-Cartheft:checkcooldown', function()
	local src = source
    if InCoolDown == 0 then
		TriggerClientEvent('CTD-Cartheft:client:SpawnCar', src)
	else
        TriggerClientEvent('QBCore:Notify', src, "cooldown", "error")
    end
end)
