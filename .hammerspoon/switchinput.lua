Pinyin = {
    'WeChat',
    'Notes',
    'Reminders',
    'Cornerstone',
    'Microsoft Word',
    'Microsoft Excel',
    'Microsoft Outlook',
}

function updateIME()
    local name = hs.window.frontmostWindow():application():name()
    for k, app in pairs(Pinyin) do
        if name == app then
            hs.keycodes.setMethod('Pinyin - Simplified')
            return
        end
    end
    hs.keycodes.setLayout('ABC')
end

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated or eventType == hs.application.watcher.launched) then
        updateIME()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
