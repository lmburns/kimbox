local M = {}

---@type Kimbox.Config
local cfg = require("kimbox.config").user or vim.g.kimbox_config
---@type Kimbox.Colors
local c = require("kimbox.colors")

function M.setup()
  if not cfg.term_colors then
    return
  end

  vim.g.terminal_color_0 = c.bg0
  vim.g.terminal_color_1 = c.red
  vim.g.terminal_color_2 = c.green
  vim.g.terminal_color_3 = c.yellow
  vim.g.terminal_color_4 = c.blue
  vim.g.terminal_color_5 = c.purple
  vim.g.terminal_color_6 = c.aqua
  vim.g.terminal_color_7 = c.bg5
  vim.g.terminal_color_8 = c.bg0
  vim.g.terminal_color_9 = c.red
  vim.g.terminal_color_10 = c.green
  vim.g.terminal_color_11 = c.yellow
  vim.g.terminal_color_12 = c.blue
  vim.g.terminal_color_13 = c.purple
  vim.g.terminal_color_14 = c.aqua
  vim.g.terminal_color_15 = c.fg0
end

return M
