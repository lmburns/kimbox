local M = {}

---@return KimboxLualineConfig
function M.theme()
  return require("lualine.themes.kimbox")
end

---@return KimboxColors
function M.colors()
  local c = require("kimbox.colors")
  return {
    bg0 = c.bg0,
    fg0 = c.fg0,
    fg1 = c.fg1,
    bg4 = c.bg4,
    bg2 = c.bg2,
    grullo_grey = c.grullo_grey,
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
    white = c.fg4,
  }
end

return M
