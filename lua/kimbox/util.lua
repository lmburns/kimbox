local M = {}

local api = vim.api

M.bg = "#000000"
M.fg = "#ffffff"

M.log = {
    levels = vim.log.levels
}

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
---@param opts table
M.notify = function(msg, level, opts)
    opts = vim.tbl_extend("force", opts or {}, {title = "kimbox"})
    vim.notify(msg, level, opts)
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

---Convert a hex color (i.e., `#FFFFFF`) into an RGB(255, 255, 255)
---@param hex string
---@return number
---@return number
---@return number
function M.hexToRgb(hex)
    local p = "[abcdef0-9][abcdef0-9]"
    local pat = ("^#(%s)(%s)(%s)$"):format(p, p, p)

    hex = hex:lower()
    assert(hex:match(pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex))

    local r, g, b = hex:match(pat)

    return {
        tonumber(r, 16),
        tonumber(g, 16),
        tonumber(b, 16)
    }
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(fg, bg, alpha)
    bg = M.hexToRgb(bg)
    fg = M.hexToRgb(fg)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg)
    return M.blend(hex, bg or M.bg, math.abs(amount))
end

function M.lighten(hex, amount, fg)
    return M.blend(hex, fg or M.fg, math.abs(amount))
end

return M
