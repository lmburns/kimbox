local colors = require("kimbox.lualine").colors()

local kimbox = {
    normal = {
        a = {fg = colors.purple, bg = colors.bg, gui = "bold"},
        b = {fg = colors.fg, bg = colors.bg},
        c = {fg = colors.fg, bg = colors.brown3},
        x = {fg = colors.fg, bg = colors.bg},
        y = {fg = colors.purple, bg = colors.bg, gui = "bold"},
        z = {fg = colors.purple, bg = colors.bg, gui = "bold"}
    },
    command = {
        a = {fg = colors.blue, bg = colors.bg, gui = "bold"},
        b = {fg = colors.fg, bg = colors.bg},
        c = {fg = colors.fg, bg = colors.brown3},
        x = {fg = colors.fg, bg = colors.bg}
    },
    inactive = {
        a = {fg = colors.red, bg = colors.bg},
        b = {fg = colors.magenta, bg = colors.bg}
    },
    insert = {
        a = {fg = colors.green, bg = colors.bg, gui = "bold"},
        b = {fg = colors.fg, bg = colors.bg},
        c = {fg = colors.fg, bg = colors.brown3},
        x = {fg = colors.fg, bg = colors.bg},
        y = {fg = colors.green, bg = colors.bg, gui = "bold"},
        z = {fg = colors.green, bg = colors.bg, gui = "bold"}
    },
    replace = {
        a = {fg = colors.red, bg = colors.bg, gui = "bold"},
        b = {fg = colors.fg, bg = colors.bg},
        c = {fg = colors.fg, bg = colors.brown3},
        x = {fg = colors.fg, bg = colors.bg}
    },
    terminal = {
        a = {fg = colors.yellow, bg = colors.bg, gui = "bold"},
        b = {fg = colors.fg, bg = colors.bg},
        c = {fg = colors.fg, bg = colors.brown3},
        x = {fg = colors.fg, bg = colors.bg},
        y = {fg = colors.yellow, bg = colors.bg, gui = "bold"},
        z = {fg = colors.yellow, bg = colors.bg, gui = "bold"}
    },
    visual = {
        a = {fg = colors.orange, bg = colors.bg, gui = "bold"},
        b = {fg = colors.fg, bg = colors.bg},
        c = {fg = colors.fg, bg = colors.brown3},
        x = {fg = colors.fg, bg = colors.bg},
        y = {fg = colors.orange, bg = colors.bg, gui = "bold"},
        z = {fg = colors.orange, bg = colors.bg, gui = "bold"}
    }
}

return kimbox
