local QBCore = exports['qb-core']:GetCoreObject()

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function OpenMenu()
    exports['qb-menu']:openMenu({
      {
        header = "Car Theft",
        isMenuHeader = true,
      },
      {
        header = "Start The Job",
        txt = "",
        params = {
          event = 'CTD-Cartheft:client:Test',
        }
      },
      {
        header = "close",
        txt = "this close's the menu",
        params = {
            event = "qb-menu:closeMenu"
        }
    },
})
end

function SetRoute()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end

    DeliveryBlip = AddBlipForCoord(Config.Delivery.x, Config.Delivery.y, Config.Delivery.z)
    SetBlipSprite(DeliveryBlip, 1)
    SetBlipDisplay(DeliveryBlip, 2)
    SetBlipScale(DeliveryBlip, 1.0)
    SetBlipAsShortRange(DeliveryBlip, false)
    SetBlipColour(DeliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Delivery")
    EndTextCommandSetBlipName(DeliveryBlip)
    SetBlipRoute(DeliveryBlip, true)
end

function SetRoute1()
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)

  if RepairBlip ~= nil then
      RemoveBlip(RepairBlip)
  end

  RepairBlip = AddBlipForCoord(Config.Repair.x, Config.Repair.y, Config.Repair.z)
  SetBlipSprite(RepairBlip, 1)
  SetBlipDisplay(RepairBlip, 2)
  SetBlipScale(RepairBlip, 1.0)
  SetBlipAsShortRange(RepairBlip, false)
  SetBlipColour(RepairBlip, 27)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName("Repair")
  EndTextCommandSetBlipName(RepairBlip)
  SetBlipRoute(RepairBlip, true)
  QBCore.Functions.Notify('Follow gps for next step', 'primary')
end

function ShowBlip()
    if Blip ~= nil then
      RemoveBlip(Blip)
  end
  Blip = AddBlipForCoord(Config.spawner.x, Config.spawner.y, Config.spawner.z)
        SetBlipSprite(Blip, 161)
        SetBlipDisplay(Blip, 4)
        SetBlipScale(Blip, 3.0)
        SetBlipAsShortRange(Blip, true)
        SetBlipColour(Blip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Car")
        EndTextCommandSetBlipName(Blip)
end

function InCar()
  local ped = PlayerPedId()
  local veh = GetEntityModel(GetVehiclePedIsIn(ped))
  local retval = false

  for i = 1, #Config.Vehicles, 1 do
      if veh == GetHashKey(Config.Vehicles[i].model) then
          retval = true
      end
  end
  return retval
end
