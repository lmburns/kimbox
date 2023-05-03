local M = {}

local fn = vim.fn
local api = vim.api

M.bg = "#000000"
M.fg = "#ffffff"

---@alias KimboxLogLevels { TRACE: 0, DEBUG: 1, INFO: 2, WARN: 3, ERROR: 4, OFF: 5 }

M.log = {
    ---@type KimboxLogLevels
    levels = vim.log.levels,
}

---Determine whether the user haas Neovim 0.8
---@return fun(): boolean
M.has08 = (function()
    local has08
    return function()
        -- local version_t = {
        --     vim.version().major,
        --     vim.version().minor,
        --     vim.version().patch,
        -- }
        -- local version = vim.version.parse(("%s.%s.%s"):format(unpack(version_t)))
        -- has08 = vim.version.gt(version, '0.8')

        if has08 == nil then
            -- has08 = vim.version.gt('0.8', vim.version())
            has08 = fn.has("nvim-0.8") == 1
        end
        return has08
    end
end)()

---Determine whether the user haas Neovim 0.9
---@return fun(): boolean
M.has09 = (function()
    local has09
    return function()
        if has09 == nil then
            has09 = fn.has("nvim-0.9") == 1
        end
        return has09
    end
end)()

---Determine whether the user has `api.nvim_set_hl`
---@return fun(): boolean
M.has_api = (function()
    local has_api
    return function()
        if has_api == nil then
            has_api = fn.has("nvim-0.7") == 1 and type(api.nvim_set_hl) == "function"
        end
        return has_api
    end
end)

---BUG: There is a bug in the API that returns true as a key in the table
---https://github.com/neovim/neovim/issues/18024
---It is fixed now, in Neovim 0.7.2
---@return fun(): boolean
M.needs_api_fix = (function()
    local needs_api_fix
    return function()
        if needs_api_fix == nil then
            needs_api_fix = fn.has("nvim-0.7.2") == 0
        end
        return needs_api_fix
    end
end)

---Echo a message with `nvim_echo`
---@param msg string message
---@param hl string highlight group
M.echomsg = function(msg, hl)
    hl = hl or "Title"
    api.nvim_echo({{msg, hl}}, true, {})
end

---Display notification message
---@param msg string
---@param level number
---@param opts table?
M.notify = function(msg, level, opts)
    opts = vim.tbl_extend("force", opts or {}, {title = "kimbox"})
    if opts.once then
        vim.notify_once(msg, level, opts)
    else
        vim.notify(msg, level, opts)
    end
end

---`INFO` message
---@param msg string
---@param notify boolean?
---@param opts table?
M.log.info = function(msg, notify, opts)
    if notify then
        M.notify(msg, M.log.levels.INFO, opts)
    else
        M.echomsg(("[INFO]: %s"):format(msg), "Directory")
    end
end

---`WARN` message
---@param msg string
---@param notify boolean?
---@param opts table?
M.log.warn = function(msg, notify, opts)
    if notify then
        M.notify(msg, M.log.levels.WARN, opts)
    else
        M.echomsg(("[WARN]: %s"):format(msg), "WarningMsg")
    end
end

---`ERROR` message
---@param msg string
---@param notify boolean?
---@param opts table?
M.log.err = function(msg, notify, opts)
    if notify then
        M.notify(msg, M.log.levels.ERROR, opts)
    else
        M.echomsg(("[ERR]: %s"):format(msg), "ErrorMsg")
    end
end

---Return a default value if `x` is nil
---@generic T, V
---@param x T Value to check if not `nil`
---@param default V Default value to return if `x` is `nil`
---@return T | V
M.get_default = function(x, default)
    return M.ife_nil(x, default, x)
end

---Similar to `vim.F.nil` except that an alternate default value can be given
---@generic T, V
---@param x any Value to check if `nil`
---@param is_nil T Value to return if `x` is `nil`
---@param is_not_nil V Value to return if `x` is not `nil`
---@return T | V
M.ife_nil = function(x, is_nil, is_not_nil)
    if x == nil then
        return is_nil
    else
        return is_not_nil
    end
end

---Return one of two values based on a conditional
---@generic T, V
---@param condition? boolean|fun():boolean Statement to be tested
---@param is_if T Return if condition is truthy
---@param is_else V Return if condition is not truthy
---@return T | V
M.tern = function(condition, is_if, is_else)
    if condition then
        return is_if
    else
        return is_else
    end
end

---Check if `string` is empty or `nil`
---@param str string
---@return boolean
M.is_empty = function(str)
    return str == "" or str == nil
