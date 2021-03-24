ESX = nil
local working = false
local animation = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local pedcoords = GetEntityCoords(PlayerPedId())
        local spind1 = GetDistanceBetweenCoords(pedcoords, Config.Locations.spind1.x, Config.Locations.spind1.y, Config.Locations.spind1.z, true)
        if spind1 <= 6 then
            if spind1 <= 1.5 and IsControlJustReleased(0, 38) then   
                local playerPed = PlayerPedId()
                ESX.TriggerServerCallback('poggers:brecheisen', function(item)
                if item then
                    loadAnimDict("missheist_jewel") 
                    SetEntityCoords(GetPlayerPed(-1), -1098.84,-830.59,14.28-0.95)
					SetEntityHeading(GetPlayerPed(-1), 309.55)
                    exports['progressBars']:startUI(5000, "")
                    working = true
                    animation = true
                    TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false) 
                    Citizen.Wait(5000)
                    working = false
                    animation = false
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    --TriggerEvent("notifications", "#34AD00", "", "Du hast den Spind aufgebrochen, und eine Officer Kleidung genommen.")
                    TriggerServerEvent("cv_stealpdclothe:getrandom")
                else
                    TriggerEvent("notifications", "#eb4034", "", "Du hast kein Werkzeug, um den Spind aufzubrechen")
                end
			end)
            end
        end
    end
end)

Citizen.CreateThread(function()
      
	while true do
		Wait(1)
		if animation == true then
            loadAnimDict( "missheist_jewel" ) 
			if not IsEntityPlayingAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 3) then
				TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if working then
			--DisableControlAction(0, 1, true) -- Disable pan
			--DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 68, true) -- Veh Aim
			DisableControlAction(0, 69, true) -- Veh Attack
			DisableControlAction(0, 70, true) -- Veh Attack 2
			DisableControlAction(0, 91, true) -- Veh Passanger Aim
			DisableControlAction(0, 92, true) -- Veh Passanger Attack
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 73, true) -- Hände hoch nehmen
		--[[DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true)]] -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			--DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			--DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			--DisableControlAction(0, 75, true)  -- Disable exit vehicle
			--DisableControlAction(27, 75, true) -- Disable exit vehicle
			EnableControlAction(0, 75, true)  -- Disable exit vehicle
			EnableControlAction(27, 75, true) -- Disable exit vehicle
			EnableControlAction(0, 23, true)
			DisableControlAction(0, 20, true)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('cv_stealpdclothe:roddyRemoval')
AddEventHandler('cv_stealpdclothe:roddyRemoval', function()
  local playerPed = GetPlayerPed(-1)
  local player2Ped = PlayerPedId()
  TriggerEvent("cv_stealpdclothe:ShirtAnimation")
  Wait(1500)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:PantsAnimation")
  Wait(1300)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:ShoesAnimation")
  Wait(1200)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:ShoesAnimation")
  Wait(1200)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent('skinchanger:getSkin', function(skin)
	if skin.sex == 0 then
		if Config.Uniforms.officer_wear.male then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.officer_wear.male)
		else
			ESX.ShowNotification(_U('no_outfit'))
		end

		if job == 'officer_wear' then
			SetPedArmour(player2Ped, 100)
		end
	else
		if Config.Uniforms.officer_wear.female then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.officer_wear.female)
		else
			ESX.ShowNotification(_U('no_outfit'))
		end

		if job == 'officer_wear' then
			SetPedArmour(player2Ped, 100)
		end
	end
end)
end)

RegisterNetEvent('cv_stealpdclothe:roddyRemoval2')
AddEventHandler('cv_stealpdclothe:roddyRemoval2', function()
  local playerPed = GetPlayerPed(-1)
  local player2Ped = PlayerPedId()
  TriggerEvent("cv_stealpdclothe:ShirtAnimation")
  Wait(1500)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:PantsAnimation")
  Wait(1300)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:ShoesAnimation")
  Wait(1200)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:ShoesAnimation")
  Wait(1200)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent('skinchanger:getSkin', function(skin)
	if skin.sex == 0 then
		if Config.Uniforms.detectiveii_wear.male then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.detectiveii_wear.male)
		else
			ESX.ShowNotification(_U('no_outfit'))
		end

		if job == 'detectiveii_wear' then
			SetPedArmour(player2Ped, 100)
		end
	else
		if Config.Uniforms.detectiveii_wear.female then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.detectiveii_wear.female)
		else
			ESX.ShowNotification(_U('no_outfit'))
		end

		if job == 'detectiveii_wear' then
			SetPedArmour(player2Ped, 100)
		end
	end
end)
end)

