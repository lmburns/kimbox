local M = {}

---@return KimboxBufferlineConfig
function M.theme()
  return require("bufferline.themes.kimbox")
end

---@return KimboxColors
function M.colors()
  local c = require("kimbox.colors")
  local z = bufnr

  return {
    bg4 = c.bg4,
    fg0 = c.fg4,
    vscode = c.vscode,
    magenta = c.magenta,
    purple = c.purple,
    red = c.red,
    bg_red = c.bg_red,
    green = c.green,
    yellow = c.yellow,
    orange = c.orange,
    blue = c.blue,
    aqua = c.aqua,
    maximum_purple = c.maximum_purple,

    sea_green = c.sea_green,
    -- russian_green = "#689D6A",
    -- jade_green = "#2AB074",
    deep_lilac = c.deep_lilac,
    opera_muave = c.opera_muave,
    vista_blue = c.vista_blue,
    ube = c.ube,
    oni_violet = c.oni_violet,
    puce = c.puce,
    salmon = c.salmon,
    infra_red = c.infra_red,
    wave_red = c.wave_red,
    peach_red = c.peach_red,
    surimi_orange = c.surimi_orange,
    light_red = c.light_red,
    middle_green_yellow = c.middle_green_yellow,
    deep_saffron = c.deep_saffron,
    coconut = c.coconut,
    russet = c.russet,
    grullo_grey = c.grullo_grey,
    philippine_silver = c.philippine_silver,
    beaver = c.beaver,
  }
end

return M
