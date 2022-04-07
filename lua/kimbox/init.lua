local M = {}

local g = vim.g
local fn = vim.fn
local cmd = vim.cmd

M.bgs_list = { "medium", "ocean", "vscode", "deep", "darker" }

default_config = {
  -- Main options --
  style = "ocean", -- choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'

  -- TODO: Work on this
  toggle_style_key = "<Leader>ts",
  toggle_style_list = M.bgs_list,

  transparent = false, -- don't set background
  term_colors = true, -- if true enable the terminal

  -- TODO: Work on this
  ending_tildes = false, -- show the end-of-buffer tildes

  -- General formatting --
  allow_bold = true,
  allow_italic = false,
  allow_underline = false,
  allow_undercurl = false,
  allow_reverse = false,

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Related --
  diagnostics = {
    -- TODO: Check this
    background = true, -- use background color for virtual text
  },
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
  cmd("hi clear")
  if fn.exists("syntax_on") then
    cmd("syntax reset")
  end

  vim.o.termguicolors = true
  g.colors_name = "kimbox"

  M.set_options("style", "ocean")

  require("kimbox.highlights").setup()
  require("kimbox.terminal").setup()
end

---Toggle between kimbox styles
function M.toggle()
  local index = g.kimbox_config.toggle_style_index + 1
  if index > #g.kimbox_config.toggle_style_list then
    index = 1
  end

  M.set_options("style", g.kimbox_config.toggle_style_list[index])
  M.set_options("toggle_style_index", index)

  M.load()
end

function M.testing()
  return require("kimbox.colors")
end

---Setup kimbox.nvim options, without applying colorscheme
---@param opts table: a table containing options
function M.setup(opts)
  if not g.kimbox_config or not g.kimbox_config.loaded then -- if it's the first time setup() is called
    g.kimbox_config = vim.tbl_deep_extend(
        "keep", g.kimbox_config or {}, default_config
    )

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
      "n", g.kimbox_config.toggle_style_key,
      [[<cmd>lua require('kimbox').toggle()<CR>]],
      { noremap = true, silent = true }
  )
end

function M.load()
  vim.o.background = "dark"
  vim.api.nvim_command("colorscheme kimbox")
end

return M
