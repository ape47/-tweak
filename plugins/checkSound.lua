OnEvent('UPDATE_BATTLEFIELD_STATUS', function()
	for i = 1, GetMaxBattlefieldID() do
		if GetBattlefieldStatus(i) == 'confirm' then
			PlaySoundFile('Sound\\Interface\\ReadyCheck.wav', 'Master')
			break
		end
		i = i + 1
	end
end)

OnEvent('PET_BATTLE_QUEUE_PROPOSE_MATCH', function()
	PlaySoundFile('Interface\\AddOns\\ConceptionUI\\media\\sounds\\check.mp3', 'Master')
end)

OnEvent('READY_CHECK', function()
	PlaySoundFile('Interface\\AddOns\\ConceptionUI\\media\\sounds\\check.mp3', 'Master')
end)

OnEvent('LFG_PROPOSAL_SHOW', function()
	PlaySoundFile('Interface\\AddOns\\ConceptionUI\\media\\sounds\\initial.mp3', 'Master')
end)

OnEvent('CHAT_MSG_WHISPER', function()
	PlaySoundFile('Interface\\AddOns\\ConceptionUI\\media\\sounds\\whisper.mp3', 'Master')
end)

OnEvent('CHAT_MSG_BN_WHISPER', function()
	PlaySoundFile('Interface\\AddOns\\ConceptionUI\\media\\sounds\\whisper.mp3', 'Master')
end)