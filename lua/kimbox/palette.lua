---@type KimboxColors
local bgs = {
    medium = "#231A0C",
    ocean = "#221A02",
    vscode = "#221A0F",
    deep = "#0F111B",
    darker = "#291804",
    eerie = "#1C0B28"
}

---@type KimboxColors
local fgs = {
    bg1 = "#39260E",
    bg2 = "#362712",
    bg3 = bgs.darker,
    bg4 = "#5E452B",
    bg5 = "#271e02",
    --
    fg0 = "#D9AE80",
    fg1 = "#7E602C",
    fg2 = "#5E452B",
    fg3 = "#C2A383",
    fg4 = "#E8C097",
    ---------------------------------------------------------------------------------------------
    black = "#000000",
    red = "#EF1D55",
    magenta = "#A06469",
    orange = "#FF5813",
    green = "#819C3B",
    yellow = "#FF9500",
    aqua = "#7EB2B1",
    blue = "#4C96A8",
    purple = "#98676A",
    --
    philippine_green = "#088649",
    sea_green = "#77A172",
    russian_green = "#689D6A",
    jade_green = "#2AB074",
    morning_blue = "#83A598",
    jelly_bean_blue = "#418292",
    slate_grey = "#719190",
    tuscan_red = "#7E5053",
    purple_taupe = "#4F3552",
    maximum_purple = "#733E8B",
    deep_lilac = "#A25BC4", -- "#945EB8"
    opera_muave = "#BB80B3",
    heliotrope = "#D484FF",
    vista_blue = "#7E9CD8",
    ube = "#7E82CC",
    amethyst = "#938AA9",
    oni_violet = "#957FB8",
    old_rose = "#BD798B",
    puce = "#D3869B",
    salmon = "#EA6962",
    wave_red = "#E46876",
    peach_red = "#FF5D62",
    infra_red = "#F14A68",
    pumpkin = "#FE8019",
    surimi_orange = "#FFA066",
    jasper_orange = "#E78A4E",
    bg_red = "#DC3958",
    light_red = "#CC6666",
    ---------------------------------------------------------------------------------------------
    maroon_x11 = "#A43A57",
    watermelon = "#EC5F91",
    begonia = "#FF747C",
    middle_green_yellow = "#A3B95A",
    deep_saffron = "#F79A32",
    dark_electric_blue = "#586081",
    coconut = "#9A5534",
    russet = "#79491d",
    ---------------------------------------------------------------------------------------------
    -- These are duplicates because they are both used and could be changed at some point
    coyote_brown = "#7E602C",
    coyote_brown1 = "#7E602C",
    grullo_grey = "#A89984",
    philippine_silver = "#B2B2B2",
    wenge_grey = "#625A5A",
    beaver = "#A0936A",
    light_taupe = "#AF8D6E",
    ---------------------------------------------------------------------------------------------
    diff_add = "#445321", -- "#4c5c25",
    diff_delete = "#961134",
    diff_change = "#543739",
    diff_text = "#325C59" -- "#335250" "#405453"
}

return {
    colors = fgs,
    bgs = bgs
}
