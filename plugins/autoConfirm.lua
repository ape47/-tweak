-- 確認丟垃圾
local trash = {
	['5956']  = true,	-- 鐵匠之錘
	['17056'] = true,	-- 輕羽毛
	['17057'] = true,	-- 閃亮的魚鱗
	['17058'] = true,	-- 魚油
	['19978'] = true,	-- 釣魚大賽!
	['32897'] = true,	-- 伊利達瑞的印記
	['79104'] = true,	-- 生鏽的灑水壺
	['80513'] = true,	-- 古董殺蟲劑
	['89815'] = true,	-- 犁田主宰
	['89880'] = true,	-- 凹損的鏟子
	['80610'] = true,	-- 魔法法力布丁
	['80618'] = true,	-- 魔法法力包子
	['34498'] = true,	-- 紙飛艇工具組
	['38577'] = true,	-- 派對手榴彈
}

OnEvent('DELETE_ITEM_CONFIRM', function(self, event, ...)
	local _, link, quality = GetItemInfo(...)
	if quality == 0 then
		StaticPopupSpecial_Hide(StaticPopup1)
		DeleteCursorItem()
		return
	else
		local id = string.match(link, 'item:(%d+)')
		if trash[id] then
			StaticPopupSpecial_Hide(StaticPopup1)
			DeleteCursorItem()
		end
	end
end)


-- 確認roll裝、拾取
StaticPopupDialogs['LOOT_BIND'] = nil
StaticPopupDialogs['CONFIRM_LOOT_ROLL'] = nil

OnEvent('LOOT_BIND_CONFIRM', function(self, event, ...)
	ConfirmLootSlot(...)
end)

OnEvent('CONFIRM_LOOT_ROLL', function(self, event, ...)
	ConfirmLootRoll(...)
end)

OnEvent('CONFIRM_DISENCHANT_ROLL', function(self, event, ...)
	ConfirmLootRoll(...)
end)

OnEvent('START_LOOT_ROLL', function(self, event, ...)
	if select(4, GetLootRollItemInfo(...)) == 2 then
		RollOnLoot(..., 2)
	end
end)


-- 選擇角色類型
local function SelectRole()
	StaticPopupSpecial_Hide(RolePollPopup)
	UnitSetRole('player', GetSpecializationRole(GetSpecialization()))
end
OnEvent('GROUP_JOINED', SelectRole)
OnEvent('ROLE_POLL_BEGIN', SelectRole)

-- 被復活/thx
local who = nil
OnEvent['RESURRECT_REQUEST'] = function(self, event, ...)
	who = ...
	if UnitAffectingCombat(...) then return end
	StaticPopupSpecial_Hide(StaticPopup1)
	AcceptResurrect()
end

OnEvent('PLAYER_DEAD', function(self, event)
	self:UnregisterEvent(event)
	self:RegisterEvent('RESURRECT_REQUEST')
	self:RegisterEvent('PLAYER_UNGHOST')
	self:RegisterEvent('PLAYER_ALIVE')
end)

local function thx(self)
	self:UnregisterEvent('RESURRECT_REQUEST')
	self:UnregisterEvent('PLAYER_UNGHOST')
	self:UnregisterEvent('PLAYER_ALIVE')
	self:RegisterEvent('PLAYER_DEAD')
	if not who then return end
	DoEmote('THANK', who)
	who = nil
end

OnEvent['PLAYER_UNGHOST'] = thx
OnEvent['PLAYER_ALIVE'] = thx


-- 巨集

OnEvent('SPELLS_CHANGED', function()
	local spell = GetSpellInfo('神聖稜石') or GetSpellInfo('聖光之錘') or GetSpellInfo('死刑宣判')
	if not spell then return end
	SetMacroSpell('Talent6', spell)
end)

OnEvent('BAG_UPDATE', function()
	SetMacroItem('爐石', IsUsableItem('旅店老闆的女兒') and '旅店老闆的女兒' or '爐石')
	SetMacroItem('hp', IsUsableItem('聯盟戰旗') and '聯盟戰旗' or '治療石')
end)