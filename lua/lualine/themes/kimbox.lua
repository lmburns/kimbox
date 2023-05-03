local c = require("kimbox.lualine").colors()

---@class KimboxLualineConfig
local kimbox = {
    normal = {
        a = {fg = c.purple, bg = c.bg0, gui = "bold"},
        b = {fg = c.fg0, bg = c.bg0},
        c = {fg = c.fg0, bg = c.bg2},
        x = {fg = c.fg0, bg = c.bg0},
        y = {fg = c.purple, bg = c.bg0, gui = "bold"},
        z = {fg = c.purple, bg = c.bg0, gui = "bold"}
    },
    command = {
        a = {fg = c.blue, bg = c.bg0, gui = "bold"},
        b = {fg = c.fg0, bg = c.bg0},
        c = {fg = c.fg0, bg = c.bg2},
        x = {fg = c.fg0, bg = c.bg0}
    },
    inactive = {
        a = {fg = c.red, bg = c.bg0},
        b = {fg = c.magenta, bg = c.bg0}
    },
    insert = {
        a = {fg = c.green, bg = c.bg0, gui = "bold"},
        b = {fg = c.fg0, bg = c.bg0},
        c = {fg = c.fg0, bg = c.bg2},
        x = {fg = c.fg0, bg = c.bg0},
        y = {fg = c.green, bg = c.bg0, gui = "bold"},
        z = {fg = c.green, bg = c.bg0, gui = "bold"}
    },
    replace = {
        a = {fg = c.red, bg = c.bg0, gui = "bold"},
        b = {fg = c.fg0, bg = c.bg0},
        c = {fg = c.fg0, bg = c.bg2},
        x = {fg = c.fg0, bg = c.bg0}
    },
    terminal = {
        a = {fg = c.yellow, bg = c.bg0, gui = "bold"},
        b = {fg = c.fg0, bg = c.bg0},
        c = {fg = c.fg0, bg = c.bg2},
        x = {fg = c.fg0, bg = c.bg0},
        y = {fg = c.yellow, bg = c.bg0, gui = "bold"},
        z = {fg = c.yellow, bg = c.bg0, gui = "bold"}
    },
    visual = {
        a = {fg = c.salmon, bg = c.bg0, gui = "bold"},
        b = {fg = c.fg0, bg = c.bg0},
        c = {fg = c.fg0, bg = c.bg2},
        x = {fg = c.fg0, bg = c.bg0},
        y = {fg = c.salmon, bg = c.bg0, gui = "bold"},
        z = {fg = c.salmon, bg = c.bg0, gui = "bold"}
    }
}

return kimbox