end

---Get the latest messages from `messages` command
---@param count number? of messages to get
---@param str boolean whether to return as a string or table
---@return string
M.messages = function(count, str)
    local messages = fn.execute("messages")
    local lines = vim.split(messages, "\n")
    lines = vim.tbl_filter(
        function(line)
            return line ~= ""
        end,
        lines
    )
    count = count and tonumber(count) or nil
    count = (count ~= nil and count >= 0) and count - 1 or #lines
    local slice = vim.list_slice(lines, #lines - count)
    return str and table.concat(slice, "\n") or slice
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                          Colors                          │
-- ╰──────────────────────────────────────────────────────────╯

---Convert a hex color (i.e., `#FFFFFF`) into an RGB(255, 255, 255)
---@param hex HexColor
---@return KimboxRGB
M.hex2rgb = function(hex)
    local p = "[abcdef0-9][abcdef0-9]"
    local pat = ("^#(%s)(%s)(%s)$"):format(p, p, p)

    hex = hex:lower()
    assert(hex:match(pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex))

    local r, g, b = hex:match(pat)

    return {
        tonumber(r, 16),
        tonumber(g, 16),
        tonumber(b, 16),
    }
end

---
---@param fg HexColor foreground color
---@param bg HexColor background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
---@return HexColor
M.blend = function(fg, bg, alpha)
    local bg_rgb = M.hex2rgb(bg)
    local fg_rgb = M.hex2rgb(fg)

    local blend_channel = function(i)
        local ret = (alpha * fg_rgb[i] + ((1 - alpha) * bg_rgb[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return ("#%02X%02X%02X"):format(blend_channel(1), blend_channel(2), blend_channel(3))
end

---
---@param hex HexColor Color to blend
---@param amount number Number between 0 and 1. 0 results in bg, 1 results in fg
---@param bg? HexColor Background color
---@return HexColor
M.darken = function(hex, amount, bg)
    return M.blend(hex, bg or M.bg, math.abs(amount))
end

---
---@param hex HexColor Color to blend
---@param amount number Number between 0 and 1. 0 results in bg, 1 results in fg
---@param fg? HexColor Foreground color
---@return HexColor
M.lighten = function(hex, amount, fg)
    return M.blend(hex, fg or M.fg, math.abs(amount))
end

---Convert a `gui=...` into valid arguments for `api.nvim_set_hl`
---@param style string
---@return table
M.convert_gui = function(style)
    if not style or style:lower() == "none" then
        return {}
    end

    local gui = {}
    style = style:lower()
    for token in style:gmatch("([^,]+)") do
        gui[token] = true
    end

    return gui
end

---Highlight using Vim's language
---@param highlights KimboxHighlightMap
local function vim_highlights(highlights)
    ---@type KimboxHighlightMap
    local to_highlight = {}
    for group, opts in pairs(highlights) do
        if opts.link then
            table.insert(to_highlight, ("highlight! link %s %s"):format(group, opts.link))
        else
            table.insert(
                to_highlight,
                ("hi %s guifg=%s guibg=%s guisp=%s gui=%s"):format(
                    group,
                    opts.fg or "none",
                    opts.bg or "none",
                    opts.sp or "none",
                    opts.gui or "none"
                )
            )
        end
    end

    vim.cmd(table.concat(to_highlight, "\n"))
end

---Highlight using the Nvim API
---@param highlights KimboxHighlightMap
local function nvim_highlights(highlights)
    for group, opts in pairs(highlights) do
        if not M.is_empty(opts.link) then
            api.nvim_set_hl(0, group, {link = opts.link})
        else
            local values = M.convert_gui(opts.gui)
            values.bg = opts.bg
            values.fg = opts.fg
            values.sp = opts.sp
            api.nvim_set_hl(0, group, values)
        end
    end
end

local function get_hl(name)
    local ret
    if M.has09() then
        ret = api.nvim_get_hl(0, {name = name})
    else
        ret = api.nvim_get_hl_by_name(name, true)
    end
    return {}
end

---@class KimboxHighlight
---@operator call(KimboxHighlightMap): nil
---@field alt fun(h: KimboxHighlightMap)
M.highlight =
    setmetatable(
        {
            alt = vim_highlights,
        },
        {
            ---
            ---@param _ KimboxHighlight
            ---@param ... KimboxHighlightMap
            __call = function(_, ...)
                local hl = M.tern(M.has_api(), nvim_highlights, vim_highlights)
                hl(...)
            end,
        }
    )

return M
