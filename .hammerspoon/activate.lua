function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

local function pressFn(mods, key)
	if key == nil then
		key = mods
		mods = {}
	end

	return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, pressFn)	
end

hs.hotkey.bind({}, "F1", open("Google Chrome"))
hs.hotkey.bind({}, "F3", open("印象笔记"))
hs.hotkey.bind({}, "F4", open("iTerm"))
hs.hotkey.bind({}, "F5", open("Finder"))

remap({'alt'}, 'j', pressFn({'ctrl', 'shift', 'alt'}, 'j'))
