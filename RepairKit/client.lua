ESX = exports["es_extended"]:getSharedObject()
CayoPericoCoords = vector3(3668.4204, -4400.0000, -1.0405)
Busy = false

exports.ox_target:addGlobalVehicle({
	{
		name = 'repair_kit',
		icon = 'fa-solid fa-wrench',
		offset = vec3(0.5, 1, 0.5),
		label = Config.RepairVehicle,
		canInteract = function(entity) 
			if exports.ox_inventory:GetItemCount(Config.RepairKitItem) > 0 and GetVehicleEngineHealth(entity) <= 600 then
				return true
			end
			return false
			 
		  end,
		onSelect = function(data)
			Repair(data.entity)
		end,
		distance = 2.5
	},
	{
		name = 'banden_kit',
		icon = 'fa-solid fa-screwdriver',
		label = Config.RepairTyre,
		canInteract = function(entity) 
			local coords = GetEntityCoords(PlayerPedId())
			if not Config.UseTyreKit then
				return false
			end
			if #(coords - CayoPericoCoords) < 1000 and Config.CayoPericoFix then
				return false
			end
			heeftBandenSet = false
			local voertuigclass = GetVehicleClass(entity)
			local bandhp = {
				b1 = GetTyreHealth(entity, 0), -- links voor / motor voor
				b2 = GetTyreHealth(entity, 1), -- rechts voor
				b3 = GetTyreHealth(entity, 4), -- links achter / motor achter
				b4 = GetTyreHealth(entity, 5) -- rechts achter
			}
			if exports.ox_inventory:GetItemCount(Config.TyreItem) and GetVehicleEngineHealth(entity) > 0 then
				if bandhp.b1 <= 361 or bandhp.b2 <= 361 or bandhp.b3 <= 361 or bandhp.b4 <= 361 then
					heeftBandenSet = true
				end
			end
			return heeftBandenSet
			 
		  end,
		onSelect = function(data)
			RepairTyre(data.entity)
		end,
		distance = 2.5
	},
  })

  
 


function Repair(Vehicle)
	local Player = PlayerPedId()
	if GetVehicleEngineHealth(Vehicle) <= 600 then
		Busy = true
		TaskStartScenarioInPlace(Player, "PROP_HUMAN_BUM_BIN", 0, true)
		SetVehicleDoorOpen(Vehicle, 4)
		if lib.progressCircle({
			duration = math.random(Config.MinRepairTime * 1000, Config.MaxRepairTime * 1000),
			position = 'bottom',
			useWhileDead = false,
			canCancel = true,
			disable = {
				car = true,
			},
		}) then 
			Busy = false
			local Coords = GetEntityCoords(Player)
			if (#(Coords - CayoPericoCoords) < 1000 and Config.CayoPericoFix) or Config.FullyFix then
				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)
			else
				exports["voertuig_failure"]:setEngineHealth(Vehicle, Config.RepairedHealth)
				if not Config.UseTyreKit then
					SetVehicleTyreFixed(Vehicle, 0)
					SetVehicleTyreFixed(Vehicle, 1)
					SetVehicleTyreFixed(Vehicle, 4)
					SetVehicleTyreFixed(Vehicle, 5)
				end
			end
			ClearPedTasksImmediately(Player)
			TriggerServerEvent('RepairKit:RemoveRepairKit')
			ESX.ShowNotification(Config.RepairedVehicle)
		  else ClearPedTasks(Player) Busy = false end
		  SetVehicleDoorShut(Vehicle, 4)
	else
		ESX.ShowNotification(Config.NotBroken)
	end
end


function RepairTyre(Vehicle)
	local Player = PlayerPedId()
	Busy = true
		TaskStartScenarioInPlace(Player, "PROP_HUMAN_BUM_BIN", 0, true)
		if lib.progressCircle({
			duration = math.random(Config.MinTyreRepairTime * 1000, Config.MaxTyreRepairTime * 1000),
			position = 'bottom',
			useWhileDead = false,
			canCancel = true,
			disable = {
				car = true,
			},
		}) then 
			Busy = false
			local coords = GetEntityCoords(PlayerPedId())
			SetVehicleTyreFixed(Vehicle, 0)
			SetVehicleTyreFixed(Vehicle, 1)
			SetVehicleTyreFixed(Vehicle, 4)
			SetVehicleTyreFixed(Vehicle, 5)
			ClearPedTasksImmediately(Player)
			TriggerServerEvent('RepairKit:RemoveTyre')
			ESX.ShowNotification(Config.RepairedTyre)
		  else ClearPedTasks(Player) Busy = false end
end

Citizen.CreateThread(function()
	while true do
		Wait(50)
		if Busy then
			if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
				TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", -1, true)
			end
			ESX.ShowHelpNotification(Config.CancelRepair)
		else
			Wait(500)
		end
	end
end)
