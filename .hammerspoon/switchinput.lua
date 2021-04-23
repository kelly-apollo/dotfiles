Pinyin = {
    'WeChat',
    'Notes',
    'Microsoft Teams',
    'Reminders',
    'Cornerstone',
    'Microsoft Word',
    'Microsoft Excel',
    'Microsoft Outlook',
}

function switch()
    hs.eventtap.keyStroke({}, 'cmd')
    hs.eventtap.keyStroke({}, 'F7')
end

function updateIme(appName)
    print('updateIme: ' ..appName)
    for _, app in pairs(Pinyin) do
        if appName == app then
            switch()
            return
        end
    end
    switch()
end

function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated or eventType == hs.application.watcher.launched) then
        updateIme(hs.window.frontmostWindow():application():name())
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

timer = nil
function test(i)
    print(i)
    i = i - 1
    if (i == 0) then
        return
    end

    hs.eventtap.keyStroke({'cmd'}, 'tab', 0)
    hs.eventtap.keyStroke({}, 'cmd')
    timer = hs.timer.delayed.new(0.01, function()
        test(i)
    end)
    timer:start()
end
hs.hotkey.bind({'alt'}, 't', function() test(200) end)
