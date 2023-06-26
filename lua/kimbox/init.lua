local M = {}

local Config = require("kimbox.config")
local utils = require("kimbox.utils")
local log = utils.log

local g = vim.g
local fn = vim.fn
local cmd = vim.cmd

---Here for legacy reasons
M.KimboxBgColors = Config.bg_colors

---Setup Kimbox
---@param opts KimboxConfig
function M.setup(opts)
    if Config.__loaded then
        return
    end

    M.__conf = opts or g.kimbox_config or {}
    Config.init()
end

---Apply the colorscheme
function M.load()
    if g.colors_name then
        cmd.hi("clear")
    end
    if fn.exists("syntax_on") then
        cmd.syntax("reset")
    end

    g.colors_name = "kimbox"
    vim.o.termguicolors = true
end

---Here for legacy reasons
M.colorscheme = M.load

---Toggle between Kimbox styles
function M.toggle()
    if not Config.__did_hl then
        log.err("the colorscheme must be setup first")
        return
    end

    Config:toggle()
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

---@alias KimboxRGB { [1]: number, [2]: number, [3]: number }
---@alias HexColor string A string that starts with a '#' followed by 6 hexadecimal digits
---@alias ColorName string A string that represents the name (closest) matching the HexColor
---@alias KimboxColors KimboxFGs|KimboxBGs Collection of keys (color name) & values (HexColor)

---@alias KimboxCtermMap
---| '"bold"'
---| '"underline"'
---| '"undercurl"' # Curly underline
---| '"underdouble"' # Double underline
---| '"underdotted"' # Dotted underline
---| '"underdashed"' # Dashed underline
---| '"strikethrough"'
---| '"reverse"'
---| '"inverse"' # Same as revers
---| '"italic"'
---| '"standout"'
---| '"altfont"'
---| '"nocombine"' # Override attributes instead of combining them
---| '"none"' # No attributes used (used to reset it)

---@class KimboxHighlightMap
---@field fg ColorName|HexColor
---@field bg ColorName|HexColor
---@field sp ColorName|HexColor
---@field foreground ColorName|HexColor
---@field background ColorName|HexColor
---@field special ColorName|HexColor
---@field blend number 0 to 100
---@field bold boolean
---@field standout boolean
---@field underline boolean
---@field undercurl boolean Curly underline
---@field underdouble boolean Double underline
---@field underdotted boolean Dotted underline
---@field underdashed boolean Dashed underline
---@field strikethrough boolean
---@field italic boolean
---@field reverse boolean
---@field nocombine boolean Override attributes instead of combining them
---@field link ColorName|HexColor Name of another highlight group to link to
---@field default boolean Don't override existing definition
---@field ctermfg string Sets foreground of cterm color
---@field ctermbg string Sets background of cterm color
---@field cterm KimboxCtermMap cterm attribute map
---@field gui string Not here by default. Allows a string sep. by comma of GUI attrs

return M
