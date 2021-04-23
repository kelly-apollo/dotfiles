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

updateImeLock = false
retryTimer = nil
unlockTimer = nil

function setIme(ime)
    if (retryTimer) then
        retryTimer:stop()
    end

    if (updateImeLock) then
        print('IME is locked.')
        retryTimer = hs.timer.delayed.new(0.2, function()
            setIme(ime)
        end)
        retryTimer:start()
        return 
    end

    updateImeLock = true
    print('Lock IME')
    hs.keycodes.currentSourceID(ime)
    print('Swtich: ' ..ime)
    unlockTimer = hs.timer.delayed.new(0.4, function()
        updateImeLock = false
        print('Unlock IME')
    end)
    unlockTimer:start()
end

function updateIme(appName)
    print('updateIme: ' ..appName)
    for _, app in pairs(Pinyin) do
        if appName == app then
            setIme('com.apple.inputmethod.SCIM.ITABC')
            return
        end
    end
    setIme('com.apple.keylayout.ABC')
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

hs.window.filter.new('Alfred')
    :subscribe(hs.window.filter.windowNotVisible, function(window, appName)
        updateIme(hs.window.frontmostWindow():application():name())
    end)
    :subscribe(hs.window.filter.windowVisible, function(window, appName)
        updateIme(appName)
    end)
