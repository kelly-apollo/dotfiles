function open(name)
    hs.application.launchOrFocus(name)
    if name == 'Finder' then
        hs.appfinder.appFromName(name):activate()
    end
end

function openFn(name)
    return function() open(name) end
end

function stroke(modes, key)
    return function()
        hs.eventtap.keyStroke(modes, key)
    end
end

function strokes(str)
    return function()
        local text = str
        if type(str) == 'function' then
            text = str()
        end
        hs.eventtap.keyStrokes(text)
    end
end

function getToday()
    local date_table = os.date("*t")
    local year, month, day = date_table.year, date_table.month, date_table.day


    return string.format("%d-%d-%d", year, month, day)
end

hs.hotkey.bind({}, 'F1', openFn('Google Chrome'))
-- hs.hotkey.bind({}, 'F2', openFn('IntelliJ IDEA CE'))
hs.hotkey.bind({}, 'F3', openFn('印象笔记'))
hs.hotkey.bind({}, 'F4', openFn('iTerm'))
hs.hotkey.bind({}, 'F5', openFn('Finder'))
hs.hotkey.bind({'alt'}, '1', openFn('MacVim'))

hs.hotkey.bind({'cmd', 'ctrl'}, 'w', function()
    if hs.window.frontmostWindow():application():name() == 'WeChat' then
        hs.eventtap.keyStroke({"cmd"}, "h")
        return
    end
    open('WeChat')
end)
hs.hotkey.bind({}, 'F12', function() hs.execute('pmset displaysleepnow') end)

hs.hotkey.bind({'alt'}, 'j', stroke({'ctrl', 'shift', 'alt'}, 'j'))
hs.hotkey.bind({'alt'}, 'd', strokes(getToday))
hs.hotkey.bind({'alt', 'shift'}, 'b', strokes('bioserenity'))
hs.hotkey.bind({'alt', 'shift'}, 'r', strokes('referential'))
hs.hotkey.bind({'alt', 'shift'}, 'c', strokes('cardioskin'))
hs.hotkey.bind({'alt', 'shift'}, 'c', strokes('cardioskin'))
hs.hotkey.bind({'alt'}, 'a', function() hs.spotify.playpause() end)
