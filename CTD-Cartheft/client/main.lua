local QBCore = exports['qb-core']:GetCoreObject()
local InService = false
local IsCarRepaired = false
local plate
local number = math.random(1,#Config.CarSpawns)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  InService = false
  PlayerData = QBCore.Functions.GetPlayerData()
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local InRange = false
    local pedCoords = GetEntityCoords(PlayerPedId())
    local distance = #(pedCoords - vector3(Config.marker.x,Config.marker.y,Config.marker.z))
    if(distance < 2) then
      InRange = true
      DrawMarker(23, Config.marker.x, Config.marker.y, Config.marker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 3.5, 144, 128, 0, 100, false, true, 2, nil, nil, false)
      DrawText3D(Config.marker.x, Config.marker.y, Config.marker.z+1, "[E] Open Menu")
      if IsControlJustReleased(0, 51) then
        OpenMenu()
      end
    end
    if not InRange then
      Wait(3000)
    end
  end
end)

RegisterNetEvent("CTD-Cartheft:client:CoolDown", function()
  TriggerServerEvent("CTD-Cartheft:checkcooldown")
end)

RegisterNetEvent("CTD-Cartheft:client:SpawnCar", function(coords)
  local ped = PlayerPedId()
  local coords = Config.CarSpawns[number].car
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
    plate = QBCore.Functions.GetPlate(veh)
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
  end, coords, true)
  ShowBlip()
  QBCore.Functions.Notify(plate, 'primary')
  TriggerEvent("CTD-Cartheft:Npc")
  TriggerServerEvent("CTD-Cartheft:setcooldown")
  TriggerEvent("CTD-Cartheft:client:playerInVehicle")
  InService = true
  IsCarRepaired = true
  TriggerEvent("CTD-Cartheft:client:RepairCar")
end)

RegisterNetEvent("CTD-Cartheft:Npc")
AddEventHandler("CTD-Cartheft:Npc", function()
  RequestModel(-449965460)
  while not HasModelLoaded(-449965460) do
      Citizen.Wait(1)
  end
  local playerCoords = GetEntityCoords(PlayerPedId())
  for i = 1, #Config.CarSpawns[number].npc do
    local _,guards = AddRelationshipGroup('enemy')
    local peds = GetEntityModel('RampGang')
    local ped = CreatePed(5, -449965460, Config.CarSpawns[number].npc[i].x, Config.CarSpawns[number].npc[i].y, Config.CarSpawns[number].npc[i].z, true, true)
    SetPedRelationshipGroupHash(ped, guards )
    Citizen.Wait(1000)
    TaskCombatPed(ped, GetPlayerPed(-1))
    SetRelationshipBetweenGroups(5, guards, GetHashKey("PLAYER"))
    SetPedCombatAttributes(ped, 0, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetPedDiesWhenInjured(ped, false)
    SetPedArmour(ped, 50)
    SetPedAlertness(ped, 1)
    SetPedAccuracy(ped, 75)
    GiveWeaponToPed(ped, "weapon_pistol", 900, false, true)
    SetPedCombatRange(ped, 0)
    SetPedDropsWeaponsWhenDead(ped, false)
  end
end)

RegisterNetEvent("CTD-Cartheft:client:RepairCar")
AddEventHandler("CTD-Cartheft:client:RepairCar", function(pedCoords)
  while IsCarRepaired do
    Citizen.Wait(0)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local distance = #(pedCoords - vector3(Config.Repair.x,Config.Repair.y,Config.Repair.z))
    if InCar() then
      if(distance < 5) then
        DrawMarker(23, Config.Repair.x, Config.Repair.y, Config.Repair.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 3.5, 144, 128, 0, 100, false, true, 2, nil, nil, false)
        DrawText3D(Config.Repair.x, Config.Repair.y, Config.Repair.z+1, "[E] Repair")
        if(distance < 2) and IsPedInAnyVehicle(PlayerPedId(), false) and IsControlJustReleased(0, 51) then
          local curVeh = QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId()))
          if(plate == curVeh) then
            TriggerEvent("CTD-Cartheft:client:RepairCarTime")
            RemoveBlip(RepairBlip)
            SetRoute()
          else
              QBCore.Functions.Notify('Wrong vehicle', 'error')
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
  IsCarRepaired = false
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
      if(distance < 5) then
        DrawMarker(23, Config.Delivery.x, Config.Delivery.y, Config.Delivery.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 3.5, 144, 128, 0, 100, false, true, 2, nil, nil, false)
        DrawText3D(Config.Delivery.x, Config.Delivery.y, Config.Delivery.z+1, "[E] DONE")
        if(distance < 2) and IsPedInAnyVehicle(PlayerPedId(), false) and IsControlJustReleased(0, 51) then
          local curVeh = QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId()))
          if plate == curVeh  then
            JobDone()
          else
              QBCore.Functions.Notify('Wrong vehicle', 'error')
          end
        end
      end
    end
  end
end)

function JobDone()
  RemoveBlip(DeliveryBlip)
  SetEntityAsNoLongerNeeded(veh)
  DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
  TriggerServerEvent("CTD-Cartheft:Payment")
  QBCore.Functions.Notify('Job Done', 'primary')
  InService = false
end

function ShowBlip()
  if Blip ~= nil then
    RemoveBlip(Blip)
  end
  Blip = AddBlipForCoord(Config.CarSpawns[number].car.x, Config.CarSpawns[number].car.y, Config.CarSpawns[number].car.z)
  SetBlipSprite(Blip, 161)
  SetBlipDisplay(Blip, 4)
  SetBlipScale(Blip, 3.0)
  SetBlipAsShortRange(Blip, true)
  SetBlipColour(Blip, 1)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName("Car")
  EndTextCommandSetBlipName(Blip)
end
