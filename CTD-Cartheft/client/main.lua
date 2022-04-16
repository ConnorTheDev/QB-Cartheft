local QBCore = exports['qb-core']:GetCoreObject()
local InService = false
local CartheftStart = 0
local IsInCoolDown = 0
local CoolDownTime = 1800 * 1000 --30 mins

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    InService = false
    PlayerData = QBCore.Functions.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if CartheftStart == 0 then
      local InRange = false
      local pedCoords = GetEntityCoords(PlayerPedId())
      local distance = #(pedCoords - vector3(Config.marker.x,Config.marker.y,Config.marker.z))
      if(distance < 2) then
        InRange = true
        DrawMarker(23, Config.marker.x, Config.marker.y, Config.marker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 3.5, 144, 128, 0, 100, false, true, 2, nil, nil, false)
        DrawText3D(Config.marker.x, Config.marker.y, Config.marker.z+1, "[E] Open Menu")
      if IsControlJustReleased(0, 51) then
        if IsInCoolDown == 0 then
        OpenMenu()
        else
          QBCore.Functions.Notify('Cooldown', 'error')
        end
      end
    end
    if not InRange then
      Wait(3000)
    end
  end
end)

RegisterNetEvent("CTD-Cartheft:client:SpawnCar", function(coords)
    local coords = Config.spawner
    local veh = Config.Vehicles[math.random(#Config.Vehicles)].model
      QBCore.Functions.SpawnVehicle(veh, function(veh)
        SetVehicleNumberPlateText(veh, "CTD"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        SetVehicleTyreBurst(veh, 0, true, 800.0)
        SetVehicleDirtLevel(veh, 15.0)
        SetVehicleDoorBroken(veh, 0, true)
        SetVehicleDoorBroken(veh, 3, true)
        SetVehicleEngineHealth(veh, 300.0)
        SmashVehicleWindow(veh, true, 0)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
    end, coords, true)
    CartheftStart = 1
    ShowBlip()
    TriggerEvent("CTD-Cartheft:Npc")
    TriggerEvent("CTD-Cartheft:client:Email")
    InService = true
    Citizen.Wait(78000)
    RemoveBlip(Blip)
    SetRoute1()
    TriggerEvent("CTD-Cartheft:client:RepairCar")
end)

RegisterNetEvent("CTD-Cartheft:client:RepairCar")
AddEventHandler("CTD-Cartheft:client:RepairCar", function(pedCoords)--remove the loop
  while InService do
    Citizen.Wait(0)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local distance = #(pedCoords - vector3(Config.Repair.x,Config.Repair.y,Config.Repair.z))
    if InCar() then
    if(distance < 2) then
      DrawMarker(23, Config.Repair.x, Config.Repair.y, Config.Repair.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 3.5, 144, 128, 0, 100, false, true, 2, nil, nil, false)
      DrawText3D(Config.Repair.x, Config.Repair.y, Config.Repair.z+1, "[E] Repair")
    end
    if(distance < 2) then
    if IsPedInAnyVehicle(PlayerPedId(), false) then
    if IsControlJustReleased(0, 51) then
            TriggerEvent("CTD-Cartheft:client:RepairCarTime")
            RemoveBlip(RepairBlip)
            SetRoute()
          end
        end
      end
    end
  end
end)

RegisterNetEvent("CTD-Cartheft:client:RepairCarTime")
AddEventHandler("CTD-Cartheft:client:RepairCarTime", function()
    QBCore.Functions.Progressbar("Repair_car", "Repairing Car", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
    local Ped = PlayerPedId()
    local Veh = GetVehiclePedIsIn(Ped, false)
    SetVehicleFixed(Veh)
	  SetVehicleDirtLevel(Veh, 0.0)
    SetVehiclePetrolTankHealth(Veh, 4000.0)
    TriggerEvent("CTD-Cartheft:client:finish")
    end)
end)

RegisterNetEvent('CTD-Cartheft:client:finish')
AddEventHandler('CTD-Cartheft:client:finish', function()
  while InService do
    Citizen.Wait(0)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local distance = #(pedCoords - vector3(Config.Delivery.x,Config.Delivery.y,Config.Delivery.z))
    if InCar() then
    if(distance < 2) then
      DrawMarker(23, Config.Delivery.x, Config.Delivery.y, Config.Delivery.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 3.5, 144, 128, 0, 100, false, true, 2, nil, nil, false)
      DrawText3D(Config.Delivery.x, Config.Delivery.y, Config.Delivery.z+1, "[E] DONE")
    end
    if(distance < 2) then
    if IsPedInAnyVehicle(PlayerPedId(), false) then
    if IsControlJustReleased(0, 51) then
            JobDone()
          end
        end
      end
    end
  end
end)

RegisterNetEvent('CTD-Cartheft:client:Email', function(amount)
  SetTimeout(math.random(2500, 4000), function()
      local gender = "Mr."
      if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
          gender = "Mrs."
      end
      local charinfo = QBCore.Functions.GetPlayerData().charinfo
      TriggerServerEvent('qb-phone:server:sendNewMail', {
          sender = "ConnorTheDev",
          subject = "Job",
          message = "Dear " .. gender .. " " .. charinfo.lastname .. ", Go pick up the car, I will update your gps as you go. Be careful as the car is damaged so you will need to get it repaired.. GOOD LUCK",
          button = {}
      })
  end)
end)


--Functions that's needed in here
function JobDone()
  RemoveBlip(DeliveryBlip)
  SetEntityAsNoLongerNeeded(veh)
  DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
  TriggerServerEvent("CTD-Cartheft:Payment")
  QBCore.Functions.Notify('Job Done', 'primary')
  InService = false
  CartheftStart = 0
end

function CoolDown()
  IsInCoolDown = 1
	Citizen.Wait(CoolDownTime)
  IsInCoolDown = 0
end
