local M = {}

local utils = require("kimbox.utils")
local log = utils.log

local g = vim.g
local fn = vim.fn
local cmd = vim.cmd

---@alias KimboxRGB { [1]: number, [2]: number, [3]: number }
---@alias HexColor string A string that starts with a '#' followed by 6 hexadecimal digits
---@alias ColorName string A string that represents the name (closest) matching the HexColor
---@alias KimboxColors { [ColorName]: HexColor } Collection of keys (color name) & values (HexColor)

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

M.KimboxBgColors = {
    "medium",
    "ocean",
    "vscode",
    "deep",
    "darker",
    "eerie"
}

---@class KimboxConfig
local default_config = {
    --  ╭──────────────╮
    --  │ Main options │
    --  ╰──────────────╯
    style = "ocean",
    toggle_style_key = "<Leader>ts",
    toggle_style_list = M.KimboxBgColors,
    -- New Lua-Treesitter highlight groups
    -- Location where Treesitter capture groups changed to '@capture.name'
    -- Commit:    030b422d1
    -- Vim patch: patch-8.2.0674
    langs08 = utils.tern(utils.has08(), true, false),
    -- Used with popup menus (coc.nvim mainly) --
    popup = {
        background = false -- use background color for pmenu
    },
    --  ╭─────────────────╮
    --  │ Plugins Related │
    --  ╰─────────────────╯
    diagnostics = {
        -- TODO: Check this for diagnostics specifically
        background = true -- use background color for virtual text
    },
    --  ╭────────────────────╮
    --  │ General formatting │
    --  ╰────────────────────╯
    allow_bold = true,
    allow_italic = false,
    allow_underline = false,
    allow_undercurl = true,
    allow_reverse = false,
    transparent = false, -- don't set background
    term_colors = true, -- if true enable the terminal
    ending_tildes = false, -- show the end-of-buffer tildes
    --  ╭───────────────────╮
    --  │ Custom Highlights │
    --  ╰───────────────────╯
    ---Override default colors
    ---@type table<string, string>
    colors = {},
    ---Override highlight groups
    ---@type table<string, KimboxHighlightMap>
    highlights = {},
    ---Plugins or langauges that can be disabled
    ---To view options: print(require("kimbox.highlights").{langs,langs08,plugins})
    ---@type {langs: string[], langs08: string[], plugins: string[]}
    disabled = {
        ---Disabled languages
        ---@see KimboxHighlightLangs
        langs = {},
        ---Disabled languages with '@' treesitter highlights
        ---@see KimboxHighlightLangs08
        langs08 = {},
        ---Disabled plugins
        ---@see KimboxHighlightPlugins
        plugins = {}
    },
    ---Run a function before the colorscheme is loaded
    ---@type fun(): nil
    run_before = nil,
    ---Run a function after the colorscheme is loaded
    ---@type fun(): nil
    run_after = nil
}

---Change kimbox option (`g.kimbox_config.option`)
---@param opt string option name
---@param value any new value
function M.set_options(opt, value)
    local cfg = g.kimbox_config
    cfg[opt] = value
    g.kimbox_config = cfg
end

---Apply the colorscheme (same as `:colorscheme kimbox`)
function M.colorscheme()
    if g.kimbox_config.run_before ~= nil and type(g.kimbox_config.run_before) == "function" then
        if not pcall(g.kimbox_config.run_before) then
            log.err("failed running 'run_before' function", true)
        end
    end

    cmd("hi clear")
    if fn.exists("syntax_on") then
        cmd("syntax reset")
    end

    vim.o.termguicolors = true
    g.colors_name = "kimbox"

    M.set_options("style", g.kimbox_config.style)

    require("kimbox.highlights").setup()
    require("kimbox.terminal").setup()

    if g.kimbox_config.run_after ~= nil and type(g.kimbox_config.run_after) == "function" then
        if not pcall(g.kimbox_config.run_after) then
            log.err("failed running 'run_after' function", true)
        end
    end
end

---Toggle between kimbox styles
function M.toggle()
    local index = g.kimbox_config.toggle_style_index + 1
    if index > #g.kimbox_config.toggle_style_list then
        index = 1
    end

    M.set_options("style", g.kimbox_config.toggle_style_list[index])
    M.set_options("toggle_style_index", index)

    vim.o.background = "dark"
    cmd("colorscheme kimbox")
end

---Setup `kimbox.nvim` options, without applying colorscheme
---@param opts KimboxConfig
function M.setup(opts)
    -- if it's the first time setup() is called
    if not g.kimbox_config or not g.kimbox_config.loaded then
        g.kimbox_config = vim.tbl_deep_extend("keep", g.kimbox_config or {}, default_config)

        local old_config = require("kimbox.old_config").load()
        if old_config then
            opts = old_config
        end

        M.set_options("loaded", true)
        M.set_options("toggle_style_index", 0)
    end

    if opts then
        g.kimbox_config = vim.tbl_deep_extend("force", g.kimbox_config, opts)
        if opts.toggle_style_list then -- this table cannot be extended, it has to be replaced
            M.set_options("toggle_style_list", opts.toggle_style_list)
        end
    end

    if not utils.is_empty(g.kimbox_config.toggle_style_key) then
        vim.keymap.set(
            "n",
            g.kimbox_config.toggle_style_key,
            [[<cmd>lua require('kimbox').toggle()<CR>]],
            {noremap = true, silent = true}
        )
    end
end

---Set the colorscheme
---
---This is exactly the same as simply doing `colorscheme kimbox`
function M.load()
    cmd("colorscheme kimbox")
end

return M
