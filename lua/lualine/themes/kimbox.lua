local c = require("kimbox.lualine").colors()

local kimbox = {
    normal = {
        a = {fg = c.purple, bg = c.bg, gui = "bold"},
        b = {fg = c.fg, bg = c.bg},
        c = {fg = c.fg, bg = c.brown3},
        x = {fg = c.fg, bg = c.bg},
        y = {fg = c.purple, bg = c.bg, gui = "bold"},
        z = {fg = c.purple, bg = c.bg, gui = "bold"}
    },
    command = {
        a = {fg = c.blue, bg = c.bg, gui = "bold"},
        b = {fg = c.fg, bg = c.bg},
        c = {fg = c.fg, bg = c.brown3},
        x = {fg = c.fg, bg = c.bg}
    },
    inactive = {
        a = {fg = c.red, bg = c.bg},
        b = {fg = c.magenta, bg = c.bg}
    },
    insert = {
        a = {fg = c.green, bg = c.bg, gui = "bold"},
        b = {fg = c.fg, bg = c.bg},
        c = {fg = c.fg, bg = c.brown3},
        x = {fg = c.fg, bg = c.bg},
        y = {fg = c.green, bg = c.bg, gui = "bold"},
        z = {fg = c.green, bg = c.bg, gui = "bold"}
    },
    replace = {
        a = {fg = c.red, bg = c.bg, gui = "bold"},
        b = {fg = c.fg, bg = c.bg},
        c = {fg = c.fg, bg = c.brown3},
        x = {fg = c.fg, bg = c.bg}
    },
    terminal = {
        a = {fg = c.yellow, bg = c.bg, gui = "bold"},
        b = {fg = c.fg, bg = c.bg},
        c = {fg = c.fg, bg = c.brown3},
        x = {fg = c.fg, bg = c.bg},
        y = {fg = c.yellow, bg = c.bg, gui = "bold"},
        z = {fg = c.yellow, bg = c.bg, gui = "bold"}
    },
    visual = {
        a = {fg = c.salmon, bg = c.bg, gui = "bold"},
        b = {fg = c.fg, bg = c.bg},
        c = {fg = c.fg, bg = c.brown3},
        x = {fg = c.fg, bg = c.bg},
        y = {fg = c.salmon, bg = c.bg, gui = "bold"},
        z = {fg = c.salmon, bg = c.bg, gui = "bold"}
    }
}

return kimbox
