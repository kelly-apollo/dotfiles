markRead = hs.hotkey.new('⌘', 'r', function()
	win = hs.window.focusedWindow()
	frame = win:frame()
	posCursor = hs.mouse.getAbsolutePosition()

	pos = hs.geometry.point(frame.x, frame.y)
	pos.x = pos.x + frame.w - 20
	pos.y = pos.y + frame.h / 3

	hs.eventtap.leftClick(pos)
	hs.mouse.setAbsolutePosition(posCursor)
	hs.eventtap.keyStroke({"cmd"}, "h")
end)

hs.application.watcher.new(function (appName, eventType, appObject)
	if (appName ~= "WeChat") then
		return 
	end
	if (eventType == hs.application.watcher.activated) then
		markRead:enable()
	elseif (eventType == hs.application.watcher.deactivated) then
		markRead:disable()
	end
end
):start()
