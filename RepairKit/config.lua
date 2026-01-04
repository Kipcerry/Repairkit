Config = {}

Config.UseTyreKit = true --If true repair kits will not fix tyres you will need to use 1 tyre kit for each flat tyre
Config.CayoPericoFix = true -- If true when the vehicle is on cayo perico it will fully fix including tyres
Config.FullyFix = false -- If true repairkit will fully fix the vehicle
Config.RepairKitItem = 'repairkit'
Config.TyreItem = 'tyre'
Config.MinRepairDamage = 20 --Minible damage to repair kit after use
Config.MaxRepairDamage = 60 --Maxible damage to repair kit after use
Config.MinRepairTime = 25 -- Minible repair time in seconds
Config.MaxRepairTime = 40 -- Maxible repair time in seconds
Config.MinTyreRepairTime = 20 -- Minible repair time in seconds
Config.MaxTyreRepairTime = 30 -- Maxible repair time in seconds
Config.RepairedHealth = 500 -- 1000 = fully fixed(not tyres) 500 = drivable

--Locals
Config.RepairVehicle = 'Repair this vehicle.'
Config.RepairTyre = 'Replace this tyre'
Config.RepairedVehicle = 'You have repaired this vehicle'
Config.RepairedTyre = 'You have replaced this tyre'
Config.NotBroken = 'This vehicle is not damaged enough to be repaired'
Config.CancelRepair = 'Press ~INPUT_VEH_DUCK~ to stop repairing the vehicle'

-- Add this to your item.lua in ox_inventory values can be adjusted, just make sure the durability is on there
--[[
    ['repairkit'] = {
		label = 'Repair kit',
		durability = 100.0,
		weight = 1500,
		stack = false
	},
	['tyre'] = {
		label = 'Tyre',
		weight = 1500,
		durability = 100.0,
		stack = false
	},
]]