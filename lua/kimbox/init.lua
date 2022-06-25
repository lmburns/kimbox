local M = {}

local util = require("kimbox.util")
local log = util.log

local g = vim.g
local fn = vim.fn
local cmd = vim.cmd

M.bgs_list = {"medium", "ocean", "vscode", "deep", "darker"}

local default_config = {
    -- Main options --
    style = "ocean", -- choose between "medium", "ocean", "vscode", "deep", "darker"
    toggle_style_key = "<Leader>ts",
    toggle_style_list = M.bgs_list,
    -- Used with popup menus (coc.nvim mainly) --
    popup = {
        background = false -- use background color for pmenu
    },
    -- Plugins Related --
    diagnostics = {
        -- TODO: Check this for diagnostics specifically
        background = true -- use background color for virtual text
    },
    -- General formatting --
    allow_bold = true,
    allow_italic = false,
    allow_underline = false,
    allow_undercurl = true,
    allow_reverse = false,
    transparent = false, -- don't set background
    term_colors = true, -- if true enable the terminal
    ending_tildes = false, -- show the end-of-buffer tildes
    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups
    -- Plugins or langauges that can be disabled
    disabled = {
        langs = {},
        plugins = {}
    },
    run_before = nil, -- Run a function before the colorscheme is loaded
    run_after = nil -- Run a function after the colorscheme is loaded
}

---Change kimbox option (g.kimbox_config.option)
---It can't be changed directly by modifing that field due to a Neovim lua bug with global variables (kimbox_config is a global variable)
---@param opt string: option name
---@param value any: new value
function M.set_options(opt, value)
    local cfg = g.kimbox_config
    cfg[opt] = value
    g.kimbox_config = cfg
end

---Apply the colorscheme (same as ':colorscheme kimbox')
function M.colorscheme()
    if g.kimbox_config.run_before ~= nil and type(g.kimbox_config.run_before) == "function" then
        if not pcall(g.kimbox_config.run_before) then
            log.err("failed running 'before' function", true)
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
            log.err("failed running 'after' function", true)
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

---Setup kimbox.nvim options, without applying colorscheme
---@param opts table: a table containing options
function M.setup(opts)
    if not g.kimbox_config or not g.kimbox_config.loaded then -- if it's the first time setup() is called
        g.kimbox_config = vim.tbl_deep_extend("keep", g.kimbox_config or {}, default_config)

        local old_config = require("kimbox.old_config")
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

    vim.api.nvim_set_keymap(
        "n",
        g.kimbox_config.toggle_style_key,
        [[<cmd>lua require('kimbox').toggle()<CR>]],
        {noremap = true, silent = true}
    )
end

---Set the colorscheme
---
---This is exactly the same as simply doing `colorscheme kimbox`
function M.load()
    cmd("colorscheme kimbox")
end

return M
