-- Scripted and configured by Injustable Customs

--- DO NOT EDIT THIS --
local Hholstered  = true
local Hblocked	 = false
local Fholstered  = true
local Fblocked	 = false
local holstered  = true
local blocked	 = false

local EUP = EUP
local enabled = true
local active = false
local ped = nil -- The hash of the current ped
local currentPedData = nil -- Config data for the current ped

local PlayerData = {}
------------------------

function table_invert(t)
  local s={}
  for k,v in pairs(t) do
    s[v]=k
  end
  return s
end

Citizen.CreateThread(function()
  while true do
    ped = GetPlayerPed(-1)
    local ped_hash = GetEntityModel(ped)
    local enable = false -- We updated the 'enabled' variable in the upper scope with this at the end
    -- Loop over peds in the config
    for EUP_ped, data in pairs(EUP.peds) do
      if GetHashKey(EUP_ped) == ped_hash then 
        enable = true -- By default, the ped will have its holsters enabled
        if data.enabled ~= nil then -- Optional 'enabled' option
          enable = data.enabled
        end
        currentPedData = data
        break
      end
    end
    active = enable
    Citizen.Wait(5000)
  end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		loadAnimDict("rcmjosh4")
		loadAnimDict("reaction@intimidation@cop@unarmed")
		loadAnimDict( "reaction@intimidation@1h" )
		loadAnimDict( "combat@combat_reactions@pistol_1h_gang" )
		loadAnimDict( "reaction@male_stand@big_variations@d" )
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped, false) then
			if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
				if CheckHWeapon(ped) then
					--if IsPedArmed(ped, 4) then
					if Hholstered then
					if active and enabled then
					for component, holsters in pairs(currentPedData.components) do
					  local holsterDrawable = GetPedDrawableVariation(ped, component) -- Current drawable of this component
					  local holsterTexture = GetPedTextureVariation(ped, component) -- Current texture, we need to preserve this
						Hblocked   = true
							SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
							TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when removing weapon
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
								Citizen.Wait(Config.cooldown)
								SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
							TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
								Citizen.Wait(400)
							ClearPedTasks(ped)
						local emptyHolster = holsters[holsterDrawable]
						SetPedComponentVariation(ped, component, emptyHolster, holsterTexture, 0)
						Hholstered = false
						end
					elseif not active and not enabled then
						Hblocked   = true
		                    rot = GetEntityHeading(ped)
							SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
								Citizen.Wait(Config.cooldown)
								SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
								Citizen.Wait(600)
							ClearPedTasks(ped)
						Hholstered = false
					end
					else
						Hblocked = false
					end
				else
				--elseif not IsPedArmed(ped, 4) then
					if not Hholstered then
					if active and enabled then
					for component, holsters in pairs(currentPedData.components) do
					  local holsterDrawable = GetPedDrawableVariation(ped, component) -- Current drawable of this component
					  local holsterTexture = GetPedTextureVariation(ped, component) -- Current texture, we need to preserve this
							TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
								Citizen.Wait(500)
							TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when holstering weapon
								Citizen.Wait(60)
							ClearPedTasks(ped)
						local filledHolster = table_invert(holsters)[holsterDrawable]
						SetPedComponentVariation(ped, component, filledHolster, holsterTexture, 0)
						Hholstered = true
						end
					elseif not active and not enabled then
		                    rot = GetEntityHeading(ped)
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
								--Citizen.Wait(500)
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when holstering weapon
								Citizen.Wait(2000)
							ClearPedTasks(ped)
						Hholstered = true
					end
					end
				end
				if CheckWeapon(ped) then
					--if IsPedArmed(ped, 4) then
					if holstered then
						blocked   = true
		                    rot = GetEntityHeading(ped)
							SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
								Citizen.Wait(Config.cooldown)
								SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
								Citizen.Wait(600)
							ClearPedTasks(ped)
						holstered = false
					else
						blocked = false
					end
				else
				--elseif not IsPedArmed(ped, 4) then
					if not holstered then
		                    rot = GetEntityHeading(ped)
							TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
								--Citizen.Wait(500)
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when holstering weapon
								Citizen.Wait(2000)
							ClearPedTasks(ped)
						holstered = true
					end
				end
				if FCheckWeapon(ped) then
					--if IsPedArmed(ped, 4) then
					if Fholstered then
						Fblocked   = true
		                    rot = GetEntityHeading(ped)
							SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
							TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
								Citizen.Wait(Config.cooldown)
								SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
								Citizen.Wait(500)
							ClearPedTasks(ped)
						Fholstered = false
					else
						Fblocked = false
					end
				else
				--elseif not IsPedArmed(ped, 4) then
					if not Fholstered then
		                    rot = GetEntityHeading(ped)
							TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
								--Citizen.Wait(500)
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when holstering weapon
								Citizen.Wait(600)
							ClearPedTasks(ped)
						Fholstered = true
					end
				end
			else
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
			end
		else
			Hholstered = true	
			holstered = true
			Fholstered = true
		end
	end
end)

--[[ Remove uncomment for Gangster Animation (!!Must uncomment previous function!!)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		loadAnimDict("reaction@intimidation@1h")
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped, false) then
			if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
				if CheckWeapon(ped) then
					--if IsPedArmed(ped, 4) then
					if holstered then
						blocked   = true
							SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
							TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 50, 0, 0, 0, 0 )
							--TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 30, 0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
								Citizen.Wait(1250)
							SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
								Citizen.Wait(Config.cooldown)
							ClearPedTasks(ped)
						holstered = false
					else
						blocked = false
					end
				else
				--elseif not IsPedArmed(ped, 4) then
					if not holstered then
						TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0.125, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
						--TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 30, 0, 0, 0.125, 0 ) Use this line if you want to stand still when holstering weapon
								Citizen.Wait(1700)
							ClearPedTasks(ped)
						holstered = true
					end
				end
			else
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
			end
		else
			holstered = true
		end
	end
end)]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if Hblocked then
			DisableControlAction(1, 25, true )
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
		end
		if blocked then
			DisableControlAction(1, 25, true )
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
		end
		if Fblocked then
			DisableControlAction(1, 25, true )
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
		end
	end
end)

function CheckHWeapon(ped)
	--[[if IsPedArmed(ped, 4) then
		return true
	end]]
	if IsEntityDead(ped) then
		Hblocked = false
			return false
		else
			for i = 1, #Config.HWeapons do
				if GetHashKey(Config.HWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function CheckWeapon(ped)
	--[[if IsPedArmed(ped, 4) then
		return true
	end]]
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #Config.Weapons do
				if GetHashKey(Config.Weapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function FCheckWeapon(ped)
	--[[if IsPedArmed(ped, 4) then
		return true
	end]]
	if IsEntityDead(ped) then
		Fblocked = false
			return false
		else
			for i = 1, #Config.FWeapons do
				if GetHashKey(Config.FWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end