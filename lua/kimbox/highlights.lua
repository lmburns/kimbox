---@diagnostic disable:need-check-nil
local M = {}
local hl = {
    langs = {},
    langs08 = {},
    plugins = {},
}

local c = require("kimbox.colors")
local bgs = require("kimbox.palette").bgs
local utils = require("kimbox.utils")
local log = utils.log

local cfg = vim.g.kimbox_config

local reverse = utils.tern(cfg.allow_reverse, "reverse", "none")
local bold = utils.tern(cfg.allow_bold, "bold", "none")
local italic = utils.tern(cfg.allow_italic, "italic", "none")
local underline = utils.tern(cfg.allow_underline, "underline", "none")
local undercurl = utils.tern(cfg.allow_undercurl, "undercurl", "none")
local trans = cfg.transparent

local underbold = (function()
    if cfg.allow_bold and cfg.allow_underline then
        return "bold,underline"
    elseif cfg.allow_bold then
        return "bold"
    elseif cfg.allow_underline then
        return "underline"
    else
        return "none"
    end
end)()

---@class KimboxShortFGs
local fgs = {
    fg0 = {fg = c.fg0},
    fg1 = {fg = c.fg1},
    fg2 = {fg = c.fg2},
    fg4 = {fg = c.fg4},
    bg1 = {fg = c.bg1},
    bg2 = {fg = c.bg2},
    bg3 = {fg = c.bg3},
    bg4 = {fg = c.bg4},
    bg5 = {fg = c.bg5},
    grullo_grey = {fg = c.grullo_grey},
    wenge_grey = {fg = c.wenge_grey},
    slate_grey = {fg = c.slate_grey},
    coyote_brown1 = {fg = c.coyote_brown1},
    coyote_brown = {fg = c.coyote_brown},
    amethyst = {fg = c.amethyst},
    aqua = {fg = c.aqua},
    yellow = {fg = c.yellow},
    orange = {fg = c.orange},
    green = {fg = c.green},
    blue = {fg = c.blue},
    purple = {fg = c.purple},
    magenta = {fg = c.magenta},
    philippine_green = {fg = c.philippine_green},
    russian_green = {fg = c.russian_green},
    sea_green = {fg = c.sea_green},
    jade_green = {fg = c.jade_green},
    salmon = {fg = c.salmon},
    old_rose = {fg = c.old_rose},
    puce = {fg = c.puce},
    ube = {fg = c.ube},
    deep_lilac = {fg = c.deep_lilac},
    heliotrope = {fg = c.heliotrope},
    jasper_orange = {fg = c.jasper_orange},
    pumpkin = {fg = c.pumpkin},
    red = {fg = c.red},
    bg_red = {fg = c.bg_red},
    fuzzy_wuzzy = {fg = c.fuzzy_wuzzy},
    wave_red = {fg = c.wave_red},
    peach_red = {fg = c.peach_red},
    tuscan_red = {fg = c.tuscan_red},
    opera_muave = {fg = c.opera_muave},
    oni_violet = {fg = c.oni_violet},
    maroon_x11 = {fg = c.maroon_x11},
    beaver = {fg = c.beaver},
    russet = {fg = c.russet},
    coconut = {fg = c.coconut},
}

hl.common = {
    Normal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    NormalNC = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    Terminal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    ToolbarLine = {fg = utils.tern(trans, c.fg0, c.fg1), bg = utils.tern(trans, c.none, c.bg3)},
    VertSplit = {fg = c.fg1, bg = c.none},
    WinSeparator = {link = "VertSplit"},
    EndOfBuffer = {
        fg = utils.tern(cfg.ending_tildes, c.bg2, c.bg0),
        bg = utils.tern(trans, c.none, c.bg0),
    },
    IncSearch = {fg = c.bg1, bg = c.fuzzy_wuzzy},
    Search = {fg = c.bg0, bg = c.vista_blue},
    Folded = {fg = c.coyote_brown1, bg = c.bg2},
    ColorColumn = {bg = c.bg1}, -- used for the columns set with 'colorcolumn'
    FoldColumn = {fg = c.coyote_brown},
    SignColumn = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    Conceal = {fg = c.coyote_brown1, bg = c.none}, -- placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor = {gui = reverse},
    -- vCursor = {gui = reverse},
    -- iCursor = {gui = reverse},
    -- lCursor = {gui = reverse},
    -- CursorIM = {gui = reverse},
    Cursor = {fg = bgs.ocean, bg = c.deep_saffron}, -- character under the cursor
    vCursor = {fg = bgs.ocean, bg = c.deep_saffron},
    iCursor = {fg = bgs.ocean, bg = c.deep_saffron},
    lCursor = {fg = bgs.ocean, bg = c.deep_saffron},  -- the character under the cursor when |language-mapping|
    CursorIM = {fg = bgs.ocean, bg = c.deep_saffron}, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = {bg = c.bg1},                      -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = {fg = c.none, bg = c.bg1},           -- Screen-line at the cursor, when 'cursorline' is set
    CursorLineNr = {fg = c.purple, gui = bold},       -- Number on cursorline
    CursorLineFold = {fg = c.purple, gui = bold},     -- FoldColumn for cursorline
    CursorLineSign = {fg = c.purple, gui = bold},     -- SignColumn for cursorline
    LineNr = {fg = c.coyote_brown},                   -- SignColumn numbers
    LineNrAbove = {fg = c.coyote_brown},              -- SignColumn numbers above curent line
    LineNrBelow = {fg = c.coyote_brown},              -- SignColumn numbers below curent line
    diffAdded = fgs.yellow,
    diffRemoved = fgs.red,
    diffChanged = fgs.blue,
    diffOldFile = fgs.green,
    diffNewFile = fgs.orange,
    diffFile = fgs.aqua,
    diffLine = fgs.coyote_brown1,
    diffIndexLine = fgs.purple,
    DiffAdd = {fg = c.none, bg = c.diff_add},       -- diff mode: Added line |diff.txt|
    DiffChange = {fg = c.none, bg = c.diff_change}, -- diff mode: Changed line |diff.txt|
    DiffDelete = {fg = c.none, bg = c.diff_delete}, -- diff mode: Deleted line |diff.txt|
    DiffText = {fg = c.none, bg = c.diff_text},     -- diff mode: Changed text within a changed line |diff.txt|
    DiffFile = {fg = c.aqua},
    Directory = {fg = c.salmon, gui = bold},        -- directory names (and other special names in listings)
    ErrorMsg = {fg = c.red, gui = underbold},
    WarningMsg = {fg = c.green, gui = bold},
    ModeMsg = {fg = c.purple, gui = bold},           -- 'showmode' message
    MoreMsg = {fg = c.green, gui = bold},            -- |more-prompt|
    MsgSeparator = {fg = c.fuzzy_wuzzy, gui = bold}, -- Separator for scrolled messages
    Question = {fg = c.green},                       -- Yes/no prompt questions
    MatchParen = {fg = c.none, bg = c.bg4},
    Substitute = {fg = c.bg0, bg = c.green},
    NonText = {fg = c.bg4}, -- fillchars, showbreak
    SpecialKey = {fg = c.bg4},
    Whitespace = {fg = c.bg4},
    -- Popup menu: normal item
    Pmenu = {
        fg = c.fg4,
        bg = utils.tern(cfg.popup.background, c.bg0, c.bg1),
    },
    PmenuSel = {fg = c.red, bg = c.bg4, gui = bold},      -- Popup menu: selected item
    PmenuSbar = {fg = c.none, bg = c.fg3},                -- Popup menu: scrollbar
    PmenuThumb = {fg = c.none, bg = c.green},
    WildMenu = {fg = c.bg3, bg = c.green},                -- Current match in 'wildmenu' completion
    WinBar = {fg = c.fg0, gui = bold},                    -- window bar of current window
    WinBarNC = {fg = c.bg4, gui = bold},                  -- window bar of not-current windows
    NormalFloat = {fg = c.fg1, bg = bgs.ocean},           -- Normal text in floating windows.
    TabLine = {fg = c.fg0, bg = c.bg1},                   -- Tab pages line, not active tab page label
    TabLineSel = {fg = c.purple, bg = c.bg1, gui = bold}, -- Tab pages line, active tab page label
    -- TabLineSel = {fg = c.fg, bg = c.bg1}, -- Tab pages line, active tab page label
    -- TabLineFill = {fg = c.fg, bg = c.bg1}, -- Tab pages line, where there are no labels
    TabLineFill = {gui = "none"},                       -- Tab pages line, where there are no labels
    -- When last status=2 or 3
    StatusLine = {fg = c.none, bg = c.none},            -- Status line of current window.
    StatusLineNC = {fg = c.coyote_brown1, bg = c.none}, -- Status lines of not-current windows
    StatusLineTerm = {fg = c.fg0, bg = c.bg2},
    StatusLineTermNC = {fg = c.coyote_brown1, bg = c.bg1},
    -- Spell
    SpellBad = {fg = c.red, gui = "undercurl", sp = c.red},
    SpellCap = {fg = c.blue, gui = undercurl, sp = c.blue},
    SpellLocal = {fg = c.aqua, gui = undercurl, sp = c.aqua},
    SpellRare = {fg = c.purple, gui = undercurl, sp = c.purple},
    Visual = {fg = c.black, bg = c.fg4, gui = reverse},    -- Visual mode selection
    VisualNOS = {fg = c.black, bg = c.fg4, gui = reverse}, -- Visual sel when vim is "Not Owning the Selection"
    QuickFixLine = {fg = c.purple, gui = bold},
    Debug = {fg = c.orange},
    debugPC = {fg = c.bg0, bg = c.green},
    debugBreakpoint = {fg = c.bg0, bg = c.red},
    ToolbarButton = {fg = c.bg0, bg = c.grullo_grey},
    FloatBorder = {fg = c.magenta},
    FloatTitle = {fg = c.orange, gui = bold},
    FloatermBorder = {fg = c.magenta},
}

hl.syntax = {
    Boolean = fgs.orange,
    Number = fgs.purple,
    Float = fgs.purple,
    PreProc = {fg = c.sea_green, gui = italic},
    PreCondit = fgs.sea_green,
    Include = {fg = c.purple, gui = italic},
    Define = {fg = c.purple},
    Conditional = {fg = c.purple, gui = italic},
    Repeat = {fg = c.purple, gui = italic},
    Keyword = {fg = c.red, gui = italic},
    Typedef = {fg = c.red},
    Exception = {fg = c.red, gui = italic},
    -- NOTE: Why is vim Statement no longer bold after lua upgrade?
    --       This is `italic` in vimscript
    Statement = {fg = c.red, gui = bold},
    Error = fgs.red,
    StorageClass = fgs.orange,
    Tag = fgs.orange,
    Label = fgs.orange,
    Structure = fgs.orange,
    Operator = fgs.orange,
    Title = {fg = c.orange, gui = bold},
    Special = fgs.green,
    SpecialChar = fgs.philippine_green,
    Type = {fg = c.green, gui = bold},
    Function = {fg = c.magenta, gui = bold},
    String = fgs.yellow,
    Character = fgs.yellow,
    Constant = fgs.aqua,
    Macro = fgs.aqua,
    Identifier = fgs.blue,
    Delimiter = fgs.blue,
    Ignore = fgs.coyote_brown1,
    Underlined = {fg = c.none, gui = "underline"},
    Comment = {fg = c.coyote_brown1, gui = italic}, -- any comment
    SpecialComment = {fg = c.coyote_brown1, gui = italic},
    Todo = {fg = c.purple, bg = c.none, gui = italic},
}

hl.treesitter = {
    -- TSEmphasis = { fg = c.fg, gui = "italic" },
    -- TSError = { fg = c.red, gui = italic },
    -- TSStrike = { fg = c.coyote_brown1, gui = "strikethrough" },
    -- TSStrong = { fg = c.fg, gui = "bold" },

    TSBoolean = fgs.orange,                           -- Boolean literals
    TSCharacter = fgs.yellow,                         -- Character literals
    TSCharacterSpecial = {link = "SpecialChar"},      -- Special characters
    TSComment = {fg = c.coyote_brown1, gui = italic}, -- Line comments and block comments
    TSConditional = {fg = c.purple, gui = italic},    -- keywords related to conditionals (e.g. `if` / `else`)
    TSConstant = {fg = c.sea_green, gui = bold},
    TSConstBuiltin = {fg = c.orange, gui = italic},
    TSConstMacro = {fg = c.orange, gui = italic},
    TSConstructor = {fg = c.wave_red, gui = bold},
    -- TSDebug = {}, -- keywords related to debugging
    TSException = {fg = c.red, gui = italic}, -- keywords related to exceptions (e.g. `throw` / `catch`)
    TSField = fgs.aqua,
    TSFloat = fgs.purple,
    TSFunction = {fg = c.magenta, gui = bold},
    TSFuncCall = {fg = c.magenta, gui = bold},
    TSFuncBuiltin = {fg = c.magenta, gui = bold},
    TSFuncMacro = fgs.aqua,
    TSInclude = {fg = c.red, gui = italic},     -- keywords for including modules (e.g. `import` / `from` in Python)
    TSKeyword = fgs.red,
    TSKeywordFunction = fgs.red,                -- keywords that define a function (e.g. `func` in Go, `def` in Python)
    TSKeywordOperator = fgs.red,                -- operators that are English words (e.g. `and` / `or`)
    TSKeywordReturn = {fg = c.red, gui = bold}, -- keywords like `return` and `yield`
    TSLabel = fgs.orange,                       -- GOTO and other labels (e.g. `label:` in C)
    TSMethod = fgs.blue,
    TSMethodCall = fgs.blue,
    TSNamespace = {fg = c.blue, gui = italic},
    TSNone = fgs.fg0,
    TSNumber = fgs.purple,
    TSOperator = fgs.orange,
    TSParameter = fgs.fg0,
    TSParameterReference = fgs.fg0,
    TSPreproc = fgs.sea_green,
    TSProperty = fgs.yellow,
    TSPunctBracket = fgs.fg0,
    TSPunctDelimiter = fgs.coyote_brown1,
    TSPunctSpecial = fgs.green,
    TSRepeat = fgs.purple, -- keywords related to loops (e.g. `for` / `while`)
    TSString = fgs.yellow,
    TSStringEscape = fgs.philippine_green,
    TSStringRegex = fgs.orange,
    TSStringSpecial = fgs.pumpkin,
    TSStorageClass = fgs.red,
    TSSymbol = fgs.fg0,
    TSTag = {fg = c.blue, gui = italic},
    -- TSTagAttribute = fgs.magenta,
    TSTagDelimiter = fgs.magenta,
    TSText = fgs.yellow,
    TSAnnotation = {fg = c.blue, gui = italic}, -- Annotations attached to code to denote some meta info
    TSAttribute = {fg = c.green, gui = italic},
    TSDanger = {fg = c.red, gui = bold},
    TSDiffAdd = {fg = c.none, bg = c.diff_add},
    TSDiffChange = {fg = c.none, bg = c.diff_change},
    TSDiffDelete = {fg = c.none, bg = c.diff_delete},
    TSEmphasis = {fg = c.morning_blue, gui = underbold},
    TSEnviroment = fgs.fg0,
    TSEnviromentName = fgs.fg0,
    TSLiteral = fgs.green,
    -- TSLiteral = fgs.puce,
    TSMath = fgs.green,
    TSNote = {fg = c.blue, gui = bold},
    TSTextReference = fgs.blue,
    TSStrike = fgs.coyote_brown1,
    TSStrong = {fg = c.deep_lilac, gui = bold}, -- {fg = c.none, gui = "bold"},
    TSTitle = {fg = c.orange, gui = "bold"},    -- Text that is part of a title
    TSTodo = {fg = c.red, gui = bold},
    TSUnderline = {fg = c.fg0, gui = "underline"},
    TSURI = {fg = c.amethyst, gui = "underline"},
    -- TSURI = {fg = c.fg0, gui = "underline"},
    TSWarning = {fg = c.green, gui = bold},
    TSType = fgs.green,
    TSTypeBuiltin = {fg = c.green, gui = bold},
    -- TSTypeDefinition = fgs.green,
    TSTypeQualifier = fgs.red,
    TSVariable = fgs.fg0,
    TSVariableBuiltin = fgs.blue,
    TSVariableGlobal = fgs.blue,
}

hl.langs08.treesitter = {
    ["@boolean"] = fgs.orange,
    ["@character"] = fgs.yellow,
    ["@character.special"] = {link = "SpecialChar"},
    ["@comment"] = {fg = c.coyote_brown1, gui = italic},
    ["@conditional"] = {fg = c.purple, gui = italic},
    ["@constant"] = {fg = c.sea_green, gui = bold},
    ["@constant.builtin"] = {fg = c.orange, gui = italic},
    ["@constant.macro"] = {fg = c.orange, gui = italic},
    ["@constructor"] = {fg = c.wave_red, gui = bold},
    -- ["@debug"] = {}, -- keywords related to debugging
    ["@exception"] = {fg = c.red, gui = italic},
    ["@field"] = fgs.aqua,
    ["@float"] = fgs.purple,
    ["@function"] = {fg = c.magenta, gui = bold},
    ["@function.call"] = {fg = c.magenta, gui = bold},
    ["@function.builtin"] = {fg = c.magenta, gui = bold},
    ["@function.macro"] = fgs.aqua,
    ["@include"] = {fg = c.red, gui = italic},
    ["@keyword"] = fgs.red,
    ["@keyword.function"] = fgs.red,
    ["@keyword.operator"] = fgs.red,
    ["@keyword.return"] = {fg = c.red, gui = bold},
    ["@label"] = fgs.orange,
    ["@method"] = fgs.blue,
    -- ["@method.call"] = fgs.blue,
    ["@namespace"] = {fg = c.blue, gui = italic},
    ["@none"] = fgs.fg0,
    ["@number"] = fgs.purple,
    ["@operator"] = fgs.orange,
    ["@parameter"] = fgs.fg0,
    ["@parameter.reference"] = fgs.fg0,
    ["@preproc"] = fgs.sea_green,
    ["@property"] = fgs.yellow,
    ["@punctuation.bracket"] = fgs.fg0,
    ["@punctuation.delimiter"] = fgs.coyote_brown1,
    ["@punctuation.special"] = fgs.green,
    ["@repeat"] = fgs.purple,
    ["@string"] = fgs.yellow,
    ["@string.escape"] = fgs.philippine_green,
    ["@string.regex"] = fgs.orange,
    ["@string.special"] = fgs.pumpkin,
    ["@storageclass"] = fgs.red,
    ["@symbol"] = fgs.fg0,
    ["@tag"] = {fg = c.blue, gui = italic},
    -- ["@tag.attribute"] = fgs.magenta,
    ["@tag.delimiter"] = fgs.magenta,
    ["@text"] = fgs.yellow,
    ["@text.annotation"] = {fg = c.blue, gui = italic},
    ["@text.attribute"] = {fg = c.green, gui = italic},
    ["@text.danger"] = {fg = c.red, gui = bold},
    ["@text.diff.add"] = {fg = c.none, bg = c.diff_add},
    ["@text.diff.change"] = {fg = c.none, bg = c.diff_change},
    ["@text.diff.delete"] = {fg = c.none, bg = c.diff_delete},
    -- ["@text.emphasis"] = {fg = c.morning_blue, gui = "italic"},
    ["@text.environment"] = fgs.fg0,
    ["@text.environment.name"] = fgs.fg0,
    -- ["@text.literal"] = fgs.green,
    ["@text.math"] = fgs.green,
    ["@text.note"] = {fg = c.blue, gui = bold},
    ["@text.reference"] = fgs.blue,
    ["@text.strike"] = fgs.coyote_brown1,
    ["@text.strong"] = {fg = c.deep_lilac, gui = bold}, -- {fg = c.none, gui = "bold"},
    ["@text.title"] = {fg = c.orange, gui = "bold"},
    ["@text.todo"] = {fg = c.red, gui = bold},
    ["@text.underline"] = {fg = c.none, gui = "underline"},
    ["@text.uri"] = {fg = c.fg0, gui = "underline"},
    ["@text.warning"] = {fg = c.yellow, gui = bold},
    ["@type"] = fgs.green,
    ["@type.builtin"] = {fg = c.green, gui = bold},
    -- ["@type.definition"] = fgs.green,
    ["@type.qualifier"] = fgs.red,
    ["@variable"] = fgs.fg0,
    ["@variable.builtin"] = fgs.blue,
    ["@variable.global"] = fgs.blue,
    -- ["@define"] = {},
    -- ["@conceal"] = {},
    -- ["@spell"] = {}

    -- CUSTOM
    ["@underline"] = {link = "Underlined"},
    ["@code"] = {link = "VimwikiCode"},
    ["@bold"] = {link = "VimwikiBold"},
    ["@text.error"] = {fg = c.red, gui = bold},
    ["@text.hint"] = {fg = c.amethyst, gui = bold},
    ["@text.info"] = {fg = c.blue, gui = bold},
    ["@text.debug"] = {fg = c.orange, gui = bold},
    ["@text.trace"] = {fg = c.deep_lilac, gui = bold},
}

