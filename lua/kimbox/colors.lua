local palette = require("kimbox.palette")
local colors = palette.colors
local bgs = palette.bgs

---Shortcut for `vim.tbl_extend` in this file
---@generic T { [string]: string }
---@param original T
---@param to_add T
---@return T
local function extend(original, to_add)
    return vim.tbl_extend("force", original, to_add)
end

---Merge theme colors with user configured colors
---@return KimboxColors
return (function()
    local selected = {none = "none"}

    selected = extend(selected, {bg0 = bgs[vim.g.kimbox_config.style]})
    -- NOTE: In the future, another style could be added
    selected = extend(selected, colors)
    -- Extra user specified colors
    selected = extend(selected, vim.g.kimbox_config.colors)

    return selected
end)()
