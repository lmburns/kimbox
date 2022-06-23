local M = {}

-- ========================== Lualine ==========================

function M.theme()
  return require("lualine.themes.kimbox")
end

function M.colors()
  local c = require("kimbox.colors")
  return {
    black = c.bg0,
    red = c.bg_red,
    red2 = c.red,
    green = c.green,
    yellow = c.yellow,
    orange = c.orange,
    blue = c.blue,
    magenta = c.magenta,
    purple = c.purple,
    cyan = c.aqua,
    salmon = c.salmon,
    white = c.operator_base05,
    fg = c.fg0,
    bg = c.bg0,
    gray1 = c.grey2,
    brown1 = c.fg1,
    brown2 = c.bg4,
    brown3 = c.bg2,
  }
end

return M