--  ╭──────────╮
--  │ Solidity │
--  ╰──────────╯
hl.langs.solidity = {
    -- vim-solidity: https://github.com/thesis/vim-solidity
    solConstructor = {fg = c.blue, gui = bold},
    SolContract = fgs.orange,
    solContractName = {fg = c.aqua, gui = bold},
    solOperator = fgs.orange,
    solMethodParens = fgs.orange,
    solFunction = fgs.red,
    solFuncName = {fg = c.magenta, gui = bold},
    solFuncReturn = fgs.purple,
    solFuncModifier = fgs.red,
    solModifier = fgs.red,
    solMethod = {fg = c.magenta, gui = bold},
    solModifierInsert = {fg = c.magenta, gui = bold},
    solConstant = fgs.aqua,
    -- ════ Treesitter ════
    solidityTSFunction = {link = "TSFunction"},
    solidityTSKeyword = fgs.orange,
    solidityTSType = {fg = c.green, gui = bold},
    solidityTSTag = {fg = c.blue, gui = bold},
    solidityTSMethod = {fg = c.magenta, gui = bold},
    solidityTSField = {link = "TSField"},
}

hl.langs08.solidity = {
    ["@function.solidity"] = {link = "@function"},
    ["@keyword.solidity"] = fgs.orange,
    ["@type.solidity"] = {fg = c.green, gui = bold},
    ["@tag.solidity"] = {fg = c.blue, gui = bold},
    ["@method.solidity"] = {fg = c.magenta, gui = bold},
    ["@method.call.solidity"] = {fg = c.magenta, gui = bold},
    ["@field.solidity"] = {link = "@field"},
}

--  ╭──────╮
--  │ Help │
--  ╰──────╯
hl.langs.vimdoc = {
    helpSpecial = fgs.green,
    helpNote = {fg = c.purple, gui = bold},
    helpHeader = {fg = c.sea_green, gui = bold},
    helpVim = {fg = c.blue, gui = bold}, -- Main header/title
    helpHyperTextEntry = {fg = c.yellow, gui = bold},
    -- ════ Treesitter ════
    helpTSTitle = fgs.red,
    helpTSLabel = fgs.blue,
    helpTSString = {link = "TSString"},
    helpTSURI = {link = "TSURI"},
    -- old
    vimdocTSTitle = {fg = c.red, gui = bold},
    vimdocTSTextLiteral = fgs.purple,
    vimdocTSTextReference = {fg = c.green, gui = bold},
    vimdocTSLabel = fgs.blue,
    vimdocTSString = {link = "TSString"},
    vimdocTSURI = {link = "TSURI"},
    vimdocTSParameter = fgs.salmon,
}

hl.langs08.vimdoc = {
    ["@text.title.vimdoc"] = {fg = c.red, gui = bold},
    ["@text.literal.vimdoc"] = fgs.purple,
    ["@text.reference.vimdoc"] = {fg = c.green, gui = bold},
    ["@label.vimdoc"] = fgs.blue,
    ["@string.vimdoc"] = {link = "@string"},
    ["@text.uri.vimdoc"] = {link = "@text.uri"},
    ["@parameter.vimdoc"] = fgs.salmon,
    -- ["@text.literal.vimdoc"] = {link = "@comment"},
    -- ["@parameter.vimdoc"] = fgs.green,
    --
    -- old
    ["@text.title.help"] = fgs.red,
    ["@label.help"] = fgs.blue,
    ["@string.help"] = {link = "@string"},
    ["@text.uri.help"] = {link = "@text.uri"},
}

--  ╭──────────╮
--  │ Markdown │
--  ╰──────────╯
hl.langs.markdown = {
    markdownH1 = {fg = c.red, gui = "bold"},
    markdownH2 = {fg = c.orange, gui = "bold"},
    markdownH3 = {fg = c.green, gui = "bold"},
    markdownH4 = {fg = c.yellow, gui = "bold"},
    markdownH5 = {fg = c.blue, gui = "bold"},
    markdownH6 = {fg = c.purple, gui = "bold"},
    markdownUrl = {fg = c.blue, gui = "underline"},
    markdownUrlDelimiter = fgs.coyote_brown1,
    markdownUrlTitleDelimiter = fgs.yellow,
    markdownItalic = {fg = c.none, gui = "italic"},
    markdownItalicDelimiter = {fg = c.coyote_brown1, gui = "italic"},
    markdownBold = {fg = c.none, gui = "bold"},
    markdownBoldDelimiter = fgs.coyote_brown1,
    markdownCode = fgs.yellow,
    markdownCodeBlock = fgs.aqua,
    markdownCodeDelimiter = fgs.aqua,
    markdownBlockquote = fgs.coyote_brown1,
    markdownListMarker = fgs.red,
    markdownOrderedListMarker = fgs.red,
    markdownRule = fgs.purple,
    markdownHeadingRule = fgs.coyote_brown1,
    markdownLinkDelimiter = fgs.coyote_brown1,
    markdownLinkTextDelimiter = fgs.coyote_brown1,
    markdownHeadingDelimiter = fgs.coyote_brown1,
    markdownLinkText = fgs.purple,
    markdownId = fgs.green,
    markdownIdDeclaration = fgs.purple,
    -- ════ Treesitter ════
    markdownTSNone = fgs.purple,
    markdownTSPunctDelimiter = {link = "@preproc"},
    markdownTSLiteral = fgs.puce,
    markdownTSEmphasis = {fg = c.morning_blue, gui = "italic"},
    markdownTSURI = {fg = c.amethyst, gui = "underline"},
    markdownTSStrong = {fg = c.deep_lilac, gui = "bold"},
    markdownTSTextReference = {fg = c.blue, gui = underline},
    markdownTSTextQuote = {link = "@string"},
    markdownTSTodoChecked = {fg = c.orange, gui = bold},
    markdownTSTodoUnchecked = {fg = c.green, gui = bold},
    markdownTSPunctSpecial = {fg = c.red, gui = bold},
}

hl.langs08.markdown = {
    -- Fenced code block
    ["@none.markdown"] = fgs.purple,
    -- Fenced code block delim
    ["@punctuation.delimiter.markdown"] = {link = "@preproc"},
    -- Has to be no markdown suffix
    ["@text.literal"] = fgs.puce,
    ["@text.literal.markdown"] = fgs.puce,
    ["@text.emphasis"] = {fg = c.morning_blue, gui = "italic"},
    ["@text.emphasis.markdown"] = {fg = c.morning_blue, gui = "italic"},
    ["@text.uri"] = {fg = c.amethyst, gui = "underline"},
    ["@text.uri.markdown"] = {fg = c.amethyst, gui = "underline"},
    ["@text.strong.markdown"] = {fg = c.deep_lilac, gui = "bold"},
    ["@text.reference.markdown"] = {fg = c.blue, gui = underline},
    ["@text.quote.markdown"] = {link = "@string"},
    ["@text.todo.checked"] = {fg = c.orange, gui = bold},
    ["@text.todo.unchecked"] = {fg = c.green, gui = bold},
    ["@punctuation.special.markdown"] = {fg = c.red, gui = bold},
}

--  ╭─────╮
--  │ Tex │
--  ╰─────╯
hl.langs.tex = {
    -- Latex: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_TEX
    texStatement = fgs.yellow,
    texOnlyMath = fgs.coyote_brown1,
    texDefName = fgs.green,
    texNewCmd = fgs.orange,
    texBeginEnd = fgs.red,
    texBeginEndName = fgs.blue,
    texDocType = fgs.purple,
    texDocTypeArgs = fgs.orange,
    -- Vimtex: https://github.com/lervag/vimtex
    texCmd = fgs.yellow,
    texCmdClass = fgs.purple,
    texCmdTitle = fgs.purple,
    texCmdAuthor = fgs.purple,
    texCmdPart = fgs.purple,
    texCmdBib = fgs.purple,
    texCmdPackage = fgs.green,
    texCmdNew = fgs.green,
    texArgNew = fgs.orange,
    texPartArgTitle = {fg = c.blue, gui = italic},
    texFileArg = {fg = c.blue, gui = italic},
    texEnvArgName = {fg = c.blue, gui = italic},
    texMathEnvArgName = {fg = c.blue, gui = italic},
    texTitleArg = {fg = c.blue, gui = italic},
    texAuthorArg = {fg = c.blue, gui = italic},
    -- Not in original
    texCmdEnv = fgs.aqua,
    texMathZoneX = fgs.orange,
    texMathZoneXX = fgs.orange,
    texMathDelimZone = fgs.coyote_brown1,
    texMathDelim = fgs.purple,
    texMathOper = fgs.red,
    texPgfType = fgs.yellow,
    -- ════ Treesitter ════
    latexTSInclude = fgs.blue,
    latexTSFuncMacro = {fg = c.red, gui = bold},
    latexTSEnvironment = {fg = c.aqua, gui = "bold"},
    latexTSEnvironmentName = fgs.yellow,
    latexTSMath = fgs.purple,
    latexTSTitle = fgs.orange,
    latexTSType = fgs.green,
}

hl.langs08.tex = {
    ["@include.latex"] = fgs.blue,
    ["@function.macro.latex"] = {fg = c.red, gui = bold},
    ["@text.environment.latex"] = {fg = c.aqua, gui = "bold"},
    ["@text.environment.name.latex"] = fgs.yellow,
    ["@text.math.latex"] = fgs.purple,
    ["@text.title.latex"] = fgs.orange,
    ["@type.latex"] = fgs.green,
}

--  ╭────────────╮
--  │ Javascript │
--  ╰────────────╯
hl.langs.javascript = {
    -- vim-javascript: https://github.com/pangloss/vim-javascript
    jsThis = fgs.purple,
    jsUndefined = fgs.aqua,
    jsNull = fgs.aqua,
    jsNan = fgs.aqua,
    jsSuper = fgs.purple,
    jsPrototype = fgs.purple,
    jsFunction = {fg = c.red, gui = italic},
    jsGlobalNodeObjects = {fg = c.purple, gui = italic},
    jsGlobalObjects = fgs.green,
    jsArrowFunction = fgs.purple,
    jsArrowFuncArgs = fgs.blue,
    jsFuncArgs = fgs.blue,
    jsObjectProp = fgs.aqua,
    jsVariableDef = fgs.blue,
    jsObjectKey = fgs.aqua,
    jsParen = fgs.blue,
    jsParenIfElse = fgs.blue,
    jsParenRepeat = fgs.blue,
    jsParenSwitch = fgs.blue,
    jsParenCatch = fgs.blue,
    jsBracket = fgs.blue,
    jsBlockLabel = fgs.aqua,
    jsFunctionKey = {fg = c.yellow, gui = bold},
    jsClassDefinition = fgs.green,
    jsDot = fgs.coyote_brown1,
    jsDestructuringBlock = fgs.blue,
    jsSpreadExpression = fgs.purple,
    jsSpreadOperator = fgs.yellow,
    jsModuleKeyword = fgs.green,
    jsObjectValue = fgs.blue,
    jsTemplateExpression = fgs.green,
    jsTemplateBraces = fgs.green,
    jsClassMethodType = fgs.orange,
    -- yajs: https://github.com/othree/yajs.vim
    javascriptEndColons = fgs.fg0,
    javascriptOpSymbol = fgs.orange,
    javascriptOpSymbols = fgs.orange,
    javascriptIdentifierName = fgs.blue,
    javascriptVariable = fgs.orange,
    javascriptObjectLabel = fgs.aqua,
    javascriptObjectLabelColon = fgs.coyote_brown1,
    javascriptPropertyNameString = fgs.aqua,
    javascriptFuncArg = fgs.blue,
    javascriptIdentifier = fgs.purple,
    javascriptArrowFunc = fgs.purple,
    javascriptTemplate = fgs.green,
    javascriptTemplateSubstitution = fgs.green,
    javascriptTemplateSB = fgs.green,
    javascriptNodeGlobal = {fg = c.purple, gui = italic},
    javascriptDocTags = {fg = c.purple, gui = italic},
    javascriptDocNotation = fgs.purple,
    javascriptClassSuper = fgs.purple,
    javascriptClassName = fgs.green,
    javascriptClassSuperName = fgs.green,
    javascriptBrackets = fgs.purple,
    javascriptBraces = fgs.purple,
    javascriptLabel = fgs.purple,
    javascriptDotNotation = fgs.coyote_brown1,
    javascriptGlobalArrayDot = fgs.coyote_brown1,
    javascriptGlobalBigIntDot = fgs.coyote_brown1,
    javascriptGlobalDateDot = fgs.coyote_brown1,
    javascriptGlobalJSONDot = fgs.coyote_brown1,
    javascriptGlobalMathDot = fgs.coyote_brown1,
    javascriptGlobalNumberDot = fgs.coyote_brown1,
    javascriptGlobalObjectDot = fgs.coyote_brown1,
    javascriptGlobalPromiseDot = fgs.coyote_brown1,
    javascriptGlobalRegExpDot = fgs.coyote_brown1,
    javascriptGlobalStringDot = fgs.coyote_brown1,
    javascriptGlobalSymbolDot = fgs.coyote_brown1,
    javascriptGlobalURLDot = fgs.coyote_brown1,
    javascriptMethod = {fg = c.yellow, gui = bold},
    javascriptMethodName = {fg = c.yellow, gui = bold},
    javascriptObjectMethodName = {fg = c.yellow, gui = bold},
    javascriptGlobalMethod = {fg = c.yellow, gui = bold},
    javascriptDOMStorageMethod = {fg = c.yellow, gui = bold},
    javascriptFileMethod = {fg = c.yellow, gui = bold},
    javascriptFileReaderMethod = {fg = c.yellow, gui = bold},
    javascriptFileListMethod = {fg = c.yellow, gui = bold},
    javascriptBlobMethod = {fg = c.yellow, gui = bold},
    javascriptURLStaticMethod = {fg = c.yellow, gui = bold},
    javascriptNumberStaticMethod = {fg = c.yellow, gui = bold},
    javascriptNumberMethod = {fg = c.yellow, gui = bold},
    javascriptDOMNodeMethod = {fg = c.yellow, gui = bold},
    javascriptES6BigIntStaticMethod = {fg = c.yellow, gui = bold},
    javascriptBOMWindowMethod = {fg = c.yellow, gui = bold},
    javascriptHeadersMethod = {fg = c.yellow, gui = bold},
    javascriptRequestMethod = {fg = c.yellow, gui = bold},
    javascriptResponseMethod = {fg = c.yellow, gui = bold},
    javascriptES6SetMethod = {fg = c.yellow, gui = bold},
    javascriptReflectMethod = {fg = c.yellow, gui = bold},
    javascriptPaymentMethod = {fg = c.yellow, gui = bold},
    javascriptPaymentResponseMethod = {fg = c.yellow, gui = bold},
    javascriptTypedArrayStaticMethod = {fg = c.yellow, gui = bold},
    javascriptGeolocationMethod = {fg = c.yellow, gui = bold},
    javascriptES6MapMethod = {fg = c.yellow, gui = bold},
    javascriptServiceWorkerMethod = {fg = c.yellow, gui = bold},
    javascriptCacheMethod = {fg = c.yellow, gui = bold},
    javascriptFunctionMethod = {fg = c.yellow, gui = bold},
    javascriptXHRMethod = {fg = c.yellow, gui = bold},
    javascriptBOMNavigatorMethod = {fg = c.yellow, gui = bold},
    javascriptDOMEventTargetMethod = {fg = c.yellow, gui = bold},
    javascriptDOMEventMethod = {fg = c.yellow, gui = bold},
    javascriptIntlMethod = {fg = c.yellow, gui = bold},
    javascriptDOMDocMethod = {fg = c.yellow, gui = bold},
    javascriptStringStaticMethod = {fg = c.yellow, gui = bold},
    javascriptStringMethod = {fg = c.yellow, gui = bold},
    javascriptSymbolStaticMethod = {fg = c.yellow, gui = bold},
    javascriptRegExpMethod = {fg = c.yellow, gui = bold},
    javascriptObjectStaticMethod = {fg = c.yellow, gui = bold},
    javascriptObjectMethod = {fg = c.yellow, gui = bold},
    javascriptBOMLocationMethod = {fg = c.yellow, gui = bold},
    javascriptJSONStaticMethod = {fg = c.yellow, gui = bold},
    javascriptGeneratorMethod = {fg = c.yellow, gui = bold},
    javascriptEncodingMethod = {fg = c.yellow, gui = bold},
    javascriptPromiseStaticMethod = {fg = c.yellow, gui = bold},
    javascriptPromiseMethod = {fg = c.yellow, gui = bold},
    javascriptBOMHistoryMethod = {fg = c.yellow, gui = bold},
    javascriptDOMFormMethod = {fg = c.yellow, gui = bold},
    javascriptClipboardMethod = {fg = c.yellow, gui = bold},
    javascriptBroadcastMethod = {fg = c.yellow, gui = bold},
    javascriptDateStaticMethod = {fg = c.yellow, gui = bold},
    javascriptDateMethod = {fg = c.yellow, gui = bold},
    javascriptConsoleMethod = {fg = c.yellow, gui = bold},
    javascriptArrayStaticMethod = {fg = c.yellow, gui = bold},
    javascriptArrayMethod = {fg = c.yellow, gui = bold},
    javascriptMathStaticMethod = {fg = c.yellow, gui = bold},
    javascriptSubtleCryptoMethod = {fg = c.yellow, gui = bold},
    javascriptCryptoMethod = {fg = c.yellow, gui = bold},
    javascriptProp = fgs.aqua,
    javascriptBOMWindowProp = fgs.aqua,
    javascriptDOMStorageProp = fgs.aqua,
    javascriptFileReaderProp = fgs.aqua,
    javascriptURLUtilsProp = fgs.aqua,
    javascriptNumberStaticProp = fgs.aqua,
    javascriptDOMNodeProp = fgs.aqua,
    javascriptRequestProp = fgs.aqua,
    javascriptResponseProp = fgs.aqua,
    javascriptES6SetProp = fgs.aqua,
    javascriptPaymentProp = fgs.aqua,
    javascriptPaymentResponseProp = fgs.aqua,
    javascriptPaymentAddressProp = fgs.aqua,
    javascriptPaymentShippingOptionProp = fgs.aqua,
    javascriptTypedArrayStaticProp = fgs.aqua,
    javascriptServiceWorkerProp = fgs.aqua,
    javascriptES6MapProp = fgs.aqua,
    javascriptRegExpStaticProp = fgs.aqua,
    javascriptRegExpProp = fgs.aqua,
    javascriptXHRProp = fgs.aqua,
    javascriptBOMNavigatorProp = {fg = c.yellow, gui = bold},
    javascriptDOMEventProp = fgs.aqua,
    javascriptBOMNetworkProp = fgs.aqua,
    javascriptDOMDocProp = fgs.aqua,
    javascriptSymbolStaticProp = fgs.aqua,
    javascriptSymbolProp = fgs.aqua,
    javascriptBOMLocationProp = fgs.aqua,
    javascriptEncodingProp = fgs.aqua,
    javascriptCryptoProp = fgs.aqua,
    javascriptBOMHistoryProp = fgs.aqua,
    javascriptDOMFormProp = fgs.aqua,
    javascriptDataViewProp = fgs.aqua,
    javascriptBroadcastProp = fgs.aqua,
    javascriptMathStaticProp = fgs.aqua,
    -- vim-jsx-pretty: https://github.com/maxmellon/vim-jsx-pretty
    jsxTagName = {fg = c.orange, gui = italic},
    jsxTag = {fg = c.purple, gui = bold},
    jsxOpenPunct = fgs.yellow,
    jsxClosePunct = fgs.blue,
    jsxEscapeJs = fgs.blue,
    jsxAttrib = fgs.green,
    jsxCloseTag = {fg = c.aqua, gui = bold},
    jsxComponentName = {fg = c.blue, gui = bold},
    -- ════ Treesitter ════
    javascriptTSConstructor = {fg = c.green, gui = bold},
    javascriptTSException = {fg = c.orange, gui = italic},
    javascriptTSKeyword = {link = "TSKeyword"},
    javascriptTSKeywordReturn = {link = "TSKeywordReturn"},
    javascriptTSMethodCall = {link = "TSFunction"},
    javascriptTSMethod = {link = "TSFunction"},
    javascriptTSParameter = fgs.aqua,
    javascriptTSProperty = fgs.aqua,
    javascriptTSPunctBracket = fgs.purple,
    javascriptTSPunctSpecial = {link = "TSPunctSpecial"},
    javascriptTSTypeBuiltin = {link = "TSTypeBuiltin"},
    javascriptTSVariableBuiltin = {link = "TSVariableBuiltin"},
}

