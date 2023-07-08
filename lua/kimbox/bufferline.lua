local M = {}

---@return Kimbox.BufferlineConfig
function M.theme()
  return require("bufferline.themes.kimbox")
end

---@return Kimbox.Colors|{[string]: Kimbox.Color.S_t}
function M.colors()
  local c = require("kimbox.colors")
  return {
    fg = c.fg4,
    bg = c.vscode,
    active = c.bg4,

    magenta = c.magenta,
    purple = c.purple,
    red = c.red,
    teaberry = c.teaberry,
    green = c.green,
    yellow = c.yellow,
    orange = c.orange,
    blue = c.blue,
    aqua = c.aqua,
    amaranth_purple = c.amaranth_purple,

    sea_green = c.sea_green,
    russian_green = c.russian_green,
    jade_green = c.jade_green,
    deep_lilac = c.deep_lilac,
    drama_violet = c.drama_violet,
    vista_blue = c.vista_blue,
    ube = c.ube,
    oni_violet = c.oni_violet,
    puce = c.puce,
    salmon = c.salmon,
    infra_red = c.infra_red,
    wave_red = c.wave_red,
    peach_red = c.peach_red,
    surimi_orange = c.surimi_orange,
    fuzzy_wuzzy = c.fuzzy_wuzzy,
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
