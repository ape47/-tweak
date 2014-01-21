-->ILV
local levelAdjust={
	['0']=0,['1']=8,
	['373']=4,['374']=8,
	['375']=4,['376']=4,['377']=4,['379']=4,['380']=4,
	['445']=0,['446']=4,['447']=8,
	['451']=0,['452']=8,
	['453']=0,['454']=4,['455']=8,
	['456']=0,['466']=4,['457']=8,
	['458']=0,['459']=4,['460']=8,['461']=12,['462']=16,
	['465']=0,['467']=8,
	['468']=0,['470']=8,['471']=12,['472']=16,
	['476']=0,['479']=0,
	['491']=0,['492']=4,['493']=8,
	['494']=0,['495']=4,['496']=8,['497']=12,['498']=16
}

local slot = {'Head','Neck','Shoulder','Shirt','Chest','Waist','Legs','Feet','Wrist','Hands','Finger0','Finger1','Trinket0','Trinket1','Back','MainHand','SecondaryHand','Tabard'}

local function CreateText(frame, ...)
	local f = _G[frame]
	f.ilv = f:CreateFontString(nil, 'OVERLAY')
	f.ilv:SetFont(STANDARD_TEXT_FONT, 10, 'OUTLINE')
	f.ilv:SetJustifyH('RIGHT')
	f.ilv:SetPoint(...)
	if frame:match('Character.*Slot') or frame:match('EquipmentFlyoutFrameButton%d') then
		f.durability = f:CreateFontString(nil, 'OVERLAY')
		f.durability:SetFont(STANDARD_TEXT_FONT, 10, 'OUTLINE')
		f.durability:SetJustifyH('LEFT')
		f.durability:SetPoint('TOPLEFT')
	end
end

CreateText('CharacterModelFrame', 'TOPRIGHT', 0, -2)
for _, v in pairs(slot) do
	CreateText('Character'..v..'Slot', 'BOTTOMRIGHT')
end

local function GetActualItemLevel(link, baseLevel)
	local upgrade = link:match(':(%d+)\124h%[')
	if not upgrade then return baseLevel end
	if not levelAdjust[upgrade] then print(link, upgrade, 'NOT IN UPGRADE DATABASE!!') end
	return baseLevel + (levelAdjust[upgrade] or 0)
end

local GradientColor = function(percent)
	return percent <= 50 and .618 or .00618 * (100 - percent), percent >= 50 and .618 or .00618 * percent, 0
end

local function CheckInventoryItem(unit, frame)
	if unit then
		local total, count = 0, 0
		for slot, name in pairs(slot) do
			local f = _G[frame..name..'Slot']
			if not f.hasItem then
				if f.ilv then f.ilv:SetText(nil) end
				if f.durability then f.durability:SetText(nil) end
			else
				local itemLink = GetInventoryItemLink(unit, slot)
				if itemLink then
					local _, _, itemQuality, baseLevel = GetItemInfo(itemLink)
					local itemLevel = GetActualItemLevel(itemLink, baseLevel)
					f.ilv:SetText(itemLevel)
					f.ilv:SetTextColor(GetItemQualityColor(itemQuality))
					if name ~= 'Shirt' and name ~= 'Tabard' then
						total = itemLevel + total
						count = count + 1
					end
				end
				if frame == 'Character' then
					local durability, max = GetInventoryItemDurability(slot)
					if durability then
						durability = 100*durability/max
						f.durability:SetFormattedText('%d%%', durability)
						f.durability:SetTextColor(GradientColor(durability))
					end
				end
			end
		end
		_G[frame..'ModelFrame'].ilv:SetFormattedText('%s/%s=%.1f\nupgrade:%s', total, count, total/count, floor(total/count+1)*count-total)
	end
end

