local cuInd = [[|TInterface\MoneyFrame\UI-CopperIcon:0:1:2:0|t]]
local agInd = [[|TInterface\MoneyFrame\UI-SilverIcon:0:1:2:0|t]]
local auInd = [[|TInterface\MoneyFrame\UI-GoldIcon:0:1:2:0|t]]

local function MoneyToString(ammount)
	local cu = ammount % 100
	ammount = floor(ammount / 100)
	local ag, au = ammount % 100, floor(ammount / 100)
	if au > 0 then
		return au .. auInd .. ag .. agInd .. cu .. cuInd
	elseif ag > 0 then
		return ag .. agInd .. cu .. cuInd
	end
	return cu .. cuInd
end

local function Sell()
	local total, bag, slot = 0
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 0, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link then
				local _, _, itemRarity, _, _, _, _, _, _, _, itemSellPrice = GetItemInfo(link)
				local _, itemCount = GetContainerItemInfo(bag, slot)
				if itemRarity == 0 and itemSellPrice ~= 0 then
					UseContainerItem(bag, slot)
					total = total + itemSellPrice * itemCount
				end
			end
		end
	end
	if total > 0 then
		print(format('|cfff07100 + %s (Trash)|r', MoneyToString(total)))
	end
end

local function Repair()
	if CanMerchantRepair() then
		local cost = GetRepairAllCost()
		if cost > 0 then
			if IsInGuild() then
				local guildMoney = GetGuildBankWithdrawMoney()
				if guildMoney > GetGuildBankMoney() then
					guildMoney = GetGuildBankMoney()
				end
				if guildMoney > cost and CanGuildBankRepair() then
					RepairAllItems(1)
					print(format('|cfff07100 - %s (Repair, Guild)|r', MoneyToString(cost)))
					return
				end
			end 
			if GetMoney() > cost then
				RepairAllItems()
				print(format('|cfff07100 - %s (Repair)|r', MoneyToString(cost)))
			else
				print('|cfff07100No money to repair.|r')
			end
		end
	end
end

OnEvent('MERCHANT_SHOW', function()
	Sell()
	Repair()
end)