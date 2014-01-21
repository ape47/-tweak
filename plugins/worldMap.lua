WorldMapFrame.Position = WorldMapFrame:CreateFontString(nil, 'OVERLAY')
WorldMapFrame.Position:SetFont(STANDARD_TEXT_FONT, 12, 'THINOUTLINE')
WorldMapFrame.Position:SetPoint('BOTTOM', WorldMapPositioningGuide, 'BOTTOM', 0, 10)
WorldMapFrame.Clock = WorldMapFrame:CreateFontString(nil, 'OVERLAY')
WorldMapFrame.Clock:SetFont(DAMAGE_TEXT_FONT, 24, 'OUTLINE')
WorldMapFrame.Clock:SetPoint('BOTTOM', WorldMapPositioningGuide, 'TOP', 0, 12)
WorldMapFrame.Date = WorldMapFrame:CreateFontString(nil, 'OVERLAY')
WorldMapFrame.Date:SetFont(DAMAGE_TEXT_FONT, 12, 'OUTLINE')
WorldMapFrame.Date:SetPoint('BOTTOM', WorldMapFrame.Clock, 'TOP', 0, 12)

local function GetCoordinate()
	local x, y = GetPlayerMapPosition('player')
	if x == 0 and y == 0 then
		return
	else
		return ('%.2f , %.2f'):format(100*x, 100*y)
	end
end

local function OnUpdate(self)
	self.Position:SetText(GetCoordinate())
	self.Clock:SetFormattedText('%.2d:%.2d', GetGameTime())
	self.Date:SetText(date('%A, %b %d'))
end
WorldMapFrame:HookScript('OnUpdate', OnUpdate)



local function SetMap(self)
	self:SetScale(.83)
	BlackoutWorld:Hide()
end
hooksecurefunc(WorldMapFrame, "Show", SetMap)



local ROLE = {
	['DAMAGER'] = '|c%s%s|r|TInterface/LFGFRAME/LFGROLE:0:0:0:0:64:16:17:32:1:16|t',
	['TANK']    = '|c%s%s|r|TInterface/LFGFRAME/LFGROLE:0:0:0:0:64:16:33:48:1:16|t',
	['HEALER']  = '|c%s%s|r|TInterface/LFGFRAME/LFGROLE:0:0:0:0:64:16:49:64:1:16|t',
	['NONE']    = '|c%s%s|r'
}

local function SetName(self)
		self:SetSize(10, 10)
		if not UnitExists(self.unit) then return end
		if not self.unitname then
			 self.unitname = self:CreateFontString(nil, 'OVERLAY')
			 self.unitname:SetFont(STANDARD_TEXT_FONT, 10, 'THINOUTLINE')
			 self.unitname:SetPoint('LEFT', self.icon, 'RIGHT')
		end
		local colorStr = '00000000'
		local _, class = UnitClass(self.unit)
		if class then colorStr = RAID_CLASS_COLORS[class].colorStr end
		self.unitname:SetFormattedText(ROLE[UnitGroupRolesAssigned(self.unit)], colorStr, UnitName(self.unit))
end

local FRAME = 'WorldMap%s%d'
local function CheckName()
	for i = 1, 4 do
		SetName(_G[FRAME:format('Party', i)])
	end
	for i = 1, 40 do
		SetName(_G[FRAME:format('Raid', i)])
	end
end
hooksecurefunc('WorldMapFrame_UpdateUnits', CheckName)