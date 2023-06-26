local M = {}

local Config = require("kimbox.config")
local utils = require("kimbox.utils")
local log = utils.log

---@return KimboxConfig?
function M.load()
    local opts = {
        "background",
        "transparent_background",
        "disable_terminal_colors",
        "diagnostics_text_bg",
        "hide_ending_tildes",
        "toggle_style_keymap",
        "allow_bold",
        "allow_italic",
        "allow_underline",
        "allow_reverse",
        "allow_undercurl",
    }

    local cfg = {}
    local using_old_config = false
    local messages = ""

    for _, opt in ipairs(opts) do
        local value = vim.g["kimbox_" .. opt]
        if value ~= nil then
            cfg[opt] = value
            using_old_config = true
            messages =
                ([[%s option 'vim.g.kimbox_%s' has been deprecated.]] ..
                    [[\nLook at README.md for new configuration.]]):format(messages, opt)
        end
    end

    if using_old_config then
        vim.schedule(
            function()
                log.warn(messages, true)
            end
        )

        ---@class KimboxConfig
        local new_config = {
            style = cfg.background,
            transparent = cfg.transparent_background,
            term_colors = cfg.disable_terminal_colors,
            ending_tildes = cfg.hide_ending_tildes,
            diagnostics = {background = cfg.diagnostics_text_bg},
            toggle_style = {key = cfg.toggle_style_keymap},
            allow_bold = cfg.allow_bold,
            allow_italic = cfg.allow_italic,
            allow_underline = cfg.allow_underline,
            allow_undercurl = cfg.allow_undercurl,
            allow_reverse = cfg.allow_reverse,
        }

        return new_config
    end

    --  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    local opts = {
        "toggle_style_key",
        "toggle_style_list",
    }

    for _, opt in ipairs(opts) do
        local value = Config[opt]
        if value ~= nil then
            cfg[opt] = value
            using_old_config = true
            messages =
                ([[%s option '%s' has been deprecated.]] ..
                    [[\nLook at README.md for new configuration.]]):format(messages, opt)
        end
    end

    if using_old_config then
        vim.schedule(
            function()
                log.warn(messages, true)
            end
        )

        ---@class KimboxConfig
        local new_config = {
            toggle_style = {
                key = cfg.toggle_style_keymap,
                bgs = cfg.toggle_style_list,
            },
        }

        return new_config
    end
end

return M