hl.langs08.javascript = {
    ["@constructor.javascript"] = {fg = c.green, gui = bold},
    ["@exception.javascript"] = {fg = c.orange, gui = italic},
    ["@keyword.javascript"] = {link = "@keyword"},
    ["@keyword.return.javascript"] = {link = "@keyword.return"},
    ["@method.call.javascript"] = {link = "@function.call"},
    ["@method.javascript"] = {link = "@function"},
    ["@parameter.javascript"] = fgs.aqua,
    ["@property.javascript"] = fgs.aqua,
    ["@punctuation.bracket.javascript"] = fgs.purple,
    ["@punctuation.special.javascript"] = {link = "@punctuation.special"},
    ["@type.builtin.javascript"] = {link = "@type.builtin"},
    ["@variable.builtin.javascript"] = {link = "@variable.builtin"},
}

--  ╭────────────╮
--  │ Typescript │
--  ╰────────────╯
hl.langs.typescript = {
    -- vim-typescript: https://github.com/leafgarland/typescript-vim
    typescriptSource = {fg = c.purple, gui = italic},
    typescriptMessage = fgs.green,
    typescriptGlobalObjects = fgs.aqua,
    typescriptInterpolation = fgs.green,
    typescriptInterpolationDelimiter = fgs.green,
    typescriptTypeBrackets = fgs.purple,
    typescriptBraces = fgs.purple,
    typescriptParens = fgs.purple,
    -- yats: https://github.com/HerringtonDarkholme/yats.vim
    typescriptMethodAccessor = {fg = c.orange, gui = italic},
    typescriptVariable = fgs.red,
    typescriptVariableDeclaration = fgs.aqua,
    typescriptAliasDeclaration = fgs.green,
    typescriptTypeReference = fgs.green,
    typescriptBoolean = fgs.orange,
    typescriptCase = fgs.purple,
    typescriptRepeat = fgs.purple,
    typescriptEnumKeyword = {fg = c.red, gui = italic},
    typescriptEnum = fgs.green,
    typescriptIdentifierName = fgs.aqua,
    typescriptProp = fgs.aqua,
    typescriptCall = fgs.aqua,
    typescriptConditional = fgs.purple,
    typescriptInterfaceName = fgs.green,
    typescriptEndColons = fgs.fg0,
    typescriptMember = fgs.aqua,
    typescriptMemberOptionality = fgs.orange,
    typescriptObjectLabel = fgs.aqua,
    typescriptArrowFunc = fgs.purple,
    typescriptAbstract = fgs.orange,
    typescriptObjectColon = fgs.coyote_brown1,
    typescriptTypeAnnotation = fgs.coyote_brown1,
    typescriptAssign = fgs.orange,
    typescriptBinaryOp = fgs.orange,
    typescriptUnaryOp = fgs.orange,
    typescriptFuncTypeArrow = fgs.purple,
    typescriptFuncComma = fgs.fg0,
    typescriptFunctionMethod = {fg = c.yellow, gui = bold},
    typescriptFuncName = {fg = c.magenta, gui = bold},
    typescriptFuncKeyword = fgs.red,
    typescriptClassName = fgs.green,
    typescriptClassHeritage = fgs.green,
    typescriptInterfaceHeritage = fgs.green,
    typescriptIdentifier = fgs.purple,
    typescriptGlobal = fgs.purple,
    typescriptOperator = {fg = c.red, gui = italic},
    typescriptNodeGlobal = {fg = c.purple, gui = italic},
    typescriptExport = {fg = c.purple, gui = italic},
    typescriptDefaultParam = fgs.orange,
    typescriptImport = {fg = c.red, gui = italic},
    typescriptTypeParameter = fgs.green,
    typescriptReadonlyModifier = fgs.orange,
    typescriptAccessibilityModifier = fgs.orange,
    typescriptAmbientDeclaration = {fg = c.red, gui = italic},
    typescriptTemplateSubstitution = fgs.green,
    typescriptTemplateSB = fgs.green,
    typescriptExceptions = fgs.green,
    typescriptCastKeyword = {fg = c.red, gui = italic},
    typescriptOptionalMark = fgs.orange,
    typescriptNull = fgs.aqua,
    typescriptMappedIn = {fg = c.red, gui = italic},
    typescriptTernaryOp = fgs.orange,
    typescriptParenExp = fgs.blue,
    typescriptIndexExpr = fgs.blue,
    typescriptDotNotation = fgs.coyote_brown1,
    typescriptGlobalNumberDot = fgs.coyote_brown1,
    typescriptGlobalStringDot = fgs.coyote_brown1,
    typescriptGlobalArrayDot = fgs.coyote_brown1,
    typescriptGlobalObjectDot = fgs.coyote_brown1,
    typescriptGlobalSymbolDot = fgs.coyote_brown1,
    typescriptGlobalMathDot = fgs.coyote_brown1,
    typescriptGlobalDateDot = fgs.coyote_brown1,
    typescriptGlobalJSONDot = fgs.coyote_brown1,
    typescriptGlobalRegExpDot = fgs.coyote_brown1,
    typescriptGlobalPromiseDot = fgs.coyote_brown1,
    typescriptGlobalURLDot = fgs.coyote_brown1,
    typescriptGlobalMethod = {fg = c.yellow, gui = bold},
    typescriptDOMStorageMethod = {fg = c.yellow, gui = bold},
    typescriptFileMethod = {fg = c.yellow, gui = bold},
    typescriptFileReaderMethod = {fg = c.yellow, gui = bold},
    typescriptFileListMethod = {fg = c.yellow, gui = bold},
    typescriptBlobMethod = {fg = c.yellow, gui = bold},
    typescriptURLStaticMethod = {fg = c.yellow, gui = bold},
    typescriptNumberStaticMethod = {fg = c.yellow, gui = bold},
    typescriptNumberMethod = {fg = c.yellow, gui = bold},
    typescriptDOMNodeMethod = {fg = c.yellow, gui = bold},
    typescriptPaymentMethod = {fg = c.yellow, gui = bold},
    typescriptPaymentResponseMethod = {fg = c.yellow, gui = bold},
    typescriptHeadersMethod = {fg = c.yellow, gui = bold},
    typescriptRequestMethod = {fg = c.yellow, gui = bold},
    typescriptResponseMethod = {fg = c.yellow, gui = bold},
    typescriptES6SetMethod = {fg = c.yellow, gui = bold},
    typescriptReflectMethod = {fg = c.yellow, gui = bold},
    typescriptBOMWindowMethod = {fg = c.yellow, gui = bold},
    typescriptGeolocationMethod = {fg = c.yellow, gui = bold},
    typescriptCacheMethod = {fg = c.yellow, gui = bold},
    typescriptES6MapMethod = {fg = c.yellow, gui = bold},
    typescriptRegExpMethod = {fg = c.yellow, gui = bold},
    typescriptXHRMethod = {fg = c.yellow, gui = bold},
    typescriptBOMNavigatorMethod = {fg = c.yellow, gui = bold},
    typescriptServiceWorkerMethod = {fg = c.yellow, gui = bold},
    typescriptIntlMethod = {fg = c.yellow, gui = bold},
    typescriptDOMEventTargetMethod = {fg = c.yellow, gui = bold},
    typescriptDOMEventMethod = {fg = c.yellow, gui = bold},
    typescriptDOMDocMethod = {fg = c.yellow, gui = bold},
    typescriptStringStaticMethod = {fg = c.yellow, gui = bold},
    typescriptStringMethod = {fg = c.yellow, gui = bold},
    typescriptSymbolStaticMethod = {fg = c.yellow, gui = bold},
    typescriptObjectStaticMethod = {fg = c.yellow, gui = bold},
    typescriptObjectMethod = {fg = c.yellow, gui = bold},
    typescriptObjectType = {fg = c.orange, gui = bold},
    typescriptJSONStaticMethod = {fg = c.yellow, gui = bold},
    typescriptEncodingMethod = {fg = c.yellow, gui = bold},
    typescriptBOMLocationMethod = {fg = c.yellow, gui = bold},
    typescriptPromiseStaticMethod = {fg = c.yellow, gui = bold},
    typescriptPromiseMethod = {fg = c.yellow, gui = bold},
    typescriptSubtleCryptoMethod = {fg = c.yellow, gui = bold},
    typescriptCryptoMethod = {fg = c.yellow, gui = bold},
    typescriptBOMHistoryMethod = {fg = c.yellow, gui = bold},
    typescriptDOMFormMethod = {fg = c.yellow, gui = bold},
    typescriptConsoleMethod = {fg = c.yellow, gui = bold},
    typescriptDateStaticMethod = {fg = c.yellow, gui = bold},
    typescriptDateMethod = {fg = c.yellow, gui = bold},
    typescriptArrayStaticMethod = {fg = c.yellow, gui = bold},
    typescriptArrayMethod = {fg = c.yellow, gui = bold},
    typescriptMathStaticMethod = {fg = c.yellow, gui = bold},
    typescriptStringProperty = fgs.aqua,
    typescriptDOMStorageProp = fgs.aqua,
    typescriptFileReaderProp = fgs.aqua,
    typescriptURLUtilsProp = fgs.aqua,
    typescriptNumberStaticProp = fgs.aqua,
    typescriptDOMNodeProp = fgs.aqua,
    typescriptBOMWindowProp = fgs.aqua,
    typescriptRequestProp = fgs.aqua,
    typescriptResponseProp = fgs.aqua,
    typescriptPaymentProp = fgs.aqua,
    typescriptPaymentResponseProp = fgs.aqua,
    typescriptPaymentAddressProp = fgs.aqua,
    typescriptPaymentShippingOptionProp = fgs.aqua,
    typescriptES6SetProp = fgs.aqua,
    typescriptServiceWorkerProp = fgs.aqua,
    typescriptES6MapProp = fgs.aqua,
    typescriptRegExpStaticProp = fgs.aqua,
    typescriptRegExpProp = fgs.aqua,
    typescriptBOMNavigatorProp = {fg = c.yellow, gui = bold},
    typescriptXHRProp = fgs.aqua,
    typescriptDOMEventProp = fgs.aqua,
    typescriptDOMDocProp = fgs.aqua,
    typescriptBOMNetworkProp = fgs.aqua,
    typescriptSymbolStaticProp = fgs.aqua,
    typescriptEncodingProp = fgs.aqua,
    typescriptBOMLocationProp = fgs.aqua,
    typescriptCryptoProp = fgs.aqua,
    typescriptDOMFormProp = fgs.aqua,
    typescriptBOMHistoryProp = fgs.aqua,
    typescriptMathStaticProp = fgs.aqua,
    -- ════ Treesitter ════
    typescriptTSParameter = fgs.aqua,
    typescriptTSTypeBuiltin = {fg = c.green, gui = bold},
    typescriptTSKeywordReturn = {fg = c.red, gui = bold},
    typescriptTSPunctBracket = fgs.purple,
    typescriptTSPunctSpecial = fgs.green,
    typescriptTSPunctDelimiter = fgs.purple,
    typescriptTSVariableBuiltin = fgs.blue,
    typescriptTSException = {fg = c.orange, gui = italic},
    typescriptTSConstructor = {fg = c.wave_red, gui = bold},
    typescriptTSProperty = fgs.aqua,
    typescriptTSMethod = {fg = c.magenta, gui = bold},
    typescriptTSKeyword = fgs.red,
}

hl.langs08.typescript = {
    ["@parameter.typescript"] = fgs.aqua,
    ["@type.builtin.typescript"] = {fg = c.green, gui = bold},
    ["@keyword.return.typescript"] = {fg = c.red, gui = bold},
    ["@punctuation.bracket.typescript"] = fgs.purple,
    ["@punctuation.special.typescript"] = fgs.green,
    ["@punctuation.delimiter.typescript"] = fgs.purple,
    ["@variable.builtin.typescript"] = fgs.blue,
    ["@exception.typescript"] = {fg = c.orange, gui = italic},
    ["@constructor.typescript"] = {fg = c.wave_red, gui = bold},
    ["@property.typescript"] = fgs.aqua,
    ["@method.typescript"] = {fg = c.magenta, gui = bold},
    ["@method.call.typescript"] = {fg = c.magenta, gui = bold},
    ["@keyword.typescript"] = fgs.red,
}

--  ╭─────╮
--  │ tsx │
--  ╰─────╯
hl.langs.tsx = {
    tsxTSMethod = {fg = c.magenta, gui = bold},
    tsxTSConstructor = {fg = c.wave_red, gui = bold},
    tsxTSProperty = fgs.aqua,
    tsxTSPunctBracket = fgs.purple,
    tsxTSTagAttribute = fgs.aqua,
    tsxTSTag = {fg = c.orange, gui = italic},
    tsxTSVariableBuiltin = fgs.blue,
    tsxTSException = {fg = c.orange, gui = italic},
    -- jsxTag = {fg = c.purple, gui = bold},
    -- jsxOpenPunct = fgs.yellow,
    -- jsxClosePunct = fgs.blue,
    -- jsxEscapeJs = fgs.blue,
    -- jsxAttrib = fgs.green,
    -- jsxCloseTag = {fg = c.aqua, gui = bold},
    -- jsxComponentName = {fg = c.blue, gui = bold},
}

hl.langs08.tsx = {
    ["@method.tsx"] = {fg = c.magenta, gui = bold},
    ["@method.call.tsx"] = {fg = c.magenta, gui = bold},
    ["@constructor.tsx"] = {fg = c.wave_red, gui = bold},
    ["@property.tsx"] = fgs.aqua,
    ["@punctuation.bracket.tsx"] = fgs.purple,
    ["@tag.attribute.tsx"] = fgs.aqua,
    ["@tag.tsx"] = {fg = c.orange, gui = italic},
    ["@variable.builtin.tsx"] = fgs.blue,
    ["@exception.tsx"] = {fg = c.orange, gui = italic},
}

--  ╭────────╮
--  │ Python │
--  ╰────────╯
hl.langs.python = {
    pythonBuiltin = fgs.green,
    pythonExceptions = fgs.purple,
    pythonDecoratorName = fgs.blue,
    -- python-syntax: https://github.com/vim-python/python-syntax
    pythonExClass = fgs.purple,
    pythonBuiltinType = fgs.green,
    pythonBuiltinObj = fgs.blue,
    pythonDottedName = {fg = c.purple, gui = italic},
    pythonBuiltinFunc = {fg = c.yellow, gui = bold},
    pythonFunction = {fg = c.aqua, gui = bold},
    pythonDecorator = fgs.orange,
    pythonInclude = {fg = c.purple, gui = italic},
    pythonImport = {fg = c.purple, gui = italic},
    pythonRun = fgs.blue,
    pythonCoding = fgs.coyote_brown1,
    pythonOperator = fgs.orange,
    pythonConditional = {fg = c.red, gui = italic},
    pythonRepeat = {fg = c.red, gui = italic},
    pythonException = {fg = c.red, gui = italic},
    pythonNone = fgs.aqua,
    pythonDot = fgs.coyote_brown1,
    -- semshi: https://github.com/numirias/semshi
    semshiUnresolved = {fg = c.green, gui = undercurl},
    semshiImported = fgs.purple,
    semshiParameter = fgs.blue,
    semshiParameterUnused = fgs.coyote_brown1,
    semshiSelf = {fg = c.purple, gui = italic},
    semshiGlobal = fgs.green,
    semshiBuiltin = fgs.green,
    semshiAttribute = fgs.aqua,
    semshiLocal = fgs.red,
    semshiFree = fgs.red,
    semshiErrorSign = fgs.red,
    semshiErrorChar = fgs.red,
    semshiSelected = {bg = c.fg2},
    -- ════ Treesitter ════
    pythonTSType = {fg = c.green, gui = bold},
    pythonTSConstructor = fgs.magenta,
    pythonTSKeywordFunction = {fg = c.red, gui = bold},
    pythonTSConstBuiltin = fgs.purple,
    pythonTSMethod = {fg = c.purple, gui = bold},
    pythonTSParameter = fgs.orange,
    pythonTSConstant = {fg = c.sea_green, gui = bold},
    pythonTSField = fgs.fg0,
    pythonTSStringEscape = fgs.green,
    pythonTSPunctBracket = fgs.purple,
}