CharacterFrame:HookScript('OnShow', function(self)
	CheckInventoryItem('player', 'Character')
	self:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
	self:RegisterEvent('PLAYER_DEAD')
	self:RegisterEvent('UPDATE_INVENTORY_DURABILITY')
	self:RegisterEvent('ITEM_UPGRADE_MASTER_UPDATE')
end)

CharacterFrame:HookScript('OnHide', function(self)
	self:UnregisterEvent('PLAYER_EQUIPMENT_CHANGED')
	self:UnregisterEvent('PLAYER_DEAD')
	self:UnregisterEvent('UPDATE_INVENTORY_DURABILITY')
end)

CharacterFrame:HookScript('OnEvent', function(self, event)
	CheckInventoryItem('player', 'Character')
end)


-->InspectUI
LoadAddOn('Blizzard_InspectUI')
CreateText('InspectModelFrame', 'TOPRIGHT', 0, -2)
for _, v in pairs(slot) do
	CreateText('Inspect'..v..'Slot', 'BOTTOMRIGHT')
end
InspectFrame:HookScript('OnEvent', function(self, event)
	if not self:IsShown() then return end
	CheckInventoryItem(InspectFrame.unit, 'Inspect')
end)
InspectFrame:HookScript('OnHide', function()
	for _, v in pairs(slot) do
		_G['Inspect'..v..'Slot'].ilv:SetText()
	end
end)


-->PaperDollFrameItemFlyout
local function CheckFlyoutItem(self)
	local player, bank, bags, voidStorage, slot, bag = EquipmentManager_UnpackLocation(self.location)
	if voidStorage then
		self.ilv:SetText(nil)
		self.durability:SetText(nil)
		return
	end
	local itemLink = bags and GetContainerItemLink(bag, slot) or GetInventoryItemLink('player', slot)
	if itemLink then
		local _, _, itemQuality, baseLevel = GetItemInfo(itemLink)
		self.ilv:SetText(GetActualItemLevel(itemLink, baseLevel))
		self.ilv:SetTextColor(GetItemQualityColor(itemQuality))
		local durability, max = nil, nil
		if bags then
			durability, max = GetContainerItemDurability(bag, slot)
		else
			durability, max = GetInventoryItemDurability(slot)
		end
		if durability then
			durability = 100*durability/max
			self.durability:SetFormattedText('%d%%', durability)
			self.durability:SetTextColor(GradientColor(durability))
			return
		else
			self.durability:SetText(nil)
		end
	end
end

EquipmentFlyoutFrame:HookScript('OnUpdate', function(self)
	local buttons = self.buttons
	for i = 1, #buttons do
		if not buttons[i].ilv then
			CreateText(buttons[i]:GetName(), 'BOTTOMRIGHT')
		else
			CheckFlyoutItem(buttons[i])
		end
	end
end)


-->CHECK BOX
CharacterHeadSlot.checkbutton = CreateFrame('CheckButton', 'CharacterHeadSlotCheckButton', CharacterHeadSlot, 'UICheckButtonTemplate')
CharacterHeadSlot.checkbutton:SetPoint('BOTTOMLEFT', CharacterHeadSlot, 'BOTTOMRIGHT', 0, -7)
CharacterHeadSlot.checkbutton:SetScript('OnShow', function(self) self:SetChecked(ShowingHelm()) end)
CharacterHeadSlot.checkbutton:SetScript('OnClick', function() ShowHelm(not ShowingHelm()) end)

CharacterBackSlot.checkbutton = CreateFrame('CheckButton', 'CharacterBackSlotCheckButton', CharacterBackSlot, 'UICheckButtonTemplate')
CharacterBackSlot.checkbutton:SetPoint('BOTTOMLEFT', CharacterBackSlot, 'BOTTOMRIGHT', 0, -7)
CharacterBackSlot.checkbutton:SetScript('OnShow', function(self) self:SetChecked(ShowingCloak()) end)
CharacterBackSlot.checkbutton:SetScript('OnClick', function() ShowCloak(not ShowingCloak()) end)