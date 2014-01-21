PetBattleFrame.BottomFrame.TurnTimer.SkipButton.HotKey = PetBattleFrame.BottomFrame.TurnTimer.SkipButton:CreateFontString(nil,"OVERLAY","NumberFontNormalSmallGray")
PetBattleFrame.BottomFrame.TurnTimer.SkipButton.HotKey:SetPoint("TOPRIGHT",-1,-2)

local function UpdateHotKey(self)
	self.BottomFrame.TurnTimer.SkipButton.HotKey:SetText(GetBindingKey("ACTIONBUTTON12"))
	self.BottomFrame.ForfeitButton.HotKey:SetText(GetBindingKey("ACTIONBUTTON6"))
	self.BottomFrame.ForfeitButton.HotKey:Show()
end
hooksecurefunc('PetBattleFrame_UpdateAbilityButtonHotKeys', UpdateHotKey)



local BUTTON = {
	[6] = PetBattleFrame.BottomFrame.ForfeitButton,
	[12] = PetBattleFrame.BottomFrame.TurnTimer.SkipButton
}

local function ClickButton(id)
	return BUTTON[id] and BUTTON[id]:Click()
end
hooksecurefunc('PetBattleFrame_ButtonDown', ClickButton)