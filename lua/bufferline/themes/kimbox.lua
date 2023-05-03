local c = require("kimbox.bufferline").colors()

---@class KimboxBufferlineConfig
local kimbox = {
    fill = {bg = c.vscode},
    background = {fg = c.fg0, bg = c.vscode},

    close_button = {fg = c.light_red, bg = c.vscode},
    close_button_selected = {fg = c.wave_red, bg = c.bg4},
    close_button_visible = {fg = c.light_red, bg = c.vscode},

    numbers = {fg = c.magenta, bg = c.vscode, bold = true},
    numbers_selected = {fg = c.fg0, bg = c.bg4, bold = true, italic = false},
    numbers_visible = {fg = c.magenta, bg = c.bg4, bold = true},

    separator = {fg = c.vscode, bg = c.vscode},
    separator_selected = {fg = c.vscode, bg = c.bg4},
    separator_visible = {fg = c.vscode, bg = c.bg4},

    offset_separator = {fg = c.light_red, bg = c.vscode},

    tab_separator = {fg = c.vscode, bg = c.vscode},
    tab_separator_selected = {fg = c.vscode, bg = c.bg4},

    tab = {fg = c.fg0, bg = c.vscode},
    tab_selected = {fg = c.fg0, bg = c.bg4, bold = true},
    tab_close = {fg = c.red},

    buffer = {fg = c.fg0, bg = c.vscode, bold = true},
    buffer_selected = {fg = c.fg0, bg = c.bg4, bold = true, italic = false},
    buffer_visible = {fg = c.grullo_grey, bg = c.bg4},

    -- group_label = {fg = c.vscode, bg = c.vscode},
    -- group_separator = {fg = c.vscode, bg = c.bg4},

    indicator_selected = {fg = c.red, bg = c.bg4, bold = true},
    indicator_visible = {fg = c.red, bg = c.vscode, bold = true},

    pick = {fg = c.green, bg = c.vscode, bold = true, italic = false},
    pick_selected = {fg = c.bg_red, bg = c.bg4, bold = true, italic = false},
    pick_visible = {fg = c.green, bg = c.vscode, bold = true, italic = false},

    diagnostic = {fg = c.red, bg = c.vscode},
    diagnostic_selected = {fg = c.red, bg = c.bg4, bold = true, italic = false},
    diagnostic_visible = {fg = c.red, bg = c.bg4},

    hint = {fg = c.beaver, bg = c.vscode},
    hint_selected = {fg = c.blue, bg = c.bg4, bold = true, italic = false},
    hint_visible = {fg = c.beaver, bg = c.bg4},
    hint_diagnostic = {fg = c.blue, bg = c.vscode, bold = true},
    hint_diagnostic_selected = {fg = c.blue, bg = c.bg4, italic = false},
    hint_diagnostic_visible = {fg = c.blue, bg = c.bg4, bold = true},

    info = {fg = c.beaver, bg = c.vscode},
    info_selected = {fg = c.purple, bg = c.bg4, bold = true, italic = false},
    info_visible = {fg = c.beaver, bg = c.bg4},
    info_diagnostic = {fg = c.purple, bg = c.vscode, bold = true},
    info_diagnostic_selected = {fg = c.purple, bg = c.bg4, italic = false},
    info_diagnostic_visible = {fg = c.purple, bg = c.bg4, bold = true},

    warning = {fg = c.beaver, bg = c.vscode},
    warning_selected = {fg = c.yellow, bg = c.bg4, bold = true, italic = false},
    warning_visible = {fg = c.beaver, bg = c.bg4},
    warning_diagnostic = {fg = c.yellow, bg = c.vscode, bold = true},
    warning_diagnostic_selected = {fg = c.yellow, bg = c.bg4, italic = false},
    warning_diagnostic_visible = {fg = c.yellow, bg = c.bg4, bold = true},

    error = {fg = c.beaver, bg = c.vscode},
    error_selected = {fg = c.red, bg = c.bg4, bold = true, italic = false},
    error_visible = {fg = c.beaver, bg = c.bg4},
    error_diagnostic = {fg = c.red, bg = c.vscode, bold = true},
    error_diagnostic_selected = {fg = c.red, bg = c.bg4, italic = false},
    error_diagnostic_visible = {fg = c.red, bg = c.bg4, bold = true},

    modified = {fg = c.red, bg = c.vscode},
    modified_selected = {fg = c.red, bg = c.bg4},
    modified_visible = {fg = c.red, bg = c.bg4},

    duplicate = {fg = c.wave_red, bg = c.vscode, italic = false},
    duplicate_selected = {fg = c.wave_red, bg = c.bg4, bold = true, italic = false},
    duplicate_visible = {fg = c.wave_red, bg = c.bg4, italic = false},
}

return kimbox
