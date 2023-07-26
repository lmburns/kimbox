local utils = require("kimbox.utils")
local log = utils.log

local cmd = vim.cmd
local api = vim.api

local DEFAULT_STYLE = "cannon"
local DEFAULT_TOGGLE_KEY = "<Leader>ts"

---@class Kimbox.Container
---@field user Kimbox.Config
---@field group integer Autocmd id
---@field __did_hl boolean
---@field __loaded boolean
local Config = {
    user = {},
    __loaded = false,
    __did_hl = false,
}
Config.__index = Config

Config.bg_colors = {
    "burnt_coffee", -- medium
    "cannon",       -- ocean
    "used_oil",     -- vscode
    "deep",
    "zinnwaldite",  -- darker
    "eerie",
}

---@class Kimbox.Config
---@field toggle_style.index integer
local default = {
    ---Background color:
    ---    burnt_coffee : #231A0C   -- legacy: "medium"
    ---    cannon       : #221A02   -- legacy: "ocean"
    ---    used_oil     : #221A0F   -- legacy: "vscode"
    ---    deep         : #0F111B
    ---    zinnwaldite  : #291804   -- legacy: "darker"
    ---    eerie        : #1C0B28
    style = DEFAULT_STYLE,
    ---Allow changing background color
    toggle_style = {
        ---Key used to cycle through the backgrounds in `toggle_style.bgs`
        key = DEFAULT_TOGGLE_KEY,
        ---List of background names
        bgs = Config.bg_colors,
    },
    ---New Lua-Treesitter highlight groups
    ---  Location where Treesitter capture groups changed to '@capture.name'
    ---  Commit:    030b422d1
    ---  Vim patch: patch-8.2.0674
    langs08 = utils.tern(utils.has08(), true, false),
    ---Used with popup menus (coc.nvim mainly) --
    popup = {
        background = false, -- use background color for PMenu
    },
    -- ━━━ Plugin Related ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    diagnostics = {
        -- TODO: Check this for diagnostics specifically
        background = true, -- use background color for virtual text
    },
    -- ━━━ General Formatting ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    allow_bold = true,
    allow_italic = false,
    allow_underline = false,
    allow_undercurl = true,
    allow_reverse = false,
    transparent = false,   -- don't set background
    term_colors = true,    -- if true enable the terminal
    ending_tildes = false, -- show the end-of-buffer tildes
    -- ━━━ Custom Highlights ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ---Override default colors
    ---@type table<Kimbox.Color.S_t, string>
    colors = {},
    ---Override highlight groups
    ---@type Kimbox.Highlight.Map
    highlights = {},
    ---Plugins and langauges that can be disabled
    ---To view options: print(require("kimbox.highlights").{langs,langs08,plugins})
    ---@type {langs: Kimbox.Highlight.Langs[], langs08: Kimbox.Highlight.Langs08[], plugins: Kimbox.Highlight.Plugins[]}
    disabled = {
        ---Disabled languages
        ---@see Kimbox.Highlight.Langs
        langs = {},
        ---Disabled languages with '@' treesitter highlights
        ---@see Kimbox.Highlight.Langs08
        langs08 = {},
        ---Disabled plugins
        ---@see Kimbox.Highlight.Plugins
        plugins = {},
    },
    ---Run a function before the colorscheme is loaded
    ---@type fun(): nil
    run_before = nil,
    ---Run a function after the colorscheme is loaded
    ---@type fun(): nil
    run_after = nil,
}

