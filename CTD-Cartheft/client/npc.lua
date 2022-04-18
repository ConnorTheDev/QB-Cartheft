RegisterNetEvent("CTD-Cartheft:Npc")
AddEventHandler("CTD-Cartheft:Npc", function()
    RequestModel(-449965460)
    while not HasModelLoaded(-449965460) do
        Citizen.Wait(1)
    end
    playerCoords = GetEntityCoords(PlayerPedId())
    for i = 1, #npc, 1 do
      local _,guards = AddRelationshipGroup('enemy') 
      peds = GetEntityModel('RampGang')
      ped = CreatePed(5, -449965460, npc[i].x, npc[i].y, npc[i].z, true, true) 
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

npc = {
  [1] = vector3(795.9, -2917.23, 5.88),
  [2] = vector3(795.36, -2905.78, 5.9),
  [3] = vector3(803.88, -2917.44, 5.9),
  [4] = vector3(806.44, -2906.5, 5.9),
  [5] = vector3(809.45, -2912.83, 5.9),
}
