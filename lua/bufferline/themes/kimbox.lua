local c = require("kimbox.bufferline").colors()

---@class Kimbox.BufferlineConfig
local kimbox = {
    fill = {bg = c.bg},
    background = {fg = c.fg, bg = c.bg},

    close_button = {fg = c.fuzzy_wuzzy, bg = c.bg},
    close_button_selected = {fg = c.wave_red, bg = c.active},
    close_button_visible = {fg = c.fuzzy_wuzzy, bg = c.active},

    numbers = {fg = c.magenta, bg = c.bg, bold = true},
    numbers_selected = {fg = c.fg, bg = c.active, bold = true, italic = false},
    numbers_visible = {fg = c.magenta, bg = c.active, bold = true},

    separator = {fg = c.bg, bg = c.bg},
    separator_selected = {fg = c.bg, bg = c.active},
    separator_visible = {fg = c.bg, bg = c.active},

    offset_separator = {fg = c.fuzzy_wuzzy, bg = c.bg},

    tab_separator = {fg = c.bg, bg = c.bg},
    tab_separator_selected = {fg = c.bg, bg = c.active},

    tab = {fg = c.fg, bg = c.bg},
    tab_selected = {fg = c.fg, bg = c.active, bold = true},
    tab_close = {fg = c.red},

    buffer = {fg = c.fg, bg = c.bg, bold = true},
    buffer_selected = {fg = c.fg, bg = c.active, bold = true, italic = false},
    buffer_visible = {fg = c.grullo_grey, bg = c.active},

    -- group_label = {fg = c.bg, bg = c.bg},
    -- group_separator = {fg = c.bg, bg = c.active},

    indicator_selected = {fg = c.red, bg = c.active, bold = true},
    indicator_visible = {fg = c.red, bg = c.active, bold = true},

    pick = {fg = c.green, bg = c.bg, bold = true, italic = false},
    pick_selected = {fg = c.teaberry, bg = c.active, bold = true, italic = false},
    pick_visible = {fg = c.green, bg = c.active, bold = true, italic = false},

    modified = {fg = c.red, bg = c.bg},
    modified_selected = {fg = c.red, bg = c.active},
    modified_visible = {fg = c.red, bg = c.active},

    duplicate = {fg = c.wave_red, bg = c.bg, italic = false},
    duplicate_selected = {fg = c.wave_red, bg = c.active, bold = true, italic = false},
    duplicate_visible = {fg = c.wave_red, bg = c.active, italic = false},

    diagnostic = {fg = c.red, bg = c.bg},
    diagnostic_selected = {fg = c.red, bg = c.active, bold = true, italic = false},
    diagnostic_visible = {fg = c.red, bg = c.active},

    hint = {fg = c.beaver, bg = c.bg},
    hint_selected = {fg = c.blue, bg = c.active, bold = true, italic = false},
    hint_visible = {fg = c.beaver, bg = c.active},
    hint_diagnostic = {fg = c.blue, bg = c.bg, bold = true},
    hint_diagnostic_selected = {fg = c.blue, bg = c.active, italic = false},
    hint_diagnostic_visible = {fg = c.blue, bg = c.active, bold = true},

    info = {fg = c.beaver, bg = c.bg},
    info_selected = {fg = c.purple, bg = c.active, bold = true, italic = false},
    info_visible = {fg = c.beaver, bg = c.active},
    info_diagnostic = {fg = c.purple, bg = c.bg, bold = true},
    info_diagnostic_selected = {fg = c.purple, bg = c.active, italic = false},
    info_diagnostic_visible = {fg = c.purple, bg = c.active, bold = true},

    warning = {fg = c.beaver, bg = c.bg},
    warning_selected = {fg = c.yellow, bg = c.active, bold = true, italic = false},
    warning_visible = {fg = c.beaver, bg = c.active},
    warning_diagnostic = {fg = c.yellow, bg = c.bg, bold = true},
    warning_diagnostic_selected = {fg = c.yellow, bg = c.active, italic = false},
    warning_diagnostic_visible = {fg = c.yellow, bg = c.active, bold = true},

    error = {fg = c.beaver, bg = c.bg},
    error_selected = {fg = c.red, bg = c.active, bold = true, italic = false},
    error_visible = {fg = c.beaver, bg = c.active},
    error_diagnostic = {fg = c.red, bg = c.bg, bold = true},
    error_diagnostic_selected = {fg = c.red, bg = c.active, italic = false},
    error_diagnostic_visible = {fg = c.red, bg = c.active, bold = true},
}

return kimbox
