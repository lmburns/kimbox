local palette = require "kimbox.palette"
local colors = palette.colors
local bgs = palette.bgs

local function select_colors()
  local selected = { none = "none" }

  selected = vim.tbl_extend(
      "force", selected, { bg0 = bgs[vim.g.kimbox_config.style] }
  )

  -- NOTE: In the future, another style could be added
  selected = vim.tbl_extend("force", selected, colors)

  -- Extra user specified colors
  selected = vim.tbl_extend("force", selected, vim.g.kimbox_config.colors)
  return selected
end

return select_colors()