---Validate configuration values
---@param c Kimbox.Config
---@return Kimbox.Config
local function validate(c)
    vim.validate({
        style = {c.style, "s", false},
        toggle_style_key = {c.toggle_style.key, {"s", "b"}, false},
        toggle_style_bgs = {c.toggle_style.bgs, "t", false},
        langs08 = {c.langs08, "b", false},
        popup = {c.popup, "t", false},
        diagnostics = {c.diagnostics, "t", false},
        allow_bold = {c.allow_bold, "b", false},
        allow_italic = {c.allow_italic, "b", false},
        allow_underline = {c.allow_underline, "b", false},
        allow_undercurl = {c.allow_undercurl, "b", false},
        allow_reverse = {c.allow_reverse, "b", false},
        transparent = {c.transparent, "b", false},
        term_colors = {c.term_colors, "b", false},
        ending_tildes = {c.ending_tildes, "b", false},
        --
        colors = {c.colors, "t", false},
        highlights = {c.highlights, "t", false},
        disabled = {c.disabled, "t", false},
        disabled_langs = {c.disabled.langs, "t", false},
        disabled_langs08 = {c.disabled.langs08, "t", false},
        disabled_plugins = {c.disabled.plugins, "t", false},
        --
        run_before = {c.run_before, "f", true},
        run_after = {c.run_after, "f", true},
    })

    if not vim.tbl_contains(Config.bg_colors, c.style) then
        log.err(("invalid 'style' name given: %s.\nValid names: %s")
            :format(c.style, table.concat(Config.bg_colors, ", ")))
        c.style = DEFAULT_STYLE
    end

    return c
end

---Set a configuration value later, after `.setup()`
---@param cfg? Kimbox.Config configuration options
function Config:set(cfg)
    if type(cfg) == "table" then
        self.user = vim.tbl_deep_extend("force", self.user, cfg) --[[@as Kimbox.Config]]
        self.user = validate(self.user)
    end
end

---Return the configuration
---@param key? string
---@return Kimbox.Config
function Config:get(key)
    if key then
        return self.user[key]
    end
    return self.user
end

---Setup Kimbox options, without applying colorscheme
function Config:process()
    local old_config = require("kimbox.config_old").load()
    if old_config then
        self.user = vim.tbl_deep_extend("force", self.user, old_config)
    end

    if self.user.toggle_style then
        self:set({toggle_style = {index = 0}})
    end

    if not utils.is_empty(self.user.toggle_style.key) and self.user.toggle_style.key ~= false then
        if vim.keymap and vim.keymap.set then
            local mapping =
                utils.tern(
                    self.user.toggle_style.key == true,
                    DEFAULT_TOGGLE_KEY,
                    self.user.toggle_style.key
                )
            vim.keymap.set(
                "n",
                mapping,
                [[<Cmd>lua require('kimbox').toggle()<CR>]],
                {noremap = true, silent = true, desc = "Kimbox: toggle bg"}
            )
        end
    end
end

---Toggle between Kimbox styles
function Config:toggle()
    local bgs = self.user.toggle_style.bgs
    local index = self.user.toggle_style.index < #bgs and self.user.toggle_style.index + 1 or 1
    self:set({style = bgs[index]})
    self:set({toggle_style = {index = index}})

    -- TODO: needs testing, i don't use it
    require("kimbox.highlights").toggle_bg()

    vim.o.background = "dark"
    cmd.colorscheme("kimbox")
end

---Initialize the default configuration
function Config.init()
    if Config.__loaded then
        return
    end

    local kimbox = require("kimbox")
    Config.user = vim.tbl_deep_extend("keep", kimbox.__conf, default) --[[@as Kimbox.Config]]
    Config.user = validate(Config.user)
    kimbox.__conf = nil

    Config:process()

    Config.group = api.nvim_create_augroup("Kimbox", {clear = true}) --[[@as integer]]
    api.nvim_create_autocmd("ColorSchemePre", {
        group = Config.group,
        pattern = "kimbox",
        desc = "Run function before loading kimbox theme",
        callback = function()
            if type(Config.user.run_before) == "function" then
                if not pcall(Config.user.run_before) then
                    log.err("failed executing 'run_before' function", true)
                end
            end
        end,
    })
    api.nvim_create_autocmd("ColorScheme", {
        group = Config.group,
        pattern = "kimbox",
        desc = "Properly configure kimbox colorscheme",
        callback = function()
            require("kimbox.highlights").setup()
            require("kimbox.terminal").setup()
            Config.__did_hl = true

            if type(Config.user.run_after) == "function" then
                if not pcall(Config.user.run_after) then
                    log.err("failed executing 'run_after' function", true)
                end
            end
        end,
    })
    Config.__loaded = true
end

return Config
