zhongWenApps = {
    'WeChat',
    'Notes',
    'Reminders',
}

function updateIME()
    local name = hs.window.frontmostWindow():application():name()
    for k, app in pairs(zhongWenApps) do
        if name == app then
            hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
            return
        end
    end
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated or eventType == hs.application.watcher.launched) then
        updateIME()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
