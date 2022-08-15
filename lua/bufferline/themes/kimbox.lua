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
    fill = {fg = colors.magenta, bg = colors.dbg},
    background = {fg = colors.fg, bg = colors.dbg},
    tab = {fg = colors.fg, bg = colors.dbg},
    tab_selected = {fg = colors.fg, bg = colors.lbg},
    -- tab_close = {
    --   fg = "#FFFFFF",
    --   bg = "#FFFFFF",
    -- },
    -- close_button = {
    --   fg = "#FFFFFF",
    --   bg = "#FFFFFF",
    -- },
    -- close_button_visible = {
    --   fg = "#FFFFFF",
    --   bg = "#FFFFFF",
    -- },
    -- close_button_selected = {
    --   fg = "#FFFFFF",
    --   bg = "#FFFFFF",
    -- },
    buffer_visible = {fg = colors.magenta, bg = colors.lbg},
    buffer_selected = {
        fg = colors.fg,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    diagnostic = {fg = colors.red, bg = colors.dbg},
    diagnostic_visible = {fg = colors.red, bg = colors.lbg},
    diagnostic_selected = {
        fg = colors.red,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    hint = {fg = colors.cyan, bg = colors.dbg},
    hint_visible = {fg = colors.blue, bg = colors.lbg},
    hint_selected = {
        fg = colors.blue,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    hint_diagnostic = {fg = colors.blue, bg = colors.dbg},
    hint_diagnostic_visible = {fg = colors.blue, bg = colors.lbg},
    hint_diagnostic_selected = {
        fg = colors.blue,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    info = {fg = colors.purple, bg = colors.dbg},
    info_visible = {fg = colors.purple, bg = colors.lbg},
    info_selected = {
        fg = colors.purple,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    info_diagnostic = {fg = colors.purple, bg = colors.dbg},
    info_diagnostic_visible = {fg = colors.purple, bg = colors.lbg},
    info_diagnostic_selected = {
        fg = colors.purple,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    warning = {fg = colors.orange, bg = colors.dbg},
    warning_visible = {fg = colors.orange, bg = colors.lbg},
    warning_selected = {
        fg = colors.orange,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    warning_diagnostic = {fg = colors.orange, bg = colors.dbg},
    warning_diagnostic_visible = {fg = colors.orange, bg = colors.lbg},
    warning_diagnostic_selected = {
        fg = colors.orange,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    error = {fg = colors.red, bg = colors.dbg},
    error_visible = {fg = colors.red, bg = colors.lbg},
    error_selected = {
        fg = colors.red,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    error_diagnostic = {fg = colors.red, bg = colors.dbg},
    error_diagnostic_visible = {fg = colors.red, bg = colors.lbg},
    error_diagnostic_selected = {
        fg = colors.red,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    modified = {fg = colors.red, bg = colors.dbg},
    modified_visible = {fg = colors.red, bg = colors.lbg},
    modified_selected = {fg = colors.red, bg = colors.lbg},
    duplicate_selected = {
        fg = colors.cyan,
        bg = colors.lbg,
        italic = true
    },
    duplicate_visible = {fg = colors.cyan, bg = colors.lbg, italic = true},
    duplicate = {fg = colors.red, bg = colors.dbg, italic = true},
    separator_selected = {fg = colors.dbg, bg = colors.lbg},
    separator_visible = {fg = colors.dbg, bg = colors.lbg},
    separator = {fg = colors.dbg, bg = colors.dbg},
    indicator_selected = {fg = colors.red, bg = colors.lbg},
    pick_selected = {
        fg = colors.dred,
        bg = colors.lbg,
        italic = true,
        bold = true
    },
    pick_visible = {
        fg = colors.green,
        bg = colors.dbg,
        italic = true,
        bold = true
    },
    pick = {
        fg = colors.green,
        bg = colors.dbg,
        italic = true,
        bold = true
    },
    numbers = {
        fg = colors.fg,
        bg = colors.dbg
    },
    numbers_selected = {
        fg = colors.fg,
        bg = colors.lbg,
        bold = true
    },
    numbers_visible = {
        fg = colors.fg,
        bg = colors.lbg
    }
}

return kimbox
