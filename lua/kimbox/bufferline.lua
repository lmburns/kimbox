local M = {}

---@return KimboxBufferlineConfig
function M.theme()
  return require("bufferline.themes.kimbox")
end

---@return KimboxColors
function M.colors()
  local c = require("kimbox.colors")
  local bgs = require("kimbox.palette").bgs

  return {
    magenta = c.magenta,
    purple = c.purple,
    dbg = bgs.vscode,
    lgb = c.bg4,
    fg = c.operator_base,
    red = c.red,
    dred = c.bg_red,
    green = c.green,
    yellow = c.yellow,
    orange = c.orange,
    blue = c.blue,
    cyan = c.aqua,
    dpurple = c.dpurple
  }
end

return M
