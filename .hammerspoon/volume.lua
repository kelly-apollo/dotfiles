function toggleMute()
  return function()
    local device = hs.audiodevice.defaultOutputDevice()
    if device:muted() then
      device:setMuted(false)
    else
      device:setMuted(true)
    end
  end
end

function changeVolume(diff)
  return function()
    local current = hs.audiodevice.defaultOutputDevice():volume()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    if new > 0 then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    end
    hs.audiodevice.defaultOutputDevice():setVolume(new)
  end
end

hs.hotkey.bind({'alt'}, 'q', changeVolume(5))
hs.hotkey.bind({'alt'}, 'w', changeVolume(-5))
hs.hotkey.bind({'alt'}, 'e', toggleMute())
