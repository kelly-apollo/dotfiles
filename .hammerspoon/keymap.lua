function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

function stroke(modes, key)
    return function()
        hs.eventtap.keyStroke(modes, key)
    end
end

function strokes(text)
    return function()
        if type(text) == 'function' then
            text = text()
        end
        hs.eventtap.keyStrokes(text)
    end
end

function getToday()
    local date_table = os.date("*t")
    local year, month, day = date_table.year, date_table.month, date_table.day


    return string.format("%d-%d-%d", year, month, day)
end

hs.hotkey.bind({}, 'F1', open('Google Chrome'))
hs.hotkey.bind({}, 'F2', open('IntelliJ IDEA CE'))
hs.hotkey.bind({}, 'F3', open('印象笔记'))
hs.hotkey.bind({}, 'F4', open('iTerm'))
hs.hotkey.bind({}, 'F5', open('Finder'))
hs.hotkey.bind({}, 'F12', function() hs.execute('pmset displaysleepnow') end)

hs.hotkey.bind({'alt'}, 'j', stroke({'ctrl', 'shift', 'alt'}, 'j'))
hs.hotkey.bind({'alt'}, 'd', strokes(getToday))
hs.hotkey.bind({'alt', 'shift'}, 'b', strokes('bioserenity'))
hs.hotkey.bind({'alt', 'shift'}, 'r', strokes('referential'))
hs.hotkey.bind({'alt', 'shift'}, 'c', strokes('cardioskin'))
hs.hotkey.bind({'alt', 'shift'}, 'c', strokes('cardioskin'))
