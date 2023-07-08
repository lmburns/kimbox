local M = {}

---@return Kimbox.LualineConfig
function M.theme()
  return require("lualine.themes.kimbox")
end

---@return Kimbox.Colors|{[string]: string}
function M.colors()
  local c = require("kimbox.colors")
  return {
    fg = c.fg0,
    bg = c.bg0,
    bg2 = c.bg2,
    grullo_grey = c.grullo_grey,
    red = c.teaberry,
    red2 = c.red,
    green = c.green,
    yellow = c.yellow,
    orange = c.orange,
    blue = c.blue,
    magenta = c.magenta,
    purple = c.purple,
    cyan = c.aqua,
    salmon = c.salmon,
  }
end

return M
