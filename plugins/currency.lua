local token = {390,392,396,395,402,752,776}
local GetCurrencyInfo, select, tip = GetCurrencyInfo, select, GameTooltip

local function OnEvent(self)
	for i = 1, #token do
		self[i].text:SetText(select(2,GetCurrencyInfo(token[i])))
	end
end

local tokens = CreateFrame('Frame')
	tokens:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
	tokens:SetScript('OnEvent', OnEvent)

local function OnEnter(self)
	tip:ClearLines()
	tip:SetOwner(self, 'ANCHOR_LEFT')
	tip:SetHyperlink(self.link)
	tip:Show()
end

for i = 1, #token do
	local id = token[i]
	local t = CreateFrame('Frame', nil, Minimap)
		t:SetPoint('TOPRIGHT', Minimap, 'BOTTOMRIGHT', 0, -20*(i-1)-32)
		t:SetSize(12, 12)
		t.texture = t:CreateTexture(nil, 'ARTWORK')
		t.texture:SetAllPoints(t)
		t.texture:SetTexCoord(.1, .9, .1, .9)
		t.shadow = t:CreateTexture(nil, 'BACKGROUND')
		t.shadow:SetPoint('CENTER', t)
		t.shadow:SetSize(20, 20)
		t.shadow:SetVertexColor(0, 0, 0, .7)
		t.shadow:SetTexture('Interface\\AddOns\\ConceptionUI\\media\\texture\\buttonShadow')
		t.text = t:CreateFontString()
		t.text:SetPoint('RIGHT', t, 'LEFT', -4, 1)
		t.text:SetFont('Interface\\AddOns\\ConceptionUI\\media\\fonts\\pixel.ttf', 10)
		t.text:SetShadowOffset(1, 1)
		t.text:SetShadowColor(0, 0, 0, .7)
		t.link = '|Hcurrency:'..id
		t.texture:SetTexture(select(3,GetCurrencyInfo(id)))
		t:SetScript('OnEnter', OnEnter)
		t:SetScript('OnLeave', GameTooltip_Hide)
		tokens[i] = t
end


WatchFrame:SetClampedToScreen(true)
WatchFrame:SetHeight(500)
WatchFrame:SetScale(.8)
WatchFrame:ClearAllPoints() 
WatchFrame.ClearAllPoints = function() end
WatchFrame:SetPoint('TOPRIGHT', tokens[1], 'TOPRIGHT', -100, 0)
WatchFrame.SetPoint = function() end