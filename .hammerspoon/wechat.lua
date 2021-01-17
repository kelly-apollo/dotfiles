markRead = hs.hotkey.new('⌘', 'r', function()
	win = hs.window.focusedWindow()
	frame = win:frame()
	posCursor = hs.mouse.getAbsolutePosition()

	pos = hs.geometry.point(frame.x, frame.y)
	pos.x = pos.x + 60 + 30
	pos.y = pos.y + 60 + 30

	hs.eventtap.leftClick(pos)
	hs.mouse.setAbsolutePosition(posCursor)
	hs.eventtap.keyStroke({"cmd"}, "h")
end)

function applicationWatcher(appName, eventType, appObject)
	if (appName ~= "WeChat") then
		return 
	end
	if (eventType == hs.application.watcher.activated) then
		markRead:enable()
	elseif (eventType == hs.application.watcher.deactivated) then
		markRead:disable()
	end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
