local function GetLinkColor(data)
	local type, id, arg1 = string.match(data, '(%w+):(%d+)')
	if(type == 'item') then
		local _, _, quality = GetItemInfo(id)
		if(quality) then
			local _, _, _, hex = GetItemQualityColor(quality)
			return '|c' .. hex
		else
			-- Item is not cached yet, show a white color instead
			-- Would like to fix this somehow
			return '|cffffffff'
		end
	elseif(type == 'quest') then
		local _, _, level = string.match(data, '(%w+):(%d+):(%d+)')
		local color = GetQuestDifficultyColor(level)
		return format('|cff%02x%02x%02x', color.r * 255, color.g * 255, color.b * 255)
	elseif(type == 'spell') then
		return '|cff71d5ff'
	elseif(type == 'achievement') then
		return '|cffffff00'
	elseif(type == 'trade' or type == 'enchant') then
		return '|cffffd000'
	elseif(type == 'instancelock') then
		return '|cffff8000'
	elseif(type == 'glyph' or type == 'journal') then
		return '|cff66bbff'
	elseif(type == 'talent') then
		return '|cff4e96f7'
	elseif(type == 'levelup') then
		return '|cffFF4E00'
	else
		return '|cffffffff'
	end
end

local function AddLinkColors(self, event, msg, ...)
	local data = string.match(msg, '|H(.-)|h(.-)|h')
	if(data) then
		local newmsg = string.gsub(msg, '|H(.-)|h(.-)|h', GetLinkColor(data) .. '|H%1|h%2|h|r')
		return false, newmsg, ...
	else
		return false, msg, ...
	end
end

ChatFrame_AddMessageEventFilter('CHAT_MSG_BN_WHISPER', AddLinkColors)
ChatFrame_AddMessageEventFilter('CHAT_MSG_BN_WHISPER_INFORM', AddLinkColors)
