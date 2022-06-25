---Wezterm colors for the Kimbox theme
-- @module kimbox.wezterm
-- @author Lucas Burns
-- @license MIT

-- These colors are not setup to where the 'blue' color is actually blue
-- Instead they are setup in a way to make the visual appearance the best

return {
    force_reverse_video_cursor = true,
    colors = {
        foreground = "#c2a383",
        background = "#221a02",

        cursor_fg = "#221a02",
        cursor_bg = "#f79a32",
        cursor_border = "#f79a32",

        selection_fg = "#221a02",
        selection_bg = "#889b4a",

        scrollbar_thumb = "#c2a383",
        split = "#4c96a8",

        ansi = {
            "#201f1f",
            "#dc3958",
            "#819c3b",
            "#f79a32",
            "#733e8b",
            "#7e5053",
            "#088649",
            "#a89983",
        },
        brights = {
            "#676767",
            "#f14a68",
            "#a3b95a",
            "#f79a32",
            "#dc3958",
            "#fe8019",
            "#4c96a8",
            "#51412c",
        },
        indexed = {
            [16] = "#83a598",
            [17] = "#ea6962",
            [18] = "#418292",
            [19] = "#7E602C",
        },
    },
}
