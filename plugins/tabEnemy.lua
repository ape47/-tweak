
local function OnEvent()
	if UnitAffectingCombat('player') then return end
	local instance, instanceType = IsInInstance()
	if instance then
		WatchFrame.userCollapsed = true
		WatchFrame_Collapse(WatchFrame)
	else
		WatchFrame.userCollapsed = nil
		WatchFrame_Expand(WatchFrame)
	end
	if instanceType == "arena" or instanceType == "pvp" then
		SetBinding("TAB","TARGETNEARESTENEMYPLAYER")
	else
		SetBinding("TAB","TARGETNEARESTENEMY")
	end
end

OnEvent('PLAYER_ENTERING_WORLD', OnEvent)
OnEvent('ZONE_CHANGED_NEW_AREA', OnEvent)