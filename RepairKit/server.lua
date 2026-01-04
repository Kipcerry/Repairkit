RegisterNetEvent('RepairKit:RemoveRepairKit')
AddEventHandler('RepairKit:RemoveRepairKit', function()
	local _source = source
	Durability = 100.0
	local Slot = exports.ox_inventory:GetSlotIdWithItem(_source, Config.RepairKitItem)
	local PlayerItems = exports.ox_inventory:GetInventoryItems(_source)
	for k, v in pairs(PlayerItems) do
		if Slot == v.slot then
			Durability = v.metadata.durability
		end
	end
	local NewDurability = Durability - math.random(Config.MinRepairDamage, Config.MaxRepairDamage)
	
	if NewDurability > 0 then
		exports.ox_inventory:SetDurability(_source, Slot, NewDurability)
	else
		exports.ox_inventory:RemoveItem(_source, Config.RepairKitItem, 1)
	end
end)

RegisterNetEvent('RepairKit:RemoveTyre')
AddEventHandler('RepairKit:RemoveTyre', function()
	local _source = source
	Durability = 100.0
	local Slot = exports.ox_inventory:GetSlotIdWithItem(_source, Config.TyreItem)
	local PlayerItems = exports.ox_inventory:GetInventoryItems(_source)
	for k, v in pairs(PlayerItems) do
		if Slot == v.slot then
			Durability = v.metadata.durability
		end
	end
	local NewDurability = Durability - 25

	if NewDurability > 0 then
		exports.ox_inventory:SetDurability(_source, Slot, NewDurability)
	else
		exports.ox_inventory:RemoveItem(_source, Config.TyreItem, 1)
	end
end)
