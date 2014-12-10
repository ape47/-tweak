--UIErrorsFrame:UnregisterEvent('UI_ERROR_MESSAGE')
--UIErrorsFrame:Hide()

-- AH搜尋
SlashCmdList["AH"] = function()
	local a = {"丑帽菇","綠茶葉","絲草","黃金蓮","魔古之力藥水","紅花蔥","青蔥"} b = mod( b or 0, #(a) ) + 1 
	BrowseName:SetText(a[b])
	QueryAuctionItems(a[b])
end
SLASH_AH1 = "/ah"