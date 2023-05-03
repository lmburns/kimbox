local palette = require("kimbox.palette")
local colors = palette.colors
local bgs = palette.bgs

---Shortcut for `vim.tbl_extend` in this file
---@generic T table<string, string>
---@param original T
---@param to_add T
---@return T
local function extend(original, to_add)
    return vim.tbl_extend("force", original, to_add)
end

---Merge theme colors with user configured colors
---@return KimboxColors
return (function()
    local selected = {}
    -- An alternative is given in case this file is
    -- required before the theme is loaded by the plugin manager
    local conf = vim.g.kimbox_config or {}

    selected = extend(selected, {bg0 = bgs[conf.style or "ocean"]})
    -- Default colors
    selected = extend(selected, colors)
    selected = extend(selected, bgs)
    -- Extra user specified colors
    selected = extend(selected, conf.colors or {})

    return selected
end)()
