local c = require("kimbox.colors")

-- local colors = {
--   black = "#291804",
--   red = "#DC3958",
--   red2 = "#EF1D55",
--   green = "#819C3B",
--   yellow = "#FF9500",
--   orange = "#FF5813",
--   blue = "#4C96A8",
--   magenta = "#A06469",
--   purple = "#98676A",
--   cyan = "#7EB2B1",
--   white = "#e8c097",
--   fg = "#D9AE80",
--   bg = "#221a02",
--   gray1 = "#a89984",
--   brown1 = "#7E602C",
--   brown2 = "#5e452b",
--   brown3 = "#362712",
-- }

local colors = {
  red = c.bg_red,
  bred = c.red,
  green = c.green,
  yellow = c.yellow,
  orange = c.orange,
  blue = c.blue,
  magenta = c.magenta,
  purple = c.purple,
  cyan = c.aqua,

  white = c.operator_base05,
  fg = c.fg1,
  bg = c.bg.ocean,
  dbg = c.bg3,
  grey = c.grey2,
  brown1 = c.fg1,
  brown2 = c.fg2,
  brown3 = c.bg2,
}

local kimbox = {
  normal = {
    a = { fg = colors.purple, bg = colors.bg, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.brown3 },
    x = { fg = colors.fg, bg = colors.bg },
  },
  command = {
    a = { fg = colors.blue, bg = colors.bg, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.brown3 },
    x = { fg = colors.fg, bg = colors.bg },
  },
  inactive = {
    a = { fg = colors.red, bg = colors.bg },
    b = { fg = colors.magenta, bg = colors.bg },
  },
  insert = {
    a = { fg = colors.green, bg = colors.bg, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.brown3 },
    x = { fg = colors.fg, bg = colors.bg },
  },
  replace = {
    a = { fg = colors.red, bg = colors.bg, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.brown3 },
    x = { fg = colors.fg, bg = colors.bg },
  },
  terminal = { a = { fg = colors.yellow, bg = colors.bg, gui = "bold" } },
  visual = {
    a = { fg = colors.orange, bg = colors.bg, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.brown3 },
    x = { fg = colors.fg, bg = colors.bg },
  },
}

return kimbox
