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
---@param opts Kimbox.Config
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

---@alias Kimbox.Colors     Kimbox.FG|Kimbox.BG   collection of keys (color name) & values as a hex string
---@alias Kimbox.Color.S_t  string                a color's hex representation as a string
---@alias Kimbox.Color.N_t  integer               a color's hex representation as a number

---@class Kimbox.Color.RGB_t
---@field r integer red channel
---@field g integer green channel
---@field b integer blue channel

---@alias Kimbox.Highlight.Group string  the highlight group name

---@class Kimbox.Highlight.Attr
---@field from string origin highlight group
---@field alter float number to alter by
---@field attr "'foreground'"|"'fg'"|"'background'"|"'bg'"|"'special'"|"'sp'"

---@alias Kimbox.Color_t string|integer|"'NONE'"|Kimbox.Highlight.Attr|fun():string|Kimbox.Highlight.Attr

---@class Kimbox.Highlight_t
---@field default       boolean         don't override existing definition
---@field fg            Kimbox.Color_t  foreground attribute
---@field bg            Kimbox.Color_t  background attribute
---@field sp            Kimbox.Color_t  special attribute
---@field foreground    Kimbox.Color_t  foreground attribute
---@field background    Kimbox.Color_t  background attribute
---@field special       Kimbox.Color_t  special attribute
---@field blend         number          0 to 100
---@field bold          boolean         bolden text for the highlight attribute
---@field standout      boolean         possibly similar to `bold`?
---@field underline     boolean         normal underline attribute
---@field undercurl     boolean         curled underline attribute
---@field underdouble   boolean         double underline attribute
---@field underdotted   boolean         dotted underline attribute
---@field underdashed   boolean         dashed underline attribute
---@field strikethrough boolean         strike through highlight attribute
---@field italic        boolean         italicize text for the highlight attribute
---@field reverse       boolean         reverse highlight attribute
---@field nocombine     boolean         override attributes instead of combining them
---@field link          boolean|string  link highlight group to another
---@field ctermfg       string          sets foreground of cterm color
---@field ctermbg       string          sets background of cterm color
---@field cterm         Kimbox.Cterm.Kind cterm attribute map
---@field inherit       string          (extra) inherit color information from an already defined highlight group
---@field build         boolean         (extra) keep color attributes to build upon. (equiv: `val = {inherit='val'}`)
---@field gui           string          (extra) accept old GUI strings
---@field cond          string          (extra) conditional colorscheme name
---@field guifg         string          @deprecated foreground
---@field guibg         string          @deprecated background
---@field guisp         string          @deprecated special

---@alias Kimbox.Highlight.Kind
---| '"default"'       don't override existing definition
---| '"fg"'            foreground attribute
---| '"bg"'            background attribute
---| '"sp"'            special attribute
---| '"foreground"'    foreground attribute
---| '"background"'    background attribute
---| '"special"'       special attribute
---| '"bold"'          bolden text for the highlight attribute
---| '"standout"'      possibly similar to `bold`?
---| '"underline"'     normal underline attribute
---| '"undercurl"'     curled underline attribute
---| '"underdouble"'   double underline attribute
---| '"underdotted"'   dotted underline attribute
---| '"underdashed"'   dashed underline attribute
---| '"strikethrough"' strike through highlight attribute
---| '"italic"'        italicize text for the highlight attribute
---| '"reverse"'       reverse highlight attribute
---| '"nocombine"'     override attributes instead of combining them
---| '"link"'          link highlight group to another
---| '"ctermfg"'       cterm foreground
---| '"ctermbg"'       cterm background
---| '"inherit"'       [CUSTOM]: inherit color information from an already defined highlight group
---| '"build"'         [CUSTOM]: keep color attributes to build upon. (equiv: `val = {inherit='val'}`)
---| '"gui"'           [CUSTOM]: accept old GUI strings
---| '"cond"'          [CUSTOM]: conditional colorscheme name
---| '"guifg"'         @deprecated foreground
---| '"guibg"'         @deprecated background
---| '"guisp"'         @deprecated special

---@class Kimbox.Highlight.Map
---@field [string] Kimbox.Highlight_t

---@alias Kimbox.Cterm.Kind
---| '"bold"'
---| '"underline"'
---| '"undercurl"'     curly underline
---| '"underdouble"'   double underline
---| '"underdotted"'   dotted underline
---| '"underdashed"'   dashed underline
---| '"strikethrough"'
---| '"reverse"'
---| '"inverse"'       same as reverse
---| '"italic"'
---| '"standout"'
---| '"altfont"'
---| '"nocombine"'     override attributes instead of combining them
---| '"none"'          no attributes used (used to reset it)

---@class Kimbox.Highlight.Gui.Attr
---@field bold boolean
---@field italic boolean
---@field underline boolean
---@field undercurl boolean
---@field underdouble boolean
---@field underdotted boolean
---@field underdashed boolean
---@field strikethrough boolean

return M
