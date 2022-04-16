local colors = {
    magenta = "#A06469",
    purple = "#98676A",
    dbg = "#221a0f",
    lbg = "#5e452b",
    fg = "#e8c097",
    red = "#EF1D55",
    dred = "#DC3958",
    green = "#819C3B",
    yellow = "#FF9500",
    orange = "#FF5813",
    blue = "#4C96A8",
    cyan = "#7EB2B1",
    dpurple = "#733e8b"
}

local kimbox = {
    -- Status background
    fill = {guifg = colors.magenta, guibg = colors.dbg},
    background = {guifg = colors.fg, guibg = colors.dbg},
    tab = {guifg = colors.fg, guibg = colors.dbg},
    tab_selected = {guifg = colors.fg, guibg = colors.lbg},
    -- tab_close = {
    --   guifg = "#FFFFFF",
    --   guibg = "#FFFFFF",
    -- },
    -- close_button = {
    --   guifg = "#FFFFFF",
    --   guibg = "#FFFFFF",
    -- },
    -- close_button_visible = {
    --   guifg = "#FFFFFF",
    --   guibg = "#FFFFFF",
    -- },
    -- close_button_selected = {
    --   guifg = "#FFFFFF",
    --   guibg = "#FFFFFF",
    -- },
    buffer_visible = {guifg = colors.magenta, guibg = colors.lbg},
    buffer_selected = {
        guifg = colors.fg,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    diagnostic = {guifg = colors.red, guibg = colors.dbg},
    diagnostic_visible = {guifg = colors.red, guibg = colors.lbg},
    diagnostic_selected = {
        guifg = colors.red,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    hint = {guifg = colors.cyan, guibg = colors.dbg},
    hint_visible = {guifg = colors.blue, guibg = colors.lbg},
    hint_selected = {
        guifg = colors.blue,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    hint_diagnostic = {guifg = colors.blue, guibg = colors.dbg},
    hint_diagnostic_visible = {guifg = colors.blue, guibg = colors.lbg},
    hint_diagnostic_selected = {
        guifg = colors.blue,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    info = {guifg = colors.purple, guibg = colors.dbg},
    info_visible = {guifg = colors.purple, guibg = colors.lbg},
    info_selected = {
        guifg = colors.purple,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    info_diagnostic = {guifg = colors.purple, guibg = colors.dbg},
    info_diagnostic_visible = {guifg = colors.purple, guibg = colors.lbg},
    info_diagnostic_selected = {
        guifg = colors.purple,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    warning = {guifg = colors.orange, guibg = colors.dbg},
    warning_visible = {guifg = colors.orange, guibg = colors.lbg},
    warning_selected = {
        guifg = colors.orange,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    warning_diagnostic = {guifg = colors.orange, guibg = colors.dbg},
    warning_diagnostic_visible = {guifg = colors.orange, guibg = colors.lbg},
    warning_diagnostic_selected = {
        guifg = colors.orange,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    error = {guifg = colors.red, guibg = colors.dbg},
    error_visible = {guifg = colors.red, guibg = colors.lbg},
    error_selected = {
        guifg = colors.red,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    error_diagnostic = {guifg = colors.red, guibg = colors.dbg},
    error_diagnostic_visible = {guifg = colors.red, guibg = colors.lbg},
    error_diagnostic_selected = {
        guifg = colors.red,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    modified = {guifg = colors.red, guibg = colors.dbg},
    modified_visible = {guifg = colors.red, guibg = colors.lbg},
    modified_selected = {guifg = colors.red, guibg = colors.lbg},
    duplicate_selected = {
        guifg = colors.cyan,
        gui = "italic",
        guibg = colors.lbg
    },
    duplicate_visible = {guifg = colors.cyan, gui = "italic", guibg = colors.lbg},
    duplicate = {guifg = colors.red, gui = "italic", guibg = colors.dbg},
    separator_selected = {guifg = colors.dbg, guibg = colors.lbg},
    separator_visible = {guifg = colors.dbg, guibg = colors.lbg},
    separator = {guifg = colors.dbg, guibg = colors.dbg},
    indicator_selected = {guifg = colors.red, guibg = colors.lbg},
    pick_selected = {
        guifg = colors.dred,
        guibg = colors.lbg,
        gui = "bold,italic"
    },
    pick_visible = {
        guifg = colors.green,
        guibg = colors.dbg,
        gui = "bold,italic"
    },
    pick = {guifg = colors.green, guibg = colors.dbg, gui = "bold,italic"},
    numbers = {
        guifg = colors.fg,
        guibg = colors.dbg
    },
    numbers_selected = {
        guifg = colors.fg,
        guibg = colors.lbg,
        gui = "bold"
    },
    numbers_visible = {
        guifg = colors.fg,
        guibg = colors.lbg
    }
}

return kimbox