RegisterNetEvent('cv_stealpdclothe:roddyRemoval3')
AddEventHandler('cv_stealpdclothe:roddyRemoval3', function()
  local playerPed = GetPlayerPed(-1)
  local player2Ped = PlayerPedId()
  TriggerEvent("cv_stealpdclothe:ShirtAnimation")
  Wait(1500)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:PantsAnimation")
  Wait(1300)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:ShoesAnimation")
  Wait(1200)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:ShoesAnimation")
  Wait(1200)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent('skinchanger:getSkin', function(skin)
	if skin.sex == 0 then
		if Config.Uniforms.sergeant_wear.male then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.sergeant_wear.male)
		else
			ESX.ShowNotification(_U('no_outfit'))
		end

		if job == 'sergeant_wear' then
			SetPedArmour(player2Ped, 100)
		end
	else
		if Config.Uniforms.sergeant_wear.female then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.sergeant_wear.female)
		else
			ESX.ShowNotification(_U('no_outfit'))
		end

		if job == 'sergeant_wear' then
			SetPedArmour(player2Ped, 100)
		end
	end
end)
end)

RegisterNetEvent('cv_stealpdclothe:roddyRemoval4')
AddEventHandler('cv_stealpdclothe:roddyRemoval4', function()
  local playerPed = GetPlayerPed(-1)
  local player2Ped = PlayerPedId()
  TriggerEvent("cv_stealpdclothe:ShirtAnimation")
  Wait(1500)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:PantsAnimation")
  Wait(1300)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:ShoesAnimation")
  Wait(1200)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent("cv_stealpdclothe:ShoesAnimation")
  Wait(1200)
  TriggerEvent("cv_stealpdclothe:CancelAnimation", source)
  TriggerEvent('skinchanger:getSkin', function(skin)
	if skin.sex == 0 then
		if Config.Uniforms.officeriii_wear.male then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.officeriii_wear.male)
		else
			ESX.ShowNotification(_U('no_outfit'))
		end

		if job == 'officeriii_wear' then
			SetPedArmour(player2Ped, 100)
		end
	else
		if Config.Uniforms.officeriii_wear.female then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.officeriii_wear.female)
		else
			ESX.ShowNotification(_U('no_outfit'))
		end

		if job == 'officeriii_wear' then
			SetPedArmour(player2Ped, 100)
		end
	end
end)
end)

RegisterNetEvent('cv_stealpdclothe:CancelAnimation')
AddEventHandler('cv_stealpdclothe:CancelAnimation', function()
local ped = GetPlayerPed(-1)
  ClearPedTasks(ped)
  FreezeEntityPosition(ped,false)
end)

RegisterNetEvent('cv_stealpdclothe:ShirtAnimation')
AddEventHandler('cv_stealpdclothe:ShirtAnimation', function()
local ped = GetPlayerPed(-1)
local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
  if not IsEntityPlayingAnim(ped, "clothingtie", "try_tie_positive_a", 3) then
  FreezeEntityPosition(ped,true)
    RequestAnimDict("clothingtie")
      while not HasAnimDictLoaded("clothingtie") do
        Citizen.Wait(100)
      end
    TaskPlayAnim(ped, "clothingtie", "try_tie_positive_a", 8.0, -8, -1, 49, 0, 0, 0, 0)
  end
end)

RegisterNetEvent('cv_stealpdclothe:PantsAnimation')
AddEventHandler('cv_stealpdclothe:PantsAnimation', function()
local ped = GetPlayerPed(-1)
local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
  if not IsEntityPlayingAnim(ped, "re@construction", "out_of_breath", 3) then
  FreezeEntityPosition(ped,true)
    RequestAnimDict("re@construction")
      while not HasAnimDictLoaded("re@construction") do
        Citizen.Wait(100)
      end
    TaskPlayAnim(ped, "re@construction", "out_of_breath", 8.0, -8, -1, 49, 0, 0, 0, 0)
  end
end)

RegisterNetEvent('cv_stealpdclothe:ShoesAnimation')
AddEventHandler('cv_stealpdclothe:ShoesAnimation', function()
local ped = GetPlayerPed(-1)
local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
  if not IsEntityPlayingAnim(ped, "random@domestic", "pickup_low", 3) then
  FreezeEntityPosition(ped,true)
    RequestAnimDict("random@domestic")
      while not HasAnimDictLoaded("random@domestic") do
        Citizen.Wait(100)
      end
    TaskPlayAnim(ped, "random@domestic", "pickup_low", 8.0, -8, -1, 49, 0, 0, 0, 0)
  end
end)

RegisterNetEvent('cv_stealpdclothe:MaskAnimation')
AddEventHandler('cv_stealpdclothe:MaskAnimation', function()
local ped = GetPlayerPed(-1)
local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
  if not IsEntityPlayingAnim(ped, "mp_masks@standard_car@ds@", "put_on_mask", 3) then
  FreezeEntityPosition(ped,true)
    RequestAnimDict("mp_masks@standard_car@ds@")
      while not HasAnimDictLoaded("mp_masks@standard_car@ds@") do
        Citizen.Wait(100)
      end
    TaskPlayAnim(ped, "mp_masks@standard_car@ds@", "put_on_mask", 8.0, -8, -1, 49, 0, 0, 0, 0)
  end
end)

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 