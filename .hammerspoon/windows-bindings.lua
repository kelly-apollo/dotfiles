return {
  modifiers = {'ctrl'},
  showHelp  = false,
  trigger   = 's',
  mappings  = {
    { {},         'tab', 'centerInWindow' },
    { {},         'return',  'center' },
    { {},         'space',  'maximize' },
    { {},         'h',      'left' },
    { {},         'j',      'down' },
    { {},         'k',      'up' },
    { {},         'l',      'right' },
    { {'shift'},  'h',      'left40' },
    { {'shift'},  'l',      'right60' },
    { {},         'i',      'upLeft' },
    { {},         'o',      'upRight' },
    { {},         ',',      'downLeft' },
    { {},         '.',      'downRight' },
    { {},         'n',      'nextScreen' },
    { {},         'right',  'moveOneScreenEast' },
    { {},         'left',   'moveOneScreenWest' },
  }
}
