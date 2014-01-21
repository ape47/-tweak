local OnEvent = {}

local Handler = CreateFrame('Frame')
	Handler:SetScript('OnEvent', function(self, event, ...) OnEvent[event](self, event, ...) end)
	Handler:Hide()

function Handler:Register(event, func)
	Handler:RegisterEvent(event)
	OnEvent[event] = func
end

 setmetatable(OnEvent, {__call = Handler.Register})

_G['OnEvent'] = OnEvent