hl.langs08.python = {
    ["@constant.python"] = {fg = c.sea_green, gui = bold},
    ["@constant.builtin.python"] = fgs.purple,
    ["@constructor.python"] = fgs.magenta,
    ["@field.python"] = fgs.aqua,
    ["@keyword.function.python"] = {fg = c.red, gui = bold},
    ["@method.call.python"] = {fg = c.magenta, gui = bold},
    ["@method.python"] = {fg = c.purple, gui = bold},
    ["@parameter.python"] = fgs.orange,
    ["@punctuation.bracket.python"] = fgs.purple,
    ["@string.escape.python"] = fgs.green,
    ["@type.python"] = {fg = c.green, gui = bold},
}

--  ╭────╮
--  │ Go │
--  ╰────╯
hl.langs.go = {
    goDirective = {fg = c.purple, gui = italic},
    goConstants = fgs.aqua,
    goTypeDecl = {fg = c.purple, gui = italic},
    goDeclType = {fg = c.orange, gui = italic},
    goFunctionCall = {fg = c.green, gui = bold},
    goSpaceError = {fg = c.coyote_brown1, bg = c.bg_red},
    goVarArgs = fgs.blue,
    goBuiltins = fgs.purple,
    goPredefinedIdentifiers = fgs.orange,
    goVar = fgs.orange,
    goField = fgs.aqua,
    goDeclaration = fgs.blue,
    goConst = fgs.orange,
    goParamName = fgs.aqua,
    -- ════ Treesitter ════
    goTSProperty = fgs.blue,
    goTSField = fgs.aqua,
    goTSMethod = {fg = c.purple, gui = bold},
    goTSNamespace = {fg = c.jade_green, gui = bold},
    goTSType = {fg = c.green, gui = bold},
    goTSTypeBuiltin = {fg = c.green, gui = bold},
    goTSPunctBracket = fgs.purple,
}

hl.langs08.go = {
    ["@property.go"] = fgs.blue,
    ["@field.go"] = fgs.aqua,
    ["@method.go"] = {fg = c.purple, gui = bold},
    ["@method.call.go"] = {fg = c.magenta, gui = bold},
    ["@namespace.go"] = {fg = c.jade_green, gui = bold},
    ["@type.go"] = {fg = c.green, gui = bold},
    ["@type.builtin.go"] = {fg = c.green, gui = bold},
    ["@punctuation.bracket.go"] = fgs.purple,
}

--  ╭──────╮
--  │ Rust │
--  ╰──────╯
hl.langs.rust = {
    -- rust.vim: https://github.com/rust-lang/rust.vim
    rustStructure = fgs.orange,
    rustIdentifier = fgs.purple,
    rustModPath = fgs.orange,
    rustModPathSep = fgs.coyote_brown1,
    rustSelf = fgs.blue,
    rustSuper = fgs.blue,
    rustDeriveTrait = {fg = c.purple, gui = italic},
    rustEnumVariant = fgs.purple,
    rustMacroVariable = fgs.blue,
    rustAssert = fgs.aqua,
    rustPanic = fgs.aqua,
    rustPubScopeCrate = {fg = c.purple, gui = italic},
    rustArrowCharacter = fgs.orange,
    rustOperator = fgs.orange,
    -- ════ Treesitter ════
    rustTSConstBuiltin = fgs.purple,
    rustTSConstant = {fg = c.sea_green, gui = bold},
    rustTSField = fgs.aqua, -- fg0
    rustTSFuncMacro = fgs.aqua,
    rustTSInclude = {fg = c.red, gui = italic},
    rustTSLabel = fgs.green,
    rustTSNamespace = fgs.orange,
    rustTSParameter = fgs.orange,
    rustTSPunctBracket = fgs.purple,
    rustTSPunctSpecial = fgs.magenta,
    rustTSStringEscape = fgs.green,
    rustTSType = {fg = c.green, gui = bold},
    rustTSTypeBuiltin = {fg = c.green, gui = bold},
    rustTSVariableBuiltin = fgs.blue,
}

hl.langs08.rust = {
    ["@constant.builtin.rust"] = fgs.purple,
    ["@constant.rust"] = {fg = c.sea_green, gui = bold},
    ["@field.rust"] = fgs.aqua, -- fg0
    ["@function.macro.rust"] = fgs.aqua,
    ["@include.rust"] = {fg = c.red, gui = italic},
    ["@label.rust"] = fgs.green,
    ["@namespace.rust"] = fgs.orange,
    ["@parameter.rust"] = fgs.orange,
    ["@punctuation.bracket.rust"] = fgs.purple,
    ["@punctuation.special.rust"] = fgs.magenta,
    ["@string.escape.rust"] = fgs.green,
    ["@type.rust"] = {fg = c.green, gui = bold},
    ["@type.builtin.rust"] = {fg = c.green, gui = bold},
    ["@variable.builtin.rust"] = fgs.blue,
}

--  ╭──────╮
--  │ Ruby │
--  ╰──────╯
hl.langs.ruby = {
    -- builtin: https://github.com/vim-ruby/vim-ruby
    rubyStringDelimiter = fgs.yellow,
    rubyModuleName = fgs.purple,
    rubyMacro = {fg = c.red, gui = italic},
    rubyKeywordAsMethod = {fg = c.yellow, gui = bold},
    rubyInterpolationDelimiter = fgs.green,
    rubyInterpolation = fgs.green,
    rubyDefinedOperator = fgs.orange,
    rubyDefine = {fg = c.red, gui = italic},
    rubyBlockParameterList = fgs.blue,
    rubyAttribute = fgs.green,
    rubyArrayDelimiter = fgs.orange,
    rubyCurlyBlockDelimiter = fgs.orange,
    rubyAccess = fgs.orange,
    -- ════ Treesitter ════
    rubyTSLabel = fgs.blue,
    rubyTSString = fgs.yellow,
    rubyTSPunctSpecial = fgs.green,
    rubyTSPunctBracket = fgs.green,
    rubyTSParameter = fgs.orange,
    rubyTSSymbol = fgs.aqua,
    rubyTSNone = fgs.blue,
    rubyTSType = {fg = c.green, gui = bold},
}

hl.langs08.ruby = {
    ["@label.ruby"] = fgs.blue,
    ["@string.ruby"] = fgs.yellow,
    ["@punctuation.special.ruby"] = fgs.green,
    ["@punctuation.bracket.ruby"] = fgs.green,
    ["@parameter.ruby"] = fgs.orange,
    ["@symbol.ruby"] = fgs.aqua,
    ["@none.ruby"] = fgs.blue,
    ["@type.ruby"] = {fg = c.green, gui = bold},
}

--  ╭──────╮
--  │ Perl │
--  ╰──────╯
hl.langs.perl = {
    -- builtin: https://github.com/vim-perl/vim-perl
    perlStatementPackage = {fg = c.purple, gui = italic},
    perlStatementInclude = {fg = c.purple, gui = italic},
    perlStatementStorage = fgs.orange,
    perlStatementList = fgs.orange,
    perlMatchStartEnd = fgs.orange,
    perlVarSimpleMemberName = fgs.aqua,
    perlVarSimpleMember = fgs.fg0,
    perlMethod = {fg = c.yellow, gui = bold},
    perlOperator = fgs.red,
    podVerbatimLine = fgs.yellow,
    podCmdText = fgs.green,
    perlDATA = {fg = c.orange, gui = italic},
    perlBraces = fgs.purple,
    -- ════ Treesitter ════
    perlTSVariable = fgs.blue,
}

hl.langs08.perl = {
    ["@variable.perl"] = fgs.blue,
}

--  ╭──────╮
--  │ Teal │
--  ╰──────╯
hl.langs.teal = {
    tealTSOperator = fgs.orange, -- when not and as are not considered operators, i think it'd be better
    tealTSParameter = fgs.aqua,
    tealTSPunctBracket = fgs.purple,
    tealTSFunction = {fg = c.magenta, gui = bold},
    tealTSConstant = {fg = c.wave_red, gui = bold},
}

hl.langs08.teal = {
    ["@operator.teal"] = fgs.orange,
    ["@parameter.teal"] = fgs.aqua,
    ["@punctuation.bracket.teal"] = fgs.purple,
    ["@function.teal"] = {fg = c.magenta, gui = bold},
    ["@constant.teal"] = {fg = c.green, gui = bold},
    ["@constant.builtin.teal"] = fgs.orange,
    -- Custom
    ["@keyword.coroutine.teal"] = {fg = c.oni_violet, gui = bold},
    ["@field.builtin.teal"] = fgs.wave_red,
    ["@variable.builtin.teal"] = fgs.russian_green,
    -- ["@keyword.self.teal"] = fgs.blue,
    -- ["@keyword.super.teal"] = fgs.blue,
}

--  ╭─────╮
--  │ Lua │
--  ╰─────╯
hl.langs.lua = {
    -- When cursorholding for Coc.nvim
    -- Mimic treesitter as much as possible
    luaTable = fgs.aqua,
    luaConstant = fgs.orange,
    luaParens = fgs.blue,
    luaFuncParens = fgs.blue,
    luaLocal = {link = "Statement"},
    luaStatement = {link = "Statement"},
    luaSpecialValue = {link = "Function"},
    luaFuncCall = {link = "Function"},
    luaFuncId = {link = "Function"},
    luaFuncName = {link = "Function"},
    luaFuncKeyword = fgs.red,
    luaFuncTable = {link = "Type"},
    luaEllipsis = {link = "Special"},
    luaSpecialTable = {link = "Type"},
    luaOperator = fgs.red,
    luaSymbolOperator = fgs.orange,
    luaCond = {link = "Conditional"},
    luaErrHand = {link = "Exception"},
    -- ════ Treesitter ════
    luaTSConstant = {fg = c.green, gui = bold},
    luaTSConstBuiltin = fgs.orange,
    luaTSConstructor = {fg = c.wave_red, gui = bold},
    luaTSProperty = fgs.green,
    luaTSLabel = {fg = c.orange, gui = bold},
    luaTSField = fgs.aqua,
    luaTSPreproc = fgs.purple,
    luaTSMethod = fgs.blue,
    luaTSMethodCall = fgs.blue,
    luaTSPunctBracket = fgs.purple,
    luaTSNamespaceBuiltin = fgs.russian_green,
    luaTSVariableBuiltin = fgs.blue,
    luaTSFunction = {fg = c.magenta, gui = bold},
    luaTSFuncBuiltin = {fg = c.magenta, gui = bold},
    luaTSKeywordFunction = fgs.red,
    luaTSKeywordCoroutine = {fg = c.oni_violet, gui = bold},
}

hl.langs08.lua = {
    -- ["@punctuation.delimiter.lua"] = fgs.purple,
    -- ["@function.builtin.lua"] = {fg = c.russian_green, gui = bold},
    -- ["@comment.documentation.lua"] = fgs.blue,
    ["@constant.lua"] = {fg = c.green, gui = bold},
    ["@constant.builtin.lua"] = fgs.orange,
    ["@constructor.lua"] = {fg = c.wave_red, gui = bold},
    ["@property.lua"] = fgs.green,
    ["@field.lua"] = fgs.aqua,
    ["@preproc.lua"] = fgs.purple,
    ["@label.lua"] = {fg = c.orange, gui = bold},
    ["@method.lua"] = fgs.blue,
    ["@method.call.lua"] = fgs.blue,
    ["@punctuation.bracket.lua"] = fgs.purple,
    ["@namespace.builtin.lua"] = fgs.russian_green,
    ["@variable.builtin.lua"] = fgs.blue,
    ["@function.lua"] = {fg = c.magenta, gui = bold},
    ["@function.builtin.lua"] = {fg = c.magenta, gui = bold},
    ["@keyword.function.lua"] = fgs.red,
    ["@keyword.coroutine.lua"] = {fg = c.oni_violet, gui = bold},
    -- Custom
    ["@field.builtin.lua"] = fgs.wave_red,
    ["@function.meta.lua"] = {fg = c.wave_red, gui = bold},
    ["@function.error.lua"] = {fg = c.infra_red, gui = bold},
    -- ["@function.table.lua"] = {fg = c.new, gui = bold},
    -- ["@function.import.lua"] = {fg = c.bg_red, gui = bold},
}

--  ╭─────────╮
--  │ Lua Doc │
--  ╰─────────╯
hl.langs.luadoc = {
    luadocTSVariable = {fg = c.philippine_silver, gui = bold},
    luadocTSParameter = {fg = c.salmon, gui = bold},
    luadocTSKeyword = fgs.jasper_orange,
    luadocTSKeywordFunction = {link = "TSKeywordFunction"},
    luadocTSKeywordReturn = {link = "TSKeywordReturn"},
    luadocTSType = {link = "TSType"},
    luadocTSTypeBuiltin = {link = "TSTypeBuiltin"},
    luadocTSOperator = {fg = c.orange, gui = bold},
    luadocTSPunctBracket = fgs.purple,
    luadocTSPunctDelimiter = {fg = c.orange, gui = bold},
    luadocTSPunctSpecial = {link = "TSPunctSpecial"},
}

hl.langs08.luadoc = {
    ["@variable.luadoc"] = {fg = c.philippine_silver, gui = bold},
    -- ["@variable.luadoc"] = {fg = c.fg0, gui = bold},
    ["@parameter.luadoc"] = {fg = c.salmon, gui = bold},
    ["@keyword.luadoc"] = fgs.jasper_orange,
    ["@keyword.function.luadoc"] = {link = "@keyword.function"},
    ["@keyword.return.luadoc"] = {link = "@keyword.return"},
    ["@namespace.luadoc"] = {fg = c.orange, gui = bold},
    ["@type.luadoc"] = {link = "@type"},
    ["@type.builtin.luadoc"] = {link = "@type.builtin"},
    ["@operator.luadoc"] = {fg = c.orange, gui = bold},
    ["@punctuation.bracket.luadoc"] = fgs.purple,
    ["@punctuation.delimiter.luadoc"] = {fg = c.orange, gui = bold},
    ["@punctuation.special.luadoc"] = {link = "@punctuation.special"},
    -- custom
    ["@keyword.diagnostic.luadoc"] = {fg = c.russian_green, gui = bold},
    ["@keyword.extra.luadoc"] = {fg = c.slate_grey, gui = bold},
    ["@keyword.info.luadoc"] = {fg = c.ube, gui = bold},
    ["@keyword.deprecated.luadoc"] = {fg = c.infra_red, gui = bold},
    ["@keyword.meta.luadoc"] = {fg = c.peach_red, gui = bold},
}

--  ╭──────╮
--  │ Luap │
--  ╰──────╯
hl.langs.luap = {
    luapTSPunctSpecial = fgs.green,
    luapTSPunctBracket = fgs.blue,
    luapTSOperator = fgs.orange,
    luapTSKeyword = fgs.red,
}

hl.langs08.luap = {
    ["@punctuation.special.luap"] = fgs.green,
    ["@punctuation.bracket.luap"] = fgs.blue,
    ["@operator.luap"] = fgs.orange,
    ["@keyword.luap"] = fgs.red,
}

--  ╭───────╮
--  │ Regex │
--  ╰───────╯
hl.langs.regex = {
    regexTSString = {fg = c.wave_red},
    -- regexTSConstCharacter = {fg = c.opera_muave, gui = bold},
    -- regexTSConstCharacterEscape = {fg = c.russian_green, gui = bold},
    regesTSPunctDelimiter = {fg = c.ube, gui = bold},
    regexTSOperator = {fg = c.pumpkin, bui = bold},
    regexTSProperty = {fg = c.yellow, bui = bold},
}

hl.langs08.regex = {
    -- ["@string.regex"] = {fg = c.beaver},
    ["@string.regex"] = {fg = c.wave_red},
    ["@constant.character.regex"] = {fg = c.opera_muave, gui = bold},
    ["@constant.character.escape.regex"] = {fg = c.russian_green, gui = bold},
    ["@punctuation.delimiter.regex"] = {fg = c.ube, gui = bold},
    ["@operator.regex"] = {fg = c.pumpkin, bui = bold},
    ["@property.regex"] = {fg = c.yellow, bui = bold},
}

--  ╭──────╮
--  │ VimL │
--  ╰──────╯
hl.langs.vim = {
    vimCommentTitle = {fg = c.coyote_brown1, bg = c.none, gui = bold},
    vimLet = fgs.orange,
    vimVar = fgs.aqua,
    vimFunction = {fg = c.magenta, gui = bold},
    vimIsCommand = fgs.fg0,
    vimUserFunc = {fg = c.green, gui = bold},
    vimFuncName = {fg = c.green, gui = bold},
    vimMap = {fg = c.purple, gui = italic},
    vimNotation = fgs.aqua,
    vimMapLhs = fgs.yellow,
    vimMapRhs = fgs.yellow,
    vimSetEqual = fgs.green,
    vimOption = fgs.aqua,
    vimUserAttrbKey = fgs.green,
    vimUserAttrb = fgs.yellow,
    vimAutoCmdSfxList = fgs.aqua,
    vimSynType = fgs.orange,
    vimHiBang = fgs.orange,
    vimSet = fgs.green,
    -- vimCommand = fgs.red,
    vimSetSep = fgs.coyote_brown,
    vimContinue = fgs.coyote_brown1,
    -- ════ Treesitter ════
    vimTSBoolean = fgs.orange,
    vimTSConditional = {fg = c.purple, gui = italic},
    vimTSConstBuiltin = {fg = c.aqua, gui = italic},
    vimTSConstant = {fg = c.sea_green, gui = bold},
    vimTSException = {fg = c.orange, gui = bold},
    vimTSFuncCall = {fg = c.magenta, gui = bold},
    vimTSFunction = {fg = c.magenta, gui = bold},
    vimTSKeyword = {fg = c.red, gui = bold},
    vimTSNamespace = {fg = c.blue, gui = bold},
    vimTSOperator = fgs.orange,
    vimTSPunctBracket = fgs.green,
    vimTSPunctSpecial = {fg = c.green, gui = bold},
    vimTSRepeat = fgs.blue,
    vimTSStringSpecial = fgs.green,
    vimTSType = {fg = c.green, gui = bold},
    vimTSVariableBuiltin = {fg = c.green, gui = bold},
    --
    -- vimTSFuncBuiltin = {fg = c.jade_green, gui = bold},
}

hl.langs08.vim = {
    ["@boolean.vim"] = fgs.orange,
    ["@conditional.vim"] = {fg = c.purple, gui = italic},
    ["@constant.builtin.vim"] = {fg = c.aqua, gui = italic},
    ["@constant.vim"] = {fg = c.sea_green, gui = bold},
    ["@exception.vim"] = {fg = c.orange, gui = bold},
    ["@function.call.vim"] = {fg = c.magenta, gui = bold},
    ["@function.vim"] = {fg = c.magenta, gui = bold},
    ["@keyword.vim"] = {fg = c.red, gui = bold},
    ["@namespace.vim"] = {fg = c.blue, gui = bold},
    ["@operator.vim"] = fgs.orange,
    ["@punctuation.bracket.vim"] = fgs.green,
    ["@punctuation.special.vim"] = {fg = c.green, gui = bold},
    ["@repeat.vim"] = fgs.blue,
    ["@string.special.vim"] = fgs.green,
    ["@type.vim"] = {fg = c.green, gui = bold},
    ["@variable.builtin.vim"] = {fg = c.green, gui = bold},
    --
    -- Unsupported
    --
    -- ["@function.builtin.vim"] = {fg = c.jade_green, gui = bold},
}

--  ╭───╮
--  │ C │
--  ╰───╯
hl.langs.c = {
    cInclude = fgs.blue,
    cStorageClass = fgs.purple,
    cTypedef = fgs.purple,
    cDefine = fgs.aqua,
    -- ════ Treesitter ════
    cTSInclude = fgs.red,
    cTSProperty = fgs.aqua,
    cTSConstant = {fg = c.sea_green, gui = bold},
    cTSConstMacro = fgs.orange,
    cTSOperator = fgs.orange,
    cTSRepeat = fgs.blue,
    cTSType = {fg = c.green, gui = bold},
    cTSPunctBracket = fgs.purple,
    -- cTSInclude = fgs.blue,
    -- cTSFuncMacro = fgs.yellow,
}

hl.langs08.c = {
    ["@include.c"] = fgs.red,
    ["@property.c"] = fgs.aqua,
    ["@constant.c"] = {fg = c.sea_green, gui = bold},
    ["@constant.macro.c"] = fgs.orange,
    ["@operator.c"] = fgs.orange,
    ["@repeat.c"] = fgs.blue,
    ["@type.c"] = {fg = c.green, gui = bold},
    ["@punctuation.bracket.c"] = fgs.purple,
}

--  ╭─────╮
--  │ CPP │
--  ╰─────╯
hl.langs.cpp = {
    cppStatement = {fg = c.purple, gui = bold},
    -- ════ Treesitter ════
    cppTSConstant = {fg = c.sea_green, gui = bold},
    cppTSConstMacro = {fg = c.aqua, gui = bold},
    cppTSOperator = fgs.orange,
    cppTSNamespace = fgs.orange,
    cppTSType = {fg = c.green, gui = bold},
    cppTSTypeBuiltin = {fg = c.green, gui = bold},
    cppTSKeyword = fgs.red,
    cppTSInclude = {fg = c.red, gui = italic},
    cppTSMethod = fgs.blue,
    cppTSField = fgs.aqua,
    cppTSConstructor = {fg = c.wave_red, gui = bold},
}

hl.langs08.cpp = {
    ["@constant.cpp"] = {fg = c.sea_green, gui = bold},
    ["@constant.macro.cpp"] = {fg = c.aqua, gui = bold},
    ["@operator.cpp"] = fgs.orange,
    ["@conditional.ternary.cpp"] = fgs.blue,
    ["@namespace.cpp"] = fgs.orange,
    ["@type.cpp"] = {fg = c.green, gui = bold},
    ["@type.builtin.cpp"] = {fg = c.green, gui = bold},
    ["@keyword.cpp"] = fgs.red,
    ["@include.cpp"] = {fg = c.red, gui = italic},
    ["@method.cpp"] = fgs.blue,
    ["@method.call.cpp"] = {fg = c.magenta, gui = bold},
    ["@field.cpp"] = fgs.aqua,
    ["@constructor.cpp"] = {fg = c.wave_red, gui = bold},
}

--  ╭─────╮
--  │ Zig │
--  ╰─────╯
hl.langs.zig = {
    zigTSTypeBuiltin = {fg = c.green, gui = bold},
    zigTSField = fgs.aqua,
    zigTSFuncMacro = fgs.aqua,
    zigTSAttribute = fgs.red,
    zigTSPunctBracket = fgs.orange,
    zigTSConstBuiltin = {fg = c.orange, gui = bold},
}

hl.langs08.zig = {
    ["@type.builtin.zig"] = {fg = c.green, gui = bold},
    ["@field.zig"] = fgs.aqua,
    ["@function.macro.zig"] = fgs.aqua,
    ["@attribute.zig"] = fgs.red,
    ["@punctuation.bracket.zig"] = fgs.orange,
    ["@constant.builtin.zig"] = {fg = c.orange, gui = bold},
}

--  ╭────────────╮
--  │ Shell/Bash │
--  ╰────────────╯
hl.langs.shell = {
    bashStatement = fgs.orange,
    shRange = fgs.fg0,
    shShebang = {fg = c.purple, gui = italic},
    shTestOpr = fgs.orange,
    shOption = fgs.orange,
    shOperator = fgs.orange,
    shQuote = fgs.yellow,
    shSet = fgs.orange,
    shSetList = fgs.blue,
    shSnglCase = fgs.orange,
    shVariable = fgs.blue,
    shVarAssign = fgs.orange,
    shCmdSubRegion = fgs.yellow,
    shCommandSub = fgs.orange,
    shFunctionOne = {fg = c.yellow, gui = bold},
    shFunctionKey = {fg = c.red, gui = italic},
    -- ════ Treesitter ════
    bashTSFuncBuiltin = fgs.red,
    bashTSParameter = fgs.green,
    bashTSConstant = fgs.blue,
    bashTSPunctSpecial = fgs.aqua,
    bashTSVariable = fgs.blue,
}

hl.langs08.shell = {
    ["@function.builtin.bash"] = fgs.red,
    ["@parameter.bash"] = fgs.green,
    ["@constant.bash"] = fgs.blue,
    ["@punctuation.special.bash"] = fgs.aqua,
    ["@variable.bash"] = fgs.blue,
}

hl.langs.zsh = {
    zshFlag = {link = "Special"},
    zshOptStart = {fg = c.purple, gui = italic},
    zshOption = {link = "Identifier"},
    zshSubst = fgs.green,
    zshSubstDelim = fgs.purple,
    zshFunction = {link = "TSFunction"},
    zshPrecommand = {fg = c.sea_green, gui = bold},
    zshPreproc = {fg = c.purple, gui = italic},
    zshDeref = fgs.blue,
    zshTypes = fgs.orange,
    zshVariable = fgs.blue,
    zshVariableDef = fgs.blue,
    zshNumber = fgs.purple,
    zshCommand = {fg = c.red, gui = bold},
    zshKeymap = {link = "TSConstBuiltin"},
    zshBrackets = {fg = c.blue},
    -- sh.vim
    zshDelim = {fg = c.blue},
}

--  ╭─────╮
--  │ Awk │
--  ╰─────╯
hl.langs.awk = {
    awkTSConditional = {link = "TSConditional"},
    awkTSFunction = {link = "TSFunction"},
    awkTSFuncBuiltin = {fg = c.red, gui = bold},
    awkTSFuncCall = {link = "TSFuncCall"},
    awkTSKeyword = {link = "TSKeyword"},
    awkTSKeywordFunction = {link = "TSKeywordFunction"},
    awkTSKeywordReturn = {link = "TSKeywordReturn"},
    awkTSLabel = {fg = c.ube, gui = bold},
    awkTSOperator = {link = "TSOperator"},
    awkTSParameter = fgs.salmon,
    awkTSPreproc = {link = "TSPreproc"},
    awkTSPunctBracket = fgs.blue,
    awkTSPunctDelimiter = fgs.green,
    awkTSRepeat = fgs.blue,
    awkTSString = {link = "TSString"},
    awkTSStringEscape = {link = "TSStringEscape"},
    --
    -- Unsupported (yet)
    --
    awkTSVariableBuiltin = {link = "TSTypeBuiltin"},
}

hl.langs08.awk = {
    ["@conditional.awk"] = {link = "@conditional"},
    ["@function.awk"] = {link = "@function"},
    ["@function.builtin.awk"] = {fg = c.red, gui = bold},
    ["@function.call.awk"] = {link = "@function.call"},
    ["@keyword.awk"] = {link = "@keyword"},
    ["@keyword.function.awk"] = {link = "@keyword.function"},
    ["@keyword.return.awk"] = {link = "@keyword.return"},
    ["@label.awk"] = {fg = c.ube, gui = bold},
    ["@operator.awk"] = {link = "@operator"},
    ["@parameter.awk"] = fgs.salmon,
    ["@preproc.awk"] = {link = "@preproc"},
    ["@punctuation.bracket.awk"] = fgs.blue,
    ["@punctuation.delimiter.awk"] = fgs.green,
    ["@repeat.awk"] = fgs.blue,
    ["@string.awk"] = {link = "@string"},
    ["@string.escape.awk"] = {link = "@string.escape"},
    --
    -- Unsupported (yet)
    --
    ["@variable.builtin.awk"] = {link = "@type.builtin"},
}

--  ╭─────╮
--  │ Sed │
--  ╰─────╯
hl.langs.sed = {
    sedST = {link = "Function"},
    sedRegexp47 = fgs.orange,
    sedLabel = fgs.wave_red,
    sedBranch = {fg = c.green, gui = bold},
    sedRegexpMeta = fgs.blue,
    sedRegexp58 = fgs.opera_muave,
    sedReplacement47 = fgs.yellow,
    sedFlag = {fg = c.red, gui = bold},
    sedReplacement58 = fgs.oni_violet,
}

--  ╭─────────╮
--  │ Comment │
--  ╰─────────╯
hl.langs.comment = {
    commentTSTag = fgs.peach_red,
    commentTSConstant = fgs.jasper_orange,
}

hl.langs08.comment = {
    ["@tag.comment"] = fgs.peach_red,
    ["@constant.comment"] = fgs.jasper_orange,
}

--  ╭──────╮
--  │ Dart │
--  ╰──────╯
hl.langs.dart = {
    -- dart-lang: https://github.com/dart-lang/dart-vim-plugin
    dartCoreClasses = fgs.aqua,
    dartTypeName = fgs.aqua,
    dartInterpolation = fgs.blue,
    dartTypeDef = {fg = c.red, gui = italic},
    dartClassDecl = {fg = c.red, gui = italic},
    dartLibrary = {fg = c.purple, gui = italic},
    dartMetadata = fgs.blue,
}

--  ╭──────────────╮
--  │ CoffeeScript │
--  ╰──────────────╯
hl.langs.coffeescript = {
    -- vim-coffee-script: https://github.com/kchmck/vim-coffee-script
    coffeeExtendedOp = fgs.orange,
    coffeeSpecialOp = fgs.fg0,
    coffeeDotAccess = fgs.coyote_brown1,
    coffeeCurly = fgs.fg0,
    coffeeParen = fgs.fg0,
    coffeeBracket = fgs.fg0,
    coffeeParens = fgs.blue,
    coffeeBrackets = fgs.blue,
    coffeeCurlies = fgs.blue,
    coffeeOperator = {fg = c.red, gui = italic},
    coffeeStatement = fgs.orange,
    coffeeSpecialIdent = fgs.purple,
    coffeeObject = fgs.purple,
    coffeeObjAssign = fgs.aqua,
}

--  ╭────────────╮
--  │ ObjectiveC │
--  ╰────────────╯
hl.langs.objectivec = {
    objcModuleImport = {fg = c.purple, gui = italic},
    objcException = {fg = c.red, gui = italic},
    objcProtocolList = fgs.aqua,
    objcObjDef = {fg = c.purple, gui = italic},
    objcDirective = {fg = c.red, gui = italic},
    objcPropertyAttribute = fgs.orange,
    objcHiddenArgument = fgs.aqua,
}

--  ╭────────╮
--  │ Kotlin │
--  ╰────────╯
hl.langs.kotlin = {
    -- kotlin-vim: https://github.com/udalov/kotlin-vim
    ktSimpleInterpolation = fgs.green,
    ktComplexInterpolation = fgs.green,
    ktComplexInterpolationBrace = fgs.green,
    ktStructure = {fg = c.red, gui = italic},
    ktKeyword = fgs.aqua,
}

--  ╭───────╮
--  │ Scala │
--  ╰───────╯
hl.langs.scala = {
    -- vim-scala: https://github.com/derekwyatt/vim-scala
    scalaNameDefinition = fgs.aqua,
    scalaInterpolationBoundary = fgs.green,
    scalaInterpolation = fgs.blue,
    scalaTypeOperator = fgs.orange,
    scalaOperator = fgs.orange,
    scalaKeywordModifier = fgs.orange,
}

--  ╭───────╮
--  │ Swift │
--  ╰───────╯
hl.langs.swift = {
    -- swift.vim: https://github.com/keith/swift.vim
    swiftInterpolatedWrapper = fgs.green,
    swiftInterpolatedString = fgs.blue,
    swiftProperty = fgs.aqua,
    swiftTypeDeclaration = fgs.orange,
    swiftClosureArgument = fgs.purple,
}

--  ╭─────╮
--  │ PHP │
--  ╰─────╯
hl.langs.php = {
    -- php.vim: https://github.com/StanAngeloff/php.vim
    phpParent = fgs.fg0,
    phpNowDoc = fgs.yellow,
    phpFunction = {fg = c.yellow, gui = bold},
    phpMethod = {fg = c.yellow, gui = bold},
    phpClass = fgs.orange,
    phpSuperglobals = fgs.purple,
    phpFunctions = {fg = c.purple, gui = bold},
    phpMethods = fgs.aqua,
    phpStructure = fgs.purple,
    phpOperator = fgs.purple,
    phpMemberSelector = fgs.fg0,
    phpVarSelector = {fg = c.orange, gui = italic},
    phpIdentifier = {fg = c.orange, gui = italic},
    phpBoolean = fgs.aqua,
    phpNumber = fgs.orange,
    phpHereDoc = fgs.green,
    phpSCKeyword = {fg = c.purple, gui = italic},
    phpFCKeyword = {fg = c.purple, gui = italic},
    phpRegion = fgs.blue,
}

--  ╭─────────╮
--  │ Haskell │
--  ╰─────────╯
hl.langs.haskell = {
    -- haskell-vim: https://github.com/neovimhaskell/haskell-vim
    haskellBrackets = fgs.blue,
    haskellIdentifier = fgs.green,
    haskellAssocType = fgs.aqua,
    haskellQuotedType = fgs.aqua,
    haskellType = fgs.aqua,
    haskellDeclKeyword = {fg = c.red, gui = italic},
    haskellWhere = {fg = c.red, gui = italic},
    haskellDeriving = {fg = c.purple, gui = italic},
    haskellForeignKeywords = {fg = c.purple, gui = italic},
}

--  ╭───────╮
--  │ OCaml │
--  ╰───────╯
hl.langs.ocaml = {
    -- vim-ocaml: https://github.com/rgrinberg/vim-ocaml
    ocamlArrow = fgs.orange,
    ocamlEqual = fgs.orange,
    ocamlOperator = fgs.orange,
    ocamlKeyChar = fgs.orange,
    ocamlModPath = fgs.yellow,
    ocamlFullMod = fgs.yellow,
    ocamlModule = fgs.purple,
    ocamlConstructor = fgs.aqua,
    ocamlFuncWith = fgs.green,
    ocamlWith = fgs.green,
    ocamlModParam = fgs.fg0,
    ocamlAnyVar = fgs.blue,
    ocamlPpxEncl = fgs.orange,
    ocamlPpxIdentifier = fgs.blue,
    ocamlSigEncl = fgs.orange,
    ocamlStructEncl = fgs.aqua,
    ocamlModParam1 = fgs.blue,
}

--  ╭────────╮
--  │ Erlang │
--  ╰────────╯
hl.langs.erlang = {
    -- vim-erlang: https://github.com/vim-erlang/vim-erlang-runtime
    erlangAtom = fgs.aqua,
    erlangLocalFuncRef = {fg = c.yellow, gui = bold},
    erlangLocalFuncCall = {fg = c.yellow, gui = bold},
    erlangGlobalFuncRef = {fg = c.yellow, gui = bold},
    erlangGlobalFuncCall = {fg = c.yellow, gui = bold},
    erlangAttribute = {fg = c.purple, gui = italic},
    erlangPipe = fgs.orange,
}

--  ╭────────╮
--  │ Elixir │
--  ╰────────╯
hl.langs.elixir = {
    -- vim-elixir: https://github.com/elixir-editors/vim-elixir
    elixirStringDelimiter = fgs.yellow,
    elixirKeyword = fgs.orange,
    elixirInterpolation = fgs.green,
    elixirInterpolationDelimiter = fgs.green,
    elixirSelf = fgs.purple,
    elixirPseudoVariable = fgs.purple,
    elixirModuleDefine = {fg = c.purple, gui = italic},
    elixirBlockDefinition = {fg = c.red, gui = italic},
    elixirDefine = {fg = c.red, gui = italic},
    elixirPrivateDefine = {fg = c.red, gui = italic},
    elixirGuard = {fg = c.red, gui = italic},
    elixirPrivateGuard = {fg = c.red, gui = italic},
    elixirProtocolDefine = {fg = c.red, gui = italic},
    elixirImplDefine = {fg = c.red, gui = italic},
    elixirRecordDefine = {fg = c.red, gui = italic},
    elixirPrivateRecordDefine = {fg = c.red, gui = italic},
    elixirMacroDefine = {fg = c.red, gui = italic},
    elixirPrivateMacroDefine = {fg = c.red, gui = italic},
    elixirDelegateDefine = {fg = c.red, gui = italic},
    elixirOverridableDefine = {fg = c.red, gui = italic},
    elixirExceptionDefine = {fg = c.red, gui = italic},
    elixirCallbackDefine = {fg = c.red, gui = italic},
    elixirStructDefine = {fg = c.red, gui = italic},
    elixirExUnitMacro = {fg = c.red, gui = italic},
}

--  ╭─────────╮
--  │ Clojure │
--  ╰─────────╯
hl.langs.clojure = {
    -- vim-clojure: https://github.com/guns/vim-clojure-static
    clojureMacro = {fg = c.purple, gui = italic},
    clojureFunc = {fg = c.aqua, gui = bold},
    clojureConstant = fgs.green,
    clojureSpecial = {fg = c.red, gui = italic},
    clojureDefine = {fg = c.red, gui = italic},
    clojureKeyword = fgs.orange,
    clojureVariable = fgs.blue,
    clojureMeta = fgs.green,
    clojureDeref = fgs.green,
}

--  ╭───╮
--  │ R │
--  ╰───╯
hl.langs.r = {
    rFunction = {fg = c.purple, gui = bold},
    rType = {fg = c.green, gui = bold},
    rRegion = {fg = c.purple, gui = bold},
    rAssign = {fg = c.red, gui = bold},
    rBoolean = fgs.orange,
    rOperator = fgs.orange,
    rSection = fgs.orange,
    rRepeat = fgs.purple,
}

--  ╭────────╮
--  │ Matlab │
--  ╰────────╯
hl.langs.matlab = {
    matlabSemicolon = fgs.fg0,
    matlabFunction = {fg = c.red, gui = italic},
    matlabImplicit = {fg = c.yellow, gui = bold},
    matlabDelimiter = fgs.fg0,
    matlabOperator = {fg = c.yellow, gui = bold},
    matlabArithmeticOperator = fgs.orange,
    matlabRelationalOperator = fgs.orange,
    matlabLogicalOperator = fgs.orange,
}

--  ╭─────────╮
--  │ ManPage │
--  ╰─────────╯
hl.langs.man = {
    manSectionHeading = {link = "Statement"},
    manTitle = {link = "Title"},
    manReference = {fg = c.sea_green, gui = bold},
}

--  ╭────╮
--  │ JQ │
--  ╰────╯
hl.langs.jq = {
    jqTSNumber = {link = "TSNumber"},
    jqTSString = {link = "TSString"},
    jqTSConditional = {link = "TSConditional"},
    jqTSKeyword = {link = "TSKeyword"},
    jqTSFunction = {link = "TSFunction"},
    jqTSOperator = {link = "TSOperator"},
    jqTSBoolean = {link = "TSBoolean"},
    jqTSFuncBuiltin = {fg = c.green, gui = bold},
    jqTSPunctBracket = fgs.puce,
    jqTSVariable = fgs.blue,
    jqTSProperty = fgs.aqua,
    -- Unsupported (as of now)
    jqTSFuncCall = {link = "TSFuncCall"},
    -- Custom
}

hl.langs08.jq = {
    ["@number.jq"] = {link = "@number"},
    ["@string.jq"] = {link = "@string"},
    ["@conditional.jq"] = {link = "@conditional"},
    ["@keyword.jq"] = {link = "@keyword"},
    ["@function.jq"] = {link = "@function"},
    ["@operator.jq"] = {link = "@operator"},
    ["@boolean.jq"] = {link = "@boolean"},
    ["@function.builtin.jq"] = {fg = c.green, gui = bold},
    ["@punctuation.bracket.jq"] = fgs.puce,
    ["@variable.jq"] = fgs.blue,
    ["@property.jq"] = fgs.aqua,
    ["@type.builtin.jq"] = {fg = c.orange, gui = bold},
    -- Unsupported (as of now)
    ["@function.call.jq"] = {link = "@function.call"},
    -- Custom
    ["@repeat.jq"] = {fg = c.wave_red, gui = bold},
    ["@collections.jq"] = {fg = c.sea_green, gui = bold},
    ["@function.error.jq"] = {fg = c.red, gui = bold},
    ["@function.other.jq"] = {fg = c.red, gui = bold},
    ["@function.test.jq"] = {fg = c.blue, gui = bold},
}

--  ╭─────────╮
--  │ GraphQL │
--  ╰─────────╯
hl.langs.graphql = {
    graphqlTSParameter = fgs.blue,
    graphqlTSVariable = {fg = c.magenta, gui = bold},
    graphqlTSProperty = fgs.aqua,
    graphqlTSPunctBracket = fgs.purple,
}

hl.langs08.graphql = {
    ["@parameter.graphql"] = fgs.blue,
    ["@variable.graphql"] = {fg = c.magenta, gui = bold},
    ["@property.graphql"] = fgs.aqua,
    ["@punctuation.bracket.graphql"] = fgs.purple,
}

--  ╭─────╮
--  │ CSS │
--  ╰─────╯
hl.langs.css = {
    cssCustomProp = fgs.aqua,
    cssPseudoClass = fgs.green,
    cssPseudoClassId = {link = "PreProc"},
    cssMediaType = {link = "Special"},
    cssAtRule = {link = "Special"},
    -- ════ Treesitter ════
    cssTSProperty = fgs.orange,
    cssTSPropertyClass = {fg = c.sea_green, gui = bold},
    cssTSPropertyId = {fg = c.purple, gui = bold},
    cssTSKeyword = {fg = c.red, gui = bold},
    cssTSFunction = {link = "TSFunction"},
    cssTSString = {link = "TSString"},
    cssTSStringPlain = {fg = c.aqua},
    cssTSType = {fg = c.green, gui = bold},
    cssTSTypeQualifier = {fg = c.amethyst, gui = bold},
    cssTSTypeTag = {fg = c.red, gui = bold},
    cssTSTypeDefinition = fgs.old_rose,
    cssTSPunctBracket = fgs.blue,
    cssTSPunctDelimiter = {link = "TSPunctDelimiter"},
    cssTSInclude = {fg = c.sea_green, gui = bold},
    cssTSNamespace = {fg = c.deep_lilac, gui = bold},
    cssTSOperator = {fg = c.wave_red, gui = bold},
}

hl.langs08.css = {
    ["@property.css"] = fgs.orange,
    ["@property.class.css"] = {fg = c.sea_green, gui = bold},
    -- ["@property.id.css"] = {fg = c.blue, gui = bold},
    ["@property.id.css"] = {fg = c.purple, gui = bold},
    ["@keyword.css"] = {fg = c.red, gui = bold},
    ["@function.css"] = {link = "@function"},
    ["@string.css"] = {link = "@string"},
    ["@string.plain.css"] = {fg = c.aqua},
    ["@type.css"] = {fg = c.green, gui = bold},
    ["@type.qualifier.css"] = {fg = c.amethyst, gui = bold},
    ["@type.tag.css"] = {fg = c.red, gui = bold},
    ["@type.definition.css"] = fgs.old_rose,
    ["@punctuation.bracket.css"] = fgs.blue,
    ["@punctuation.delimiter.css"] = {link = "@punctuation.delimiter"},
    ["@include.css"] = {fg = c.sea_green, gui = bold},
    ["@namespace.css"] = {fg = c.deep_lilac, gui = bold},
    ["@operator.css"] = {fg = c.wave_red, gui = bold},
    -- Custom
    ["@string.unit.css"] = fgs.salmon,
}

--  ╭──────╮
--  │ SCSS │
--  ╰──────╯
hl.langs.scss = {
    -- ════ Treesitter ════
    scssTSProperty = fgs.orange,
    scssTSVariable = fgs.blue,
    scssTSString = fgs.yellow,
    scssTSKeyword = fgs.red,
    scssTSRepeat = fgs.purple,
    scssTSType = {fg = c.red, gui = bold},
    scssTSPunctDelimiter = fgs.aqua,
}

hl.langs08.scss = {
    ["@property.scss"] = fgs.orange,
    ["@variable.scss"] = fgs.blue,
    ["@string.scss"] = fgs.yellow,
    ["@keyword.scss"] = fgs.red,
    ["@repeat.scss"] = fgs.purple,
    ["@type.scss"] = {fg = c.red, gui = bold},
    ["@punctuation.delimiter.scss"] = fgs.aqua,
}

--  ╭──────╮
--  │ HTML │
--  ╰──────╯
hl.langs.html = {
    htmlBold = {fg = c.deep_lilac, gui = bold},
    -- ════ Treesitter ════
    htmlTSTagAttribute = {fg = c.green, gui = bold},
    htmlTSText = fgs.fg0,
    htmlTSTag = {fg = c.red, gui = bold},
    htmlTSTagDelimiter = {fg = c.magenta, gui = bold},
}

hl.langs08.html = {
    ["@tag.attribute.html"] = {fg = c.green, gui = bold},
    ["@text.html"] = fgs.fg0,
    ["@tag.html"] = {fg = c.red, gui = bold},
    ["@tag.delimiter.html"] = {fg = c.magenta, gui = bold},
}

--  ╭──────────────────────────────────────────────────────────╮
--  │                      Config Formats                      │
--  ╰──────────────────────────────────────────────────────────╯

--  ╭──────────────╮
--  │ EditorConfig │
--  ╰──────────────╯
hl.langs.editorconfig = {
    editorconfigUnknownProperty = {link = "Identifier"},
    editorconfigProperty = {link = "dosiniLabel"},
}

--  ╭────────────╮
--  │ conf / cfg │
--  ╰────────────╯
hl.langs.conf = {
    CfgSection = {link = "Type"},
    CfgValues = {link = "Constant"},
    CfgOnOff = {link = "Boolean"},
    CfgString = {link = "String"},
}

--  ╭────────╮
--  │ DosIni │
--  ╰────────╯
hl.langs.ini = {
    dosiniLabel = fgs.green,
    dosiniValue = fgs.yellow,
    dosiniNumber = fgs.purple,
    dosiniHeader = {fg = c.red, gui = bold},
    -- ════ Treesitter ════
    iniTSType = {fg = c.red, gui = bold},
    iniTSPunctBracket = fgs.purple,
    iniTSProperty = fgs.green,
    iniTSText = fgs.yellow,
}

hl.langs08.dosini = {
    ["@type.ini"] = {fg = c.red, gui = bold},
    ["@punctuation.bracket.ini"] = fgs.purple,
    ["@property.ini"] = fgs.green,
    ["@text.ini"] = fgs.yellow,
}

--  ╭───────╮
--  │ CMake │
--  ╰───────╯
hl.langs.cmake = {
    cmakeCommand = {link = "Function"},
    cmakeVariable = fgs.blue,
    cmakeGeneratorExpressions = fgs.aqua,
    cmakeKWset = {fg = c.red, gui = bold},
    cmakeKWfind_package = {fg = c.orange, gui = bold},
    cmakeKWadd_library = {fg = c.yellow, gui = bold},
    cmakeKWproject = {fg = c.oni_violet, gui = bold},
    cmakeKWtry_run = {fg = c.salmon, gui = bold},
    cmakeKWget_cmake_property = {fg = c.sea_green, gui = bold},
    cmakeVariableValue = {link = "Type"},
    -- ════ Treesitter ════
    cmakeTSBoolean = {fg = c.orange, gui = bold},
    cmakeTSConstant = {link = "TSConstant"},
    cmakeTSKeywordOperator = {link = "TSKeywordReturn"},
    cmakeTSPunctSpecial = {link = "TSPunctSpecial"},
}

hl.langs08.cmake = {
    ["@boolean.cmake"] = {fg = c.orange, gui = bold},
    ["@constant.cmake"] = {link = "@constant"},
    ["@keyword.operator.cmake"] = {link = "@keyword.return"},
    ["@punctuation.special.cmake"] = {link = "@punctuation.special"},
}

--  ╭──────────╮
--  │ MakeFile │
--  ╰──────────╯
hl.langs.makefile = {
    makeIdent = fgs.aqua,
    makeSpecTarget = {fg = c.green, gui = bold},
    makeTarget = fgs.blue,
    makeCommands = fgs.orange,
    makeSpecial = fgs.magenta,
    -- ════ Treesitter ════
    makefileTSFuncBuiltin = {link = "@function.builtin"},
    makefileTSFuncCall = {link = "@function.call"},
    makefileTSParameter = fgs.orange,
}

hl.langs08.makefile = {
    ["@function.builtin.makefile"] = {link = "@function.builtin"},
    ["@function.call.makefile"] = {link = "@function.call"},
    ["@parameter.makefile"] = fgs.orange,
}

--  ╭──────╮
--  │ JSON │
--  ╰──────╯
hl.langs.json = {
    jsonKeyword = fgs.orange,
    jsonQuote = fgs.coyote_brown1,
    jsonBraces = fgs.blue,
    -- ════ Treesitter ════
    jsonTSLabel = fgs.orange,
    jsonTSBoolean = fgs.red,
    jsonTSPunctBracket = fgs.blue,
    jsonTSConstBuiltin = {link = "@function"},
}

hl.langs08.json = {
    ["@label.json"] = fgs.orange,
    ["@boolean.json"] = fgs.red,
    ["@punctuation.bracket.json"] = fgs.blue,
    ["@constant.builtin.json"] = {link = "@function"},
}

--  ╭──────╮
--  │ YAML │
--  ╰──────╯
hl.langs.yaml = {
    yamlKey = fgs.orange,
    yamlConstant = {fg = c.red, gui = bold},
    yamlBlockMappingKey = fgs.blue,
    yamlFloat = fgs.purple,
    yamlInteger = fgs.purple,
    yamlKeyValueDelimiter = fgs.green,
    yamlDocumentStart = {fg = c.orange, gui = bold},
    yamlDocumentEnd = {fg = c.orange, gui = bold},
    yamlPlainScalar = fgs.fg0,
    yamlBlockCollectionItemStart = fgs.orange,
    yamlAnchor = {fg = c.green, gui = bold},
    yamlAlias = {fg = c.green, gui = bold},
    yamlNodeTag = {fg = c.green, gui = bold},
    yamlBlockMappingMerge = fgs.green,
    yamlDirective = {fg = c.red, gui = bold},
    yamlYAMLDirective = {fg = c.red, gui = bold},
    yamlYAMLVersion = fgs.magenta,
    -- ════ Treesitter ════
    yamlTSBoolean = {fg = c.red, gui = bold},
    yamlTSConstBuiltin = {fg = c.orange, gui = bold},
    yamlTSField = fgs.blue,
    yamlTSPreproc = {fg = c.sea_green, gui = bold},
    yamlTSPunctBracket = fgs.orange,
    yamlTSPunctSpecial = {link = "TSTypeBuiltin"},
    yamlTSType = {link = "TSTypeBuiltin"},
}

hl.langs08.yaml = {
    ["@boolean.yaml"] = {fg = c.red, gui = bold},
    ["@constant.builtin.yaml"] = {fg = c.orange, gui = bold},
    ["@field.yaml"] = fgs.blue,
    ["@preproc.yaml"] = {fg = c.sea_green, gui = bold},
    ["@punctuation.delimiter.yaml"] = fgs.orange,
    ["@punctuation.special.yaml"] = {link = "@type.builtin"},
    ["@type.yaml"] = {link = "@type.builtin"},
}

--  ╭──────╮
--  │ TOML │
--  ╰──────╯
hl.langs.toml = {
    tomlTable = {fg = c.purple, gui = bold},
    tomlKey = fgs.orange,
    tomlBoolean = fgs.aqua,
    tomlTableArray = {fg = c.purple, gui = bold},
    tomlKeyValueArray = {fg = c.purple, gui = bold},
    -- ════ Treesitter ════
    tomlTSProperty = fgs.orange,
    tomlTSType = fgs.magenta,
    tomlTSBoolean = {fg = c.red, gui = bold},
    tomlTSPunctBracket = {link = "TSFunction"},
}

hl.langs08.toml = {
    ["@property.toml"] = fgs.orange,
    ["@type.toml"] = fgs.magenta,
    ["@boolean.toml"] = {fg = c.red, gui = bold},
    ["@punctuation.bracket.toml"] = {link = "@function"},
}

--  ╭─────╮
--  │ RON │
--  ╰─────╯
hl.langs.ron = {
    ronIdentifier = fgs.green,
    ronKey = fgs.red,
    ronInteger = fgs.purple,
    ronString = fgs.yellow,
    ronBoolean = fgs.orange,
    -- ════ Treesitter ════
    ronTSProperty = fgs.red,
    ronTSNumber = {link = "TSNumber"},
    ronTSString = {link = "TSString"},
    ronTSBoolean = {fg = c.red, gui = bold},
    ronTSConstant = {link = "TSConstant"},
    ronTSPunctBracket = fgs.blue,
    ronTSType = {link = "TSTypeBuiltin"},
}

hl.langs08.ron = {
    ["@property.ron"] = fgs.red,
    ["@number.ron"] = {link = "@number"},
    ["@string.ron"] = {link = "@string"},
    ["@boolean.ron"] = {link = "@boolean"},
    ["@constant.ron"] = {link = "@constant"},
    ["@punctuation.bracket.ron"] = fgs.blue,
    ["@type.ron"] = {link = "@type.builtin"},
}

--  ╭─────────╮
--  │ sxhkdrc │
--  ╰─────────╯
hl.langs.sxhkdrc = {
    sxhkdrcTSOperator = fgs.orange,
    sxhkdrcTSKeyword = fgs.red,
    sxhkdrcTSVariable = fgs.blue,
    sxhkdrcTSPunctBracket = fgs.green,
}

hl.langs08.sxhkdrc = {
    ["@operator.sxhkdrc"] = fgs.orange,
    ["@keyword.sxhkdrc"] = fgs.red,
    ["@variable.sxhkdrc"] = fgs.blue,
    ["@punctuation.bracket.sxhkdrc"] = fgs.green,
}

--  ╭───────────╮
--  │ GitIgnore │
--  ╰───────────╯
hl.langs.gitignore = {
    gitignoreTSPunctDelimiter = {fg = c.blue, gui = bold},
    gitignoreTSPunctBracket = {fg = c.magenta, gui = bold},
    gitignoreTSOperator = {fg = c.orange, gui = bold},
}

hl.langs08.gitignore = {
    ["@punctuation.delimiter.gitignore"] = {fg = c.blue, gui = bold},
    ["@punctuation.bracket.gitignore"] = {fg = c.magenta, gui = bold},
    ["@operator.gitignore"] = {fg = c.orange, gui = bold},
}

--  ╭───────────╮
--  │ GitConfig │
--  ╰───────────╯
hl.langs.gitconfig = {
    gitConfigSection = {link = "Keyword"},
    gitConfigVariable = fgs.blue,
    gitConfigBoolean = {link = "Boolean"},
    -- ════ Treesitter ════
    git_configTSType = fgs.red,
    git_configTSProperty = fgs.blue,
    git_configTSPunctBracket = fgs.purple,
    git_configTSStringSpecial = fgs.green,
}

hl.langs08.gitconfig = {
    ["@type.git_config"] = fgs.red,
    ["@property.git_config"] = fgs.blue,
    ["@punctuation.bracket.git_config"] = fgs.purple,
    ["@string.special.git_config"] = fgs.green,
}

--  ╭───────────╮
--  │ GitCommit │
--  ╰───────────╯
hl.langs.gitcommit = {
    gitcommitSummary = fgs.red,
    gitcommitUntracked = fgs.coyote_brown1,
    gitcommitDiscarded = fgs.coyote_brown1,
    gitcommitSelected = fgs.coyote_brown1,
    gitcommitUnmerged = fgs.coyote_brown1,
    gitcommitOnBranch = fgs.coyote_brown1,
    gitcommitArrow = fgs.coyote_brown1,
    gitcommitFile = fgs.yellow,
}

-- ============================== Plugins =============================
-- ====================================================================
local diag_under = utils.tern(undercurl == "undercurl", undercurl, "underline")
hl.plugins.lsp = {
    LspCxxHlSkippedRegion = fgs.coyote_brown1,
    LspCxxHlSkippedRegionBeginEnd = {fg = c.purple, gui = italic},
    LspCxxHlGroupEnumConstant = fgs.aqua,
    LspCxxHlGroupNamespace = fgs.purple,
    LspCxxHlGroupMemberVariable = fgs.aqua,
    DiagnosticError = fgs.red,
    DiagnosticWarn = fgs.yellow,
    DiagnosticInfo = fgs.blue,
    DiagnosticHint = fgs.aqua,
    DiagnosticVirtualTextError = {
        bg = utils.tern(cfg.diagnostics.background, utils.darken(c.red, 0.1, c.bg0), c.none),
        fg = c.red,
    },
    DiagnosticVirtualTextWarn = {
        bg = utils.tern(cfg.diagnostics.background, utils.darken(c.yellow, 0.1, c.bg0), c.none),
        fg = c.yellow,
    },
    DiagnosticVirtualTextInfo = {
        bg = utils.tern(cfg.diagnostics.background, utils.darken(c.aqua, 0.1, c.bg0), c.none),
        fg = c.aqua,
    },
    DiagnosticVirtualTextHint = {
        bg = utils.tern(cfg.diagnostics.background, utils.darken(c.purple, 0.1, c.bg0), c.none),
        fg = c.purple,
    },
    -- DiagnosticVirtualTextError = {
    --   bg = cfg.diagnostics.background and c.bg0 or c.bg4,
    --   fg = c.purple
    -- },

    DiagnosticUnderlineError = {gui = diag_under, sp = c.red},
    DiagnosticUnderlineHint = {gui = diag_under, sp = c.purple},
    DiagnosticUnderlineInfo = {gui = diag_under, sp = c.aqua},
    DiagnosticUnderlineWarn = {gui = diag_under, sp = c.yellow},
    LspReferenceText = {bg = c.fg2},
    LspReferenceWrite = {bg = c.fg2},
    LspReferenceRead = {bg = c.fg2},
    LspSignatureActiveParameter = fgs.yellow,
    LspCodeLens = fgs.coyote_brown1,
}

hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError
hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint
hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo
hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp.DiagnosticVirtualTextError
hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp.DiagnosticVirtualTextWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp.DiagnosticVirtualTextInfo
hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp.DiagnosticVirtualTextHint

-- https://github.com/folke/lsp-trouble.nvim
hl.plugins.lsp_trouble = {
    LspTroubleText = {fg = c.fg0},
    LspTroubleCount = {fg = c.blue},
    LspTroubleNormal = {fg = c.magenta},
}

-- https://github.com/glepnir/lspsaga.nvim
hl.plugins.lsp_saga = {
    -- LspFloatWinNormal = {bg = c.bg_float},
    -- LspSagaFinderSelection = {fg = c.bg_visual},
    LspFloatWinBorder = {fg = c.magenta},
    LspSagaBorderTitle = {fg = c.aqua},
    LspSagaHoverBorder = {fg = c.blue},
    LspSagaRenameBorder = {fg = c.green},
    LspSagaDefPreviewBorder = {fg = c.green},
    LspSagaCodeActionBorder = {fg = c.blue},
    LspSagaCodeActionTitle = {fg = c.aqua},
    LspSagaCodeActionContent = {fg = c.purple},
    LspSagaSignatureHelpBorder = {fg = c.red},
    ReferencesCount = {fg = c.purple},
    DefinitionCount = {fg = c.purple},
    DefinitionIcon = {fg = c.blue},
    ReferencesIcon = {fg = c.blue},
    TargetWord = {fg = c.aqua},
}

-- https://github.com/hrsh7th/nvim-cmp
hl.plugins.cmp = {
    CmpItemAbbr = fgs.fg0,
    CmpItemAbbrDeprecated = fgs.fg0,
    CmpItemAbbrMatch = fgs.aqua,
    CmpItemAbbrMatchFuzzy = {fg = c.aqua, gui = underline},
    CmpItemMenu = fgs.grullo_grey,
    CmpItemKindDefault = fgs.purple,
    CmpItemKindClass = fgs.yellow,
    CmpItemKindColor = fgs.green,
    CmpItemKindConstant = fgs.orange,
    CmpItemKindConstructor = fgs.blue,
    CmpItemKindEnum = fgs.purple,
    CmpItemKindEnumMember = fgs.yellow,
    CmpItemKindEvent = fgs.yellow,
    CmpItemKindField = fgs.purple,
    CmpItemKindFile = fgs.blue,
    CmpItemKindFolder = fgs.orange,
    CmpItemKindFunction = fgs.blue,
    CmpItemKindInterface = fgs.green,
    CmpItemKindKeyword = fgs.aqua,
    CmpItemKindMethod = fgs.blue,
    CmpItemKindModule = fgs.orange,
    CmpItemKindOperator = fgs.red,
    CmpItemKindProperty = fgs.aqua,
    CmpItemKindReference = fgs.orange,
    CmpItemKindSnippet = fgs.red,
    CmpItemKindStruct = fgs.purple,
    CmpItemKindText = fgs.coyote_brown1,
    CmpItemKindTypeParameter = fgs.red,
    CmpItemKindUnit = fgs.green,
    CmpItemKindValue = fgs.orange,
    CmpItemKindVariable = fgs.purple,
}

-- https://github.com/neoclide/coc.nvim
hl.plugins.coc = {
    -- CocSnippetVisual = {bg = c.bg4}, -- highlight snippet placeholders
    CocHoverRange = {fg = c.none, gui = underbold}, -- range of current hovered symbol
    CocHighlightText = {bg = c.fg2},                -- Coc cursorhold event
    CocHintHighlight = {fg = c.none, gui = undercurl, sp = c.aqua},
    CocErrorHighlight = {fg = c.none, gui = undercurl, sp = c.red},
    CocWarningHighlight = {fg = c.none, gui = undercurl, sp = c.yellow},
    CocInfoHighlight = {fg = c.none, gui = undercurl, sp = c.blue},
    CocFloating = {fg = c.fg1, bg = c.bg3},
    CocErrorFloat = {fg = c.red, bg = c.bg3},
    CocWarningFloat = {fg = c.green, bg = c.bg3},
    CocInfoFloat = {fg = c.blue, bg = c.bg3},
    CocHintFloat = {fg = c.aqua, bg = c.bg3},
    CocErrorSign = fgs.red,
    CocWarningSign = fgs.yellow,
    CocInfoSign = fgs.blue,
    CocHintSign = fgs.amethyst,
    CocInlayHint = fgs.russian_green,
    CocInlayHintParameter = fgs.russian_green,
    CocInlayHintType = fgs.amethyst,
    CocErrorVirtualText = fgs.coyote_brown1,
    CocWarningVirtualText = fgs.coyote_brown1,
    CocInfoVirtualText = fgs.coyote_brown1,
    CocHintVirtualText = fgs.coyote_brown1,
    -- Symbols --
    CocSymbolFile = fgs.green,
    CocSymbolModule = fgs.red,
    CocSymbolNamespace = fgs.orange,
    CocSymbolPackage = fgs.red,
    CocSymbolClass = fgs.blue,
    CocSymbolMethod = fgs.magenta,
    CocSymbolProperty = fgs.aqua,
    CocSymbolField = fgs.aqua,
    CocSymbolConstructor = fgs.red,
    CocSymbolEnum = fgs.green,
    CocSymbolInterface = fgs.red,
    CocSymbolFunction = fgs.red,
    CocSymbolVariable = fgs.fg1,
    CocSymbolConstant = fgs.magenta,
    CocSymbolString = fgs.yellow,
    CocSymbolNumber = fgs.purple,
    CocSymbolBoolean = fgs.orange,
    CocSymbolArray = fgs.green,
    CocSymbolObject = fgs.orange,
    CocSymbolKey = fgs.purple,
    CocSymbolNull = fgs.orange,
    CocSymbolEnumMember = fgs.aqua,
    CocSymbolStruct = fgs.red,
    CocSymbolEvent = fgs.red,
    CocSymbolOperator = fgs.orange,
    CocSymbolTypeParameter = fgs.green,
    -- CocSymbolDefault = {},
    -- CocSelectedText for sign text of selected lines.
    -- CocSelectedLine for line highlight of selected lines.

    -- TODO: For non-matched
    CocSearch = fgs.orange,                 -- for matched input characters
    CocDisabled = fgs.grullo_grey,
    CocFadeOut = fgs.wenge_grey,            -- faded text (i.e., not used) CocUnusedHighlight CocDeprecatedHighlight
    CocCursorRange = {fg = c.bg1, bg = c.fuzzy_wuzzy},
    CocMenuSel = {fg = c.none, bg = c.bg1}, -- current menu item in menu dialog
    CocCodeLens = fgs.coyote_brown1,
    -- Popup Menu --
    CocPumSearch = {fg = c.orange}, -- for menu of complete items
    CocPumMenu = {fg = c.fg1},      -- items at the end like [LS]
    CocPumDeprecated = fgs.red,
    CocPumVirtualText = {fg = c.coyote_brown1},
    -- Tree --
    CocTreeTitle = {fg = c.red, gui = "bold"},
    -- Notification --
    CocNotificationButton = {fg = c.red, gui = "bold"},
    CocNotificationProgress = {fg = c.blue, bg = "none"},
    CocNotificationError = fgs.red,
    CocNotificationWarning = fgs.yellow,
    CocNotificationInfo = fgs.blue,
    -- Coc-Git --
    CocGitAddedSign = fgs.yellow,
    CocGitChangeRemovedSign = fgs.purple,
    CocGitChangedSign = fgs.blue,
    CocGitRemovedSign = fgs.red,
    CocGitTopRemovedSign = fgs.red,
    -- Coc-Explorer --
    CocExplorerBufferRoot = fgs.orange,
    CocExplorerBufferExpandIcon = fgs.aqua,
    CocExplorerBufferBufnr = fgs.purple,
    CocExplorerBufferModified = fgs.red,
    CocExplorerBufferBufname = fgs.coyote_brown,
    CocExplorerBufferFullpath = fgs.coyote_brown,
    CocExplorerFileRoot = fgs.orange,
    CocExplorerFileExpandIcon = fgs.aqua,
    CocExplorerFileFullpath = fgs.coyote_brown,
    CocExplorerFileDirectory = fgs.yellow,
    CocExplorerFileGitStage = fgs.purple,
    CocExplorerFileGitUnstage = fgs.green,
    CocExplorerFileSize = fgs.blue,
    CocExplorerTimeAccessed = fgs.aqua,
    CocExplorerTimeCreated = fgs.aqua,
    CocExplorerTimeModified = fgs.aqua,
    -- Custom --
    CocSuggestFloating = {fg = c.fg0, bg = c.bg3}, -- bg0
}

-- https://github.com/dense-analysis/ale
hl.plugins.ale = {
    ALEError = {fg = c.none, gui = undercurl, sp = c.red},
    ALEWarning = {fg = c.none, gui = undercurl, sp = c.yellow},
    ALEInfo = {fg = c.none, gui = undercurl, sp = c.blue},
    ALEErrorSign = fgs.red,
    ALEWarningSign = fgs.green,
    ALEInfoSign = fgs.blue,
    ALEVirtualTextError = fgs.coyote_brown1,
    ALEVirtualTextWarning = fgs.coyote_brown1,
    ALEVirtualTextInfo = fgs.coyote_brown1,
    ALEVirtualTextStyleError = fgs.coyote_brown1,
    ALEVirtualTextStyleWarning = fgs.coyote_brown1,
}

-- https://github.com/ghillb/cybu.nvim
hl.plugins.cybu = {
    CybuFocus = {fg = c.green, gui = bold},                               -- Current / Selected Buffer
    CybuAdjacent = {fg = c.red, gui = bold},                              -- Buffers not in focus
    CybuBackground = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)}, -- Window Background
    CybuBorder = {link = "FloatBoarder"},                                 -- Border of the window
    CybuInfobar = {link = "StatusLine"},
}

-- https://github.com/neomake/neomake
hl.plugins.neomake = {
    NeomakeError = {fg = c.none, gui = undercurl, sp = c.red},
    NeomakeErrorSign = fgs.red,
    NeomakeWarning = {fg = c.none, gui = undercurl, sp = c.yellow},
    NeomakeWarningSign = fgs.green,
    NeomakeInfo = {fg = c.none, gui = undercurl, sp = c.blue},
    NeomakeInfoSign = fgs.blue,
    NeomakeMessage = fgs.aqua,
    NeomakeMessageSign = fgs.aqua,
    NeomakeVirtualtextError = fgs.coyote_brown1,
    NeomakeVirtualtextWarning = fgs.coyote_brown1,
    NeomakeVirtualtextInfo = fgs.coyote_brown1,
    NeomakeVirtualtextMessag = fgs.coyote_brown1,
}

-- https://github.com/b0o/incline.nvim
hl.plugins.incline = {
    InclineNormal = {link = "WinBar"},
    InclineNormalNC = {link = "WinBarNC"},
}

-- https://github.com/liuchengxu/vista.vim
hl.plugins.vista = {
    VistaBracket = fgs.coyote_brown1,
    VistaChildrenNr = fgs.orange,
    VistaKind = fgs.purple,
    VistaScope = {fg = c.red, gui = bold},
    VistaScopeKind = fgs.blue,
    VistaTag = {fg = c.magenta, gui = bold},
    VistaPrefix = fgs.coyote_brown1,
    VistaColon = fgs.yellow,
    VistaIcon = fgs.green,
    VistaLineNr = fgs.fg0,
    VistaFloat = {link = "CocFloating"},
    FZFVista = {link = "Type"},
    FZFVistaTag = {link = "Tag"},
    FZFVistaScope = {link = "Function"},
    FZFVistaNumber = {link = "Number"},
    FZFVistaBracket = fgs.blue,
}

-- https://github.com/airblade/vim-gitgutter
hl.plugins.gitgutter = {
    GitGutterAdd = {fg = c.yellow, gui = bold},
    GitGutterChange = {fg = c.blue, gui = bold},
    GitGutterDelete = {fg = c.red, gui = bold},
    GitGutterChangeDelete = {fg = c.purple, gui = bold},
    GitGutterAddLineNr = fgs.green,
    GitGutterChangeLineNr = fgs.blue,
    GitGutterDeleteLineNr = fgs.red,
    GitGutterChangeDeleteLineNr = fgs.purple,
}

-- https://github.com/preservim/nerdtree
hl.plugins.nerdtree = {
    NERDTreeDir = fgs.yellow,
    NERDTreeDirSlash = fgs.aqua,
    NERDTreeOpenable = fgs.orange,
    NERDTreeClosable = fgs.orange,
    NERDTreeFile = fgs.fg0,
    NERDTreeExecFile = fgs.green,
    NERDTreeUp = fgs.coyote_brown1,
    NERDTreeCWD = fgs.aqua,
    NERDTreeToggleOn = fgs.yellow,
    NERDTreeToggleOff = fgs.red,
    NERDTreeFlags = fgs.orange,
    NERDTreeLinkFile = fgs.coyote_brown1,
    NERDTreeLinkTarget = fgs.yellow,
}

-- https://github.com/easymotion/vim-easymotion
hl.plugins.easymotion = {
    EasyMotionTarget = {fg = c.bg0, bg = c.green},
    EasyMotionShade = fgs.coyote_brown1,
}

-- https://github.com/mhinz/vim-startify
hl.plugins.startify = {
    StartifyBracket = fgs.coyote_brown1,
    StartifyFile = fgs.fg0,
    StartifyNumber = fgs.red,
    StartifyPath = fgs.yellow,
    StartifySlash = fgs.yellow,
    StartifySection = fgs.blue,
    StartifyHeader = fgs.orange,
    StartifySpecial = fgs.coyote_brown1,
    StartifyFooter = fgs.coyote_brown1,
}

-- https://github.com/folke/which-key.nvim
hl.plugins.whichkey = {
    WhichKey = {fg = c.begonia},
    WhichKeyDesc = fgs.opera_muave,
    WhichKeyGroup = {fg = c.green, gui = "bold"},
    -- WhichKeyFloat = {fg = c.fg1, bg = c.bg3},
    WhichKeyFloat = {fg = c.fg1, bg = bgs.ocean},
    WhichKeyValue = {fg = c.coyote_brown1, gui = italic}, -- any comment
    WhichKeyBorder = fgs.amethyst,
    WhichKeySeparator = fgs.beaver,
}

-- https://github.com/folke/noice.nvim
hl.plugins.noice = {
    NoiceConfirmBorder = fgs.red,
}

-- https://github.com/Shougo/defx.nvim
hl.plugins.defx = {
    DefxIconsParentDirectory = fgs.orange,
    Defx_filename_directory = fgs.blue,
    Defx_filename_root = fgs.red,
}

-- https://github.com/voldikss/vim-floaterm
hl.plugins.floaterm = {
    Floaterm = {fg = c.none, bg = c.bg0},
    FloatermBorder = {fg = c.magenta, bg = c.none},
}

-- https://github.com/vimwiki/vimwiki
hl.plugins.vimwiki = {
    VimwikiBold = {fg = c.deep_lilac, gui = "bold"},
    VimwikiBoldItalic = {fg = c.jade_green, gui = "bold,italic"},
    VimwikiItalicBold = {link = "VimwikiBoldItalic"},
    VimwikiCode = fgs.puce,
    VimwikiItalic = {fg = c.morning_blue, gui = "italic"},
    VimwikiPre = fgs.purple,
    VimwikiPreDelim = {link = "PreProc"},
    VimwikiTag = fgs.red,
    VimwikiDelText = {fg = c.salmon, gui = "strikethrough"},
    VimwikiListTodo = {fg = c.blue, gui = "bold"},
    VimwikiCheckBoxDone = {fg = c.amethyst, gui = "bold"},
    VimwikiHeader1 = {fg = c.infra_red, gui = "bold"},
    VimwikiHeader2 = {fg = "#F06431", gui = "bold"},
    VimwikiHeader3 = {fg = c.russian_green, gui = "bold"},
    VimwikiHeader4 = {fg = c.green, gui = "bold"},
    VimwikiHeader5 = {fg = c.purple, gui = "bold"},
    VimwikiHeader6 = {fg = "#458588", gui = "bold"},
    VimwikiWeblink1 = {fg = c.aqua, gui = "underline"},
    VimwikiWeblink1Char = {fg = c.orange, gui = underline},
    VimwikiWikiLink1 = {fg = c.orange, gui = "underline"},
    VimwikiNoExistsLink = {fg = c.red, gui = "underline,bold"},
    VimwikiImage = {fg = c.blue, gui = "underline"},
    VimwikiCellSeparator = {link = "Conceal"},
    VimwikiMarkers = {link = "Comment"},
}

-- https://github.com/kevinhwang91/nvim-bqf
hl.plugins.bqf = {
    BqfSign = {fg = c.deep_lilac, gui = bold},
    BqfPreviewBorder = {link = "Parameter"},
    -- BqfPreviewRange = {},
    -- BqfPreviewCursorLine = {},
    -- BqfPreviewBufLabel = {},
}

-- https://github.com/stevearc/aerial.nvim
hl.plugins.aerial = {
    AerialLine = {link = "QuickFixLine"},
    AerialGuide = {link = "LineNr"},
    AerialFileIcon = {link = "Identifier"},
    AerialModuleIcon = {link = "Include"},
    AerialNamespaceIcon = {link = "Include"},
    AerialPackageIcon = {link = "Include"},
    AerialClassIcon = {link = "Type"},
    AerialMethodIcon = {link = "Function"},
    AerialPropertyIcon = {link = "Identifier"},
    AerialFieldIcon = {link = "Identifier"},
    AerialConstructorIcon = {link = "TSConstructor"},
    AerialEnumIcon = {link = "Type"},
    AerialInterfaceIcon = {link = "Type"},
    AerialFunctionIcon = {link = "Function"},
    AerialVariableIcon = fgs.fg1,
    AerialConstantIcon = {link = "Type"},
    AerialStringIcon = {link = "String"},
    AerialNumberIcon = {link = "Number"},
    AerialBooleanIcon = {link = "Boolean"},
    AerialArrayIcon = {link = "Identifier"},
    AerialObjectIcon = {link = "Identifier"},
    AerialKeyIcon = fgs.red,
    AerialNullIcon = {link = "Boolean"},
    AerialEnumMemberIcon = fgs.aqua,
    AerialStructIcon = {link = "Type"},
    AerialEventIcon = fgs.orange,
    AerialOperatorIcon = {link = "Operator"},
    AerialTypeParameterIcon = {link = "Type"},
}

-- https://github.com/sindrets/diffview.nvim
hl.plugins.diffview = {
    DiffviewNormal = {link = "Normal"},
    DiffviewCursorLine = {link = "CursorLine"},
    DiffviewVertSplit = {link = "VertSplit"},
    DiffviewSignColumn = {link = "SignColumn"},
    DiffviewStatusLine = {link = "StatusLine"},
    DiffviewStatusLineNC = {link = "StatusLineNC"},
    DiffviewEndOfBuffer = {link = "EndOfBuffer"},
    DiffviewFilePanelCounter = {fg = c.purple, gui = bold},
    DiffviewFilePanelDeletions = fgs.red,
    DiffviewFilePanelFileName = fgs.russian_green,
    DiffviewFilePanelInsertions = fgs.green,
    DiffviewFilePanelPath = {link = "Title"},
    DiffviewFilePanelRootPath = fgs.coyote_brown1,
    DiffviewFilePanelTitle = {fg = c.blue, gui = bold},
    DiffviewStatusAdded = {link = "Type"},
    DiffviewStatusBroken = {fg = c.red, gui = "bold"},
    DiffviewStatusCopied = fgs.blue,
    DiffviewStatusDeleted = {link = "ErrorMsg"},
    DiffviewStatusModified = {link = "Constant"},
    DiffviewStatusRenamed = {link = "Character"},
    DiffviewStatusTypeChange = {link = "Character"},
    DiffviewStatusUnknown = fgs.bg_red,
    DiffviewStatusUnmerged = fgs.amethyst,
    DiffviewStatusUntracked = {link = "Tag"},
}

-- https://github.com/TimUntersberger/neogit
hl.plugins.neogit = {
    NeogitBranch = {link = "Title"},
    NeogitDiffAdd = {link = "Type"},
    NeogitDiffDelete = {link = "ErrorMsg"},
    -- NeogitDiffAddHighlight = {bg = c.green},
    NeogitDiffContextHighlight = {fg = c.philippine_silver},
    -- NeogitDiffDeleteHighlight = {bg = c.bg_red},
    NeogitHunkHeaderHighlight = fgs.orange,
    NeogitHunkHeader = {fg = c.magenta, gui = bold},
    NeogitNotificationInfo = fgs.blue,
    NeogitNotificationWarning = fgs.yellow,
    NeogitNotificationError = fgs.bg_red,
    NeogitRemote = fgs.amethyst,
    -- NeogitStashes
    NeogitUnstagedChanges = {link = "Tag"},
}

-- https://github.com/lewis6991/gitsigns.nvim
hl.plugins.gitsigns = {
    GitSignsAdd = {link = "Type"},
    GitSignsAddLn = {link = "DiffAdd"},
    GitSignsAddNr = {link = "Type"},
    GitSignsAddInline = {link = "DiffAdd"},
    GitSignsAddLnInline = {link = "Type"},
    GitSignsChange = {link = "Constant"},
    GitSignsChangeLn = {link = "DiffText"},
    GitSignsChangeNr = {link = "Constant"},
    GitSignsChangeInline = {link = "DiffText"},
    GitSignsChangeLnInline = {link = "Constant"},
    GitSignsDelete = {link = "ErrorMsg"},
    GitSignsDeleteLn = {link = "DiffDelete"},
    GitSignsDeleteNr = {link = "ErrorMsg"},
    GitSignsDeleteInline = {link = "DiffDelete"},
    GitSignsDeleteLnInline = {link = "ErrorMsg"},
}

-- https://github.com/ibhagwan/fzf-lua
hl.plugins.fzf_lua = {
    FzfLuaBorder = {link = "FloatBorder"},
    -- FzfLuaNormal = { "Normal" },
    -- FzfLuaBorder = { "Normal" },
    -- FzfLuaCursor = { "Cursor" },
    -- FzfLuaCursorLine = { "CursorLine" },
    -- FzfLuaCursorLineNr = { "CursorLineNr" },
    -- FzfLuaSearch = { "IncSearch" },
    -- FzfLuaTitle = { "FzfLuaNormal" },
    -- FzfLuaScrollBorderEmpty = { "FzfLuaBorder" },
    -- FzfLuaScrollBorderFull  = { "FzfLuaBorder" },
    -- FzfLuaScrollFloatEmpty  = { "PmenuSbar" },
    -- FzfLuaScrollFloatFull   = { "PmenuThumb" },
    -- FzfLuaHelpNormal = { "FzfLuaNormal" },
    -- FzfLuaHelpBorder = { "FzfLuaBorder" },
}

-- https://github.com/kyazdani42/nvim-tree.lua
hl.plugins.nvim_tree = {
    NvimTreeNormal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    -- NOTE: Maybe fix?
    NvimTreeVertSplit = {fg = c.bg2, bg = utils.tern(trans, c.none, c.bg0)},
    NvimTreeEndOfBuffer = {
        fg = utils.tern(cfg.ending_tildes, c.bg3, c.bg0),
        bg = utils.tern(trans, c.none, c.bg0),
    },
    NvimTreeRootFolder = {fg = c.orange, gui = "bold"},
    NvimTreeGitDirty = fgs.yellow,
    NvimTreeGitNew = fgs.green,
    NvimTreeGitDeleted = fgs.red,
    NvimTreeSpecialFile = {fg = c.yellow, gui = "underline"},
    NvimTreeIndentMarker = fgs.fg0,
    NvimTreeImageFile = fgs.puce,
    NvimTreeSymlink = fgs.purple,
    NvimTreeFolderName = fgs.blue,
}

-- https://github.com/nvim-telescope/telescope.nvim
hl.plugins.telescope = {
    TelescopeBorder = fgs.magenta,
    TelescopeMatching = fgs.orange,
    TelescopeMultiIcon = fgs.aqua,
    TelescopeMultiSelection = fgs.blue,
    TelescopePreviewBorder = fgs.magenta,
    TelescopePromptBorder = fgs.magenta,
    TelescopePromptPrefix = fgs.red,
    TelescopeResultsBorder = fgs.magenta,
    TelescopeSelection = {fg = c.yellow, gui = bold},
    TelescopeSelectionCaret = fgs.green,
    TelescopeTitle = {fg = c.purple, gui = bold},
}

-- https://github.com/RRethy/vim-illuminate
hl.plugins.illuminate = {
    illuminatedWord = {link = "LspReferenceText"},
    illuminatedCurWord = {link = "LspReferenceText"},
}

-- https://github.com/mvllow/modes.nvim
hl.plugins.modes = {
    ModesCopy = {bg = c.yellow},
    ModesDelete = {bg = c.red},
    ModesInsert = {bg = c.aqua},
    ModesVisual = {bg = c.magenta},
}

-- https://github.com/glepnir/dashboard-nvim
hl.plugins.dashboard = {
    DashboardShortCut = {fg = c.red, gui = bold},
    DashboardFooter = {fg = c.purple, gui = bold},
    DashboardHeader = {fg = c.blue, gui = bold},
    DashboardCenter = fgs.aqua,
}

-- https://github.com/simrat39/symbols-outline.nvim
hl.plugins.symbols_outline = {
    FocusedSymbol = {fg = c.bg1, bg = c.yellow, gui = bold},
}

-- https://github.com/m-demare/hlargs.nvim
hl.plugins.hlargs = {
    Hlargs = fgs.salmon,
}

-- https://github.com/p00f/nvim-ts-rainbow
-- https://github.com/HiPhish/nvim-ts-rainbow2
hl.plugins.ts_rainbow = {
    rainbowcol1 = fgs.coyote_brown1,
    rainbowcol2 = fgs.yellow,
    rainbowcol3 = fgs.blue,
    rainbowcol4 = fgs.orange,
    rainbowcol5 = fgs.purple,
    rainbowcol6 = fgs.green,
    rainbowcol7 = fgs.red,
    --
    -- Rainbow2
    --
    TSRainbowRed = {fg = c.red, gui = bold},
    TSRainbowYellow = {fg = c.yellow, gui = bold},
    TSRainbowBlue = {fg = c.blue, gui = bold},
    TSRainbowOrange = {fg = c.orange, gui = bold},
    TSRainbowGreen = {fg = c.green, gui = bold},
    TSRainbowViolet = {fg = c.purple, gui = bold},
    TSRainbowCyan = {fg = c.coyote_brown1, gui = bold},
}

-- https://github.com/lukas-reineke/indent-blankline.nvim
hl.plugins.indent_blankline = {
    IndentBlanklineContextChar = {fg = c.bg_red, gui = "nocombine"},
}

-- https://github.com/rcarriga/nvim-dap-ui
hl.plugins.dapui = {
    DapUIScope = fgs.blue,
    DapUIType = fgs.purple,
    DapUIDecoration = fgs.blue,
    DapUIThread = fgs.green,
    DapUIStoppedThread = fgs.red,
    DapUISource = fgs.green,
    DapUILineNumber = fgs.orange,
    DapUIFloatBorder = fgs.purple,
    DapUIWatchesEmpty = fgs.red,
    DapUIWatchesValue = fgs.green,
    DapUIError = fgs.red,
    DapUIBreakpointsCurrentLine = fgs.blue,
    DapUIBreakpointsPath = fgs.blue,
    DapUIBreakpointsInfo = fgs.green,
    DapUIModifiedValue = fgs.yellow,
}

-- https://github.com/wbthomason/packer.nvim
hl.plugins.packer = {
    packerSuccess = fgs.green,
    packerWorking = fgs.yellow,
    packerFail = fgs.red,
    packerStatusSuccess = {fg = c.blue, gui = bold},
    packerStatusFail = {fg = c.red, gui = bold},
    packerString = fgs.yellow,
    packerPackageNotLoaded = {fg = c.grullo_grey},
    packerRelDate = {fg = c.grullo_grey, gui = italic},
    packerPackageName = fgs.green,
    packerOutput = {fg = c.orange, gui = bold},
    packerHash = fgs.magenta,
    packerTimeTrivial = fgs.blue,
    packerTimeHigh = fgs.red,
    packerTimeMedium = fgs.yellow,
    packerTimeLow = fgs.green,
}

-- https://github.com/phaazon/hop.nvim
hl.plugins.hop = {
    HopNextKey = {fg = c.red, gui = bold},
    HopNextKey1 = {fg = c.deep_lilac, gui = bold},
    HopNextKey2 = {fg = utils.darken(c.deep_lilac, 0.7)},
    HopUnmatched = {fg = "#666666", sp = "#666666"},
}

-- https://github.com/mfussenegger/nvim-treehopper
hl.plugins.treehopper = {
    TSNodeUnmatched = {link = "HopUnmatched"},
    TSNodeKey = {link = "HopNextKey"},
}

-- https://github.com/ggandor/lightspeed.nvim
hl.plugins.lightspeed = {
    LightspeedCursor = {link = "Cursor"},
    -- LightspeedGreyWash = {fg = c.dark3},
    -- LightspeedLabel = {fg = c.magenta2, style = "bold,underline"},
    -- LightspeedLabelDistant = {fg = c.green1, style = "bold,underline"},
    -- LightspeedLabelDistantOverlapped = {fg = c.green2, style = "underline"},
    -- LightspeedLabelOverlapped = {fg = c.magenta2, style = "underline"},
    -- LightspeedMaskedChar = {fg = c.orange},
    -- LightspeedOneCharMatch = {bg = c.magenta2, fg = c.fg, style = "bold"},
    -- LightspeedPendingOpArea = {bg = c.magenta2, fg = c.fg},
    -- LightspeedShortcut = {bg = c.magenta2, fg = c.fg, style = "bold,underline"},
    -- LightspeedShortcutOverlapped = { link = "LightspeedShortcut" },
    -- LightspeedUniqueChar = { link = "LightspeedUnlabeledMatch" },
    -- LightspeedUnlabeledMatch = {fg = c.blue2, style = "bold"}
}

-- https://github.com/justinmk/vim-sneak
hl.plugins.sneak = {
    Sneak = {fg = c.deep_lilac, gui = bold},
    SneakScope = {bg = c.bg4},
}

-- https://github.com/rcarriga/nvim-notify
hl.plugins.notify = {
    NotifyBackground = {link = "NormalFloat"},
    NotifyERRORBorder = {fg = c.diff_delete},
    NotifyERRORBody = {fg = c.beaver, bg = bgs.ocean},
    NotifyERRORIcon = fgs.red,
    NotifyERRORTitle = fgs.red,
    NotifyWARNBorder = fgs.coconut,
    NotifyWARNBody = {fg = c.beaver, bg = bgs.ocean},
    NotifyWARNIcon = fgs.yellow,
    NotifyWARNTitle = fgs.yellow,
    NotifyINFOBorder = fgs.slate_grey,
    NotifyINFOBody = {fg = c.beaver, bg = bgs.ocean},
    NotifyINFOIcon = fgs.blue,
    NotifyINFOTitle = fgs.blue,
    NotifyDEBUGBorder = fgs.jasper_orange,
    NotifyDEBUGBody = {fg = c.beaver, bg = bgs.ocean},
    NotifyDEBUGIcon = fgs.orange,
    NotifyDEBUGTitle = fgs.orange,
    NotifyTRACEBorder = fgs.opera_muave,
    NotifyTRACEBody = {fg = c.beaver, bg = bgs.ocean},
    NotifyTRACEIcon = fgs.heliotrope,
    NotifyTRACETitle = fgs.deep_lilac,
    -- NotifyLogTime = fgs.deep_lilac,
    -- NotifyLogTitle = fgs.deep_lilac,
}

-- https://github.com/romgrk/barbar.nvim
hl.plugins.barbar = {
    BufferCurrent = c.fg0,
    -- BufferCurrentIndex = {bg = c.fg_gutter, fg = c.info},
    -- BufferCurrentMod = {bg = c.fg_gutter, fg = c.warning},
    -- BufferCurrentSign = {bg = c.fg_gutter, fg = c.info},
    -- BufferCurrentTarget = {bg = c.fg_gutter, fg = c.red},
    -- BufferVisible = {bg = c.bg_statusline, fg = c.fg},
    -- BufferVisibleIndex = {bg = c.bg_statusline, fg = c.info},
    -- BufferVisibleMod = {bg = c.bg_statusline, fg = c.warning},
    -- BufferVisibleSign = {bg = c.bg_statusline, fg = c.info},
    -- BufferVisibleTarget = {bg = c.bg_statusline, fg = c.red},
    -- BufferInactive = {bg = c.bg_statusline, fg = c.dark5},
    -- BufferInactiveIndex = {bg = c.bg_statusline, fg = c.dark5},
    -- BufferInactiveMod = {bg = c.bg_statusline, fg = utils.darken(c.warning, 0.7)},
    -- BufferInactiveSign = {bg = c.bg_statusline, fg = c.border_highlight},
    -- BufferInactiveTarget = {bg = c.bg_statusline, fg = c.red},
    -- BufferTabpages = {bg = c.bg_statusline, fg = c.none},
    -- BufferTabpage = {bg = c.bg_statusline, fg = c.border_highlight}
}

-- https://github.com/lambdalisue/fern.vim
hl.plugins.fern = {
    FernBranchText = {fg = c.blue},
}

-- https://github.com/chentau/marks.nvim
hl.plugins.marks = {
    MarkSignHL = {link = "Identifier"},
    MarkSignNumHL = {fg = c.peach_red, gui = bold},
    MarkVirtTextHL = fgs.jasper_orange,
}

-- https://github.com/glepnir/nerdicons.nvim
hl.plugins.nerdicons = {
    NerdIconBorder = {link = "FloatBorder"},
    NerdIconNormal = fgs.beaver,
    NerdIconPreviewPrompt = {link = "Identifier"},
    NerdIconPrompt = fgs.orange,
}

-- https://github.com/inkarkat/vim-SpellCheck
hl.plugins.spellcheck = {
    qfSpellContext = fgs.yellow,
    qfSpellErrorWordInContext = fgs.blue,
    qfSpellErrorWord = {link = "SpellBad"},
}

function M.setup()
    if utils.needs_api_fix() then
        utils.highlight.alt({Normal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)}})
    else
        utils.highlight({Normal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)}})
    end

    utils.highlight(hl.common)
    utils.highlight(hl.syntax)
    utils.highlight(hl.treesitter)

    for _, group in pairs(hl.langs) do
        if not vim.tbl_contains(cfg.disabled.langs, group) then
            utils.highlight(group)
        end
    end

    for _, group in pairs(hl.plugins) do
        if not vim.tbl_contains(cfg.disabled.plugins, group) then
            utils.highlight(group)
        end
    end

    if cfg.langs08 then
        if utils.has08() then
            for _, group in pairs(hl.langs08) do
                if not vim.tbl_contains(cfg.disabled.langs08, group) then
                    utils.highlight(group)
                end
            end
        else
            log.err("You need Neovim 0.8 to use this feature")
        end
    end

    vim.defer_fn(function()
        local msg = utils.messages(1, true)
        if msg and msg:match("^W18: Invalid character in group name") then
            log.err(
                "You need to disable `langs08` or\nyou must have commit 030b422d1.\nCheck `:h lua-treesitter-highlight-groups`",
                true,
                {once = true}
            )
        end
    end, 1000)

    if cfg.highlights then
        -- user defined highlights
        local function replace_color(color_name)
            if not color_name then
                return ""
            end
            if color_name:sub(1, 1) == "$" then
                local name = color_name:sub(2, -1)
                color_name = c[name]
                if not color_name then
                    vim.schedule(function()
                        log.err(("unknown color: '%s'"):format(name))
                    end)
                    return ""
                end
            end
            return color_name
        end

        local to_hl = {}
        for group, opts in pairs(cfg.highlights) do
            opts.fg = replace_color(opts.fg)
            opts.bg = replace_color(opts.bg)
            opts.sp = replace_color(opts.sp)
            opts.gui = replace_color(opts.gui)

            to_hl[group] = opts
        end

        utils.highlight(to_hl)
    end

    ---@class KimboxHighlightLangs
    M.langs = vim.tbl_keys(hl.langs)
    ---@class KimboxHighlightLangs08
    M.langs08 = vim.tbl_keys(hl.langs08)
    ---@class KimboxHighlightPlugins
    M.plugins = vim.tbl_keys(hl.plugins)
end

return M
