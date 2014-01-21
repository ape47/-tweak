--if UnitGUID("player") == "0x0200000000163D92" then return end

local function OnEvent(self, event)
	local SetCVar = SetCVar

	-- Startup
		SetCVar("timingMethod",			0)    -- 0 auto
		SetCVar("processAffinityMask",	0)	-- 0 = auto
		SetCVar("checkAddonVersion",		0)
		SetCVar("M2Faster",			3)
		SetCVar("UIFaster",			3)

	-- Graphics
		SetCVar("gxApi",				'GLL')
	--	SetCVar("gxResolution",			'2048x1280')
	--	SetCVar('gxMultisample',		4)
	--	SetCVar('gxMultisampleQuality',	0)
		SetCVar("emphasizeMySpellEffects",	1)	-- 0/1 Whether other player's spell impacts are toned down or not
	--	SetCVar("environmentDetail",		.01)	-- Controls model draw distance for doodads
	--	SetCVar("groundEffectDist",		.01)
	--	SetCVar("groundEffectDensity",	.01)
	--	SetCVar("gxTextureCacheSize",		256) --d3d9 only
		SetCVar("gxColorBits",			24)
		SetCVar("gxDepthBits",			24)
		SetCVar("gxVSync",			0)
		SetCVar("gxRefresh",			60.0)
		SetCVar("MaxFPS",				60)
		SetCVar("MaxFPSBK",			30)
	--	SetCVar("farclip",			1600)	-- 視野距離 0-1600
		SetCVar("ffx",				1)
		SetCVar("ffxGlow",			1)
		SetCVar("ffxDeath",			1)
		SetCVar("ffxSpecial",			1)
		SetCVar("ffxNetherWorld",		1)
		SetCVar("ffxRectangle",			1)
	--	SetCVar("particleDensity",		100)
	--	SetCVar("reflectionMode",		0)
	--	SetCVar("reflectionDownscale",	0)
	--	SetCVar("rippleDetail",			0)
	--	SetCVar("useWeatherShaders",		0)
	--	SetCVar("waterDetail",			0)
	--	SetCVar("weatherDensity",		0)
	--	SetCVar("shadowTextureSize",		2048)   --1024 or 2048
	--	SetCVar("shadowcull",			0)
	--	SetCVar("shadowMode",			0)
	--	SetCVar("shadowinstancing",		0)
	--	SetCVar("showfootprintparticles",	0)
	--	SetCVar("SkyCloudLOD",			0)
	--	SetCVar("sunshafts",			0)
	--	SetCVar("fixedfunction",		0)

	-- Sync
		SetCVar("synchronizeBindings",	0)
		SetCVar("synchronizeConfig",		0)
		SetCVar("synchronizeMacros",		0)
		SetCVar("synchronizeSettings",	0)

	-- Screenshot
		SetCVar("screenshotFormat",		"png")
		SetCVar("screenshotQuality",		10)

	-- Nameplate
		SetCVar('nameplateShowFriends', 1)
		SetCVar('nameplateShowFriendlyPets', 1)
		SetCVar('nameplateShowFriendlyGuardians', 1)
		SetCVar('nameplateShowFriendlyTotems', 1)
		SetCVar('nameplateShowEnemies', 1)
		SetCVar('nameplateShowEnemyPets', 1)
		SetCVar('nameplateShowEnemyGuardians', 1)
		SetCVar('nameplateShowEnemyTotems', 1)

	-- Camera
		SetCVar('cameraDistanceMax', 50)		-- 鏡頭拉遠
		SetCVar('cameraDistanceMaxFactor', 50)	-- 鏡頭拉遠
		SetCVar("cameraDistanceMoveSpeed",	50)	-- 鏡頭拉動速度

	-- Fuck you filter
		if BNConnected() then
			BNSetMatureLanguageFilter(false)
		end
		SetCVar('profanityFilter', 0)

	-- Others
		SetCVar("unitHighlights",		1)
		SetCVar("ObjectSelectionCircle",	1)	-- 選取圈圈		0/1
		SetCVar("violenceLevel",		5)	-- 畫面血腥等級	0~5
		SetCVar("gxCursor",			1)	-- enables Hardware Cursor
		SetCVar("gxFixLag",			0)	-- enables Smooth Mouse
		SetCVar("mouseSpeed",			1)
		SetCVar("lootUnderMouse",		1)
		SetCVar("bgLoadThrottle",		0)	-- Set the maximum percentage of available bandwidth for background streaming
		SetCVar("taintLog",			0)
		SetCVar("combatLogOn",			0)


	self:UnregisterEvent(event)
	print(event)
	end
	
local	f = CreateFrame("Frame")
	f:RegisterEvent("VARIABLES_LOADED")
	f:SetScript("OnEvent", OnEvent)