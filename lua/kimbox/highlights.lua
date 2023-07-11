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
local Config = require("kimbox.config")

if Config.__did_hl then
    return
end

local cfg = Config.user

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

---@class Kimbox.FG.Short
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
    paisley_purple = {fg = c.paisley_purple},
    deep_lilac = {fg = c.deep_lilac},
    heliotrope = {fg = c.heliotrope},
    jasper_orange = {fg = c.jasper_orange},
    glorious_sunset = {fg = c.glorious_sunset},
    red = {fg = c.red},
    teaberry = {fg = c.teaberry},
    fuzzy_wuzzy = {fg = c.fuzzy_wuzzy},
    wave_red = {fg = c.wave_red},
    peach_red = {fg = c.peach_red},
    infra_red = {fg = c.infra_red},
    tuscan_red = {fg = c.tuscan_red},
    drama_violet = {fg = c.drama_violet},
    oni_violet = {fg = c.oni_violet},
    cranberry_sauce = {fg = c.cranberry_sauce},
    beaver = {fg = c.beaver},
    russet = {fg = c.russet},
    coconut = {fg = c.coconut},
}

hl.common = {
    Normal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},   -- normal text
    NormalNC = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)}, -- normal text in non-current windows
    Terminal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    ToolbarLine = {fg = utils.tern(trans, c.fg0, c.fg1), bg = utils.tern(trans, c.none, c.bg3)},
    VertSplit = {fg = c.fg1, bg = c.none},
    WinSeparator = {link = "VertSplit"}, -- separators between window splits
    EndOfBuffer = {                      -- filler lines (~) after the end of the buffer
        fg = utils.tern(cfg.ending_tildes, c.bg2, c.bg0),
        bg = utils.tern(trans, c.none, c.bg0),
    },
    IncSearch = {fg = c.bg1, bg = c.fuzzy_wuzzy},                     -- 'incsearch' hl; also used for replacement :s//
    CurSearch = {link = "IncSearch"},                                 -- search pattern under the cursor
    Search = {fg = c.bg0, bg = c.vista_blue},                         -- last search pattern highlighting
    Folded = {fg = c.coyote_brown1, bg = c.bg2},                      -- line used for closed folds
    ColorColumn = {bg = c.bg1},                                       -- used for the columns set with 'colorcolumn'
    FoldColumn = {fg = c.coyote_brown},
    SignColumn = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)}, -- column where signs are displayed
    Conceal = {fg = c.coyote_brown1, bg = c.none},                    -- placeholder chars subst for concealed text
    Cursor = {fg = bgs.cannon, bg = c.deep_saffron},                  -- character under the cursor
    vCursor = {fg = bgs.cannon, bg = c.deep_saffron},
    iCursor = {fg = bgs.cannon, bg = c.deep_saffron},
    lCursor = {fg = bgs.cannon, bg = c.deep_saffron},  -- char under the cursor when language-mapping
    CursorIM = {fg = bgs.cannon, bg = c.deep_saffron}, -- like Cursor, but used when in IME mode `CursorIM`
    TermCursor = {link = "Cursor"},                    -- cursor in a focused terminal
    TermCursorNC = {link = "Folded"},                  -- cursor in an unfocused terminal
    CursorColumn = {bg = c.bg1},                       -- screen-column at the cursor, when 'cursorcolumn' is set
    CursorLine = {fg = c.none, bg = c.bg1},            -- screen-line at the cursor, when 'cursorline' is set
    CursorLineNr = {fg = c.purple, gui = bold},        -- number on cursorline
    CursorLineFold = {fg = c.purple, gui = bold},      -- FoldColumn for cursorline
    CursorLineSign = {fg = c.purple, gui = bold},      -- SignColumn for cursorline
    LineNr = {fg = c.coyote_brown},                    -- line num for ":number" and ":#" commands, 'nu'/'rnu'
    LineNrAbove = {fg = c.coyote_brown},               -- SignColumn numbers above curent line
    LineNrBelow = {fg = c.coyote_brown},               -- SignColumn numbers below curent line
    diffAdded = {fg = c.green, gui = bold},
    diffRemoved = {fg = c.red, gui = bold},
    diffChanged = fgs.blue,
    diffOldFile = fgs.yellow,
    diffNewFile = fgs.orange,
    diffFile = fgs.aqua,
    diffLine = fgs.coyote_brown1,
    diffIndexLine = fgs.purple,
    DiffAdd = {fg = c.none, bg = c.diff_add},        -- diff mode: Added line
    DiffChange = {fg = c.none, bg = c.diff_change},  -- diff mode: Changed line
    DiffDelete = {fg = c.none, bg = c.diff_delete},  -- diff mode: Deleted line
    DiffText = {fg = c.none, bg = c.diff_text},      -- diff mode: Changed text within a changed line
    DiffFile = {fg = c.aqua, gui = bold},
    Directory = {fg = c.salmon, gui = bold},         -- directory names (and other special names in listings)
    ErrorMsg = {fg = c.red, gui = underbold},        -- error messages on the command line
    WarningMsg = {fg = c.green, gui = bold},         -- warning messages
    ModeMsg = {fg = c.purple, gui = bold},           -- 'showmode' message (e.g., "-- INSERT --")
    MoreMsg = {fg = c.green, gui = bold},            -- more-prompt
    -- MsgArea = {},                                    -- area for messages and cmdline
    MsgSeparator = {fg = c.fuzzy_wuzzy, gui = bold}, -- separator for scrolled messages
    Question = {fg = c.green},                       -- hit-enter prompt and yes/no questions
    MatchParen = {fg = c.none, bg = c.bg4},          -- char under cursor or just before it if paired
    Substitute = {fg = c.bg0, bg = c.green},         -- :substitute replacement text
    NonText = {fg = c.bg4},                          -- '@' at the end of the window, fillchars, showbreak
    SpecialKey = {fg = c.bg4},                       -- unprintable characters
    Whitespace = {fg = c.bg4},                       -- "nbsp", "space", "tab", "multispace", "lead", "trail"
    Pmenu = {                                        -- popup menu: normal item
        fg = c.fg4,
        bg = utils.tern(cfg.popup.background, c.bg0, c.bg1),
    },
    PmenuKind = {fg = c.magenta, gui = bold},                -- popup menu: normal item "kind"
    PmenuKindSel = {fg = c.orange, bg = c.bg4, gui = bold},  -- popup menu: selected item "kind"
    PmenuExtra = {fg = c.yellow, gui = bold},                -- popup menu: normal item "extra text"
    PmenuExtraSel = {fg = c.yellow, bg = c.bg4, gui = bold}, -- popup menu: selected item "extra text"
    PmenuSel = {fg = c.red, bg = c.bg4, gui = bold},         -- popup menu: selected item
    PmenuSbar = {fg = c.none, bg = c.fg3},                   -- popup menu: scrollbar
    PmenuThumb = {fg = c.none, bg = c.green},                -- popup menu: thumb of the scrollbar
    WildMenu = {fg = c.bg3, bg = c.green},                   -- current match in 'wildmenu' completion
    WinBar = {fg = c.fg0, gui = bold},                       -- window bar of current window
    WinBarNC = {fg = c.bg4, gui = bold},                     -- window bar of not-current windows
    NormalFloat = {fg = c.fg1, bg = bgs.cannon},             -- normal text in floating windows
    TabLine = {fg = c.fg0, bg = c.bg1},                      -- tabpages line, not active tabpage label
    TabLineSel = {fg = c.purple, bg = c.bg1, gui = bold},    -- tabpages line, active tabpage label
    TabLineFill = {gui = "none"},                            -- tabpages line, where there are no labels
    -- When last status=2 or 3
    StatusLine = {fg = c.none, bg = c.none},                 -- status line of current window
    StatusLineNC = {fg = c.coyote_brown1, bg = c.bg0},       -- status lines of not-current windows
    StatusLineTerm = {fg = c.fg0, bg = c.bg0},
    StatusLineTermNC = {fg = c.beaver, bg = c.bg0},
    SpellBad = {fg = c.red, gui = "undercurl", sp = c.red},      -- word not recognized by spellchecker
    SpellCap = {fg = c.blue, gui = undercurl, sp = c.blue},      -- word that should start with capital letter
    SpellLocal = {fg = c.aqua, gui = undercurl, sp = c.aqua},    -- word recognized from another region
    SpellRare = {fg = c.purple, gui = undercurl, sp = c.purple}, -- word recognized as one that is rarely used
    Visual = {fg = c.black, bg = c.fg4, gui = reverse},          -- visual mode selection
    VisualNOS = {fg = c.black, bg = c.fg4, gui = reverse},       -- visual sel when vim is "Not Owning the Selection"
    QuickFixLine = {fg = c.purple, gui = bold},                  -- current quickfix item in the quickfix window
    Debug = {fg = c.orange},
    debugPC = {fg = c.bg0, bg = c.green},
    debugBreakpoint = {fg = c.bg0, bg = c.red},
    ToolbarButton = {fg = c.bg0, bg = c.grullo_grey},
    FloatBorder = {fg = c.magenta},           -- border of floating windows
    FloatTitle = {fg = c.orange, gui = bold}, -- title of floating windows
    FloatermBorder = {fg = c.magenta},
    -- === GUI ===
    -- Menu = {--[[ font = "",]] link = "Pmenu"},    -- current font, bg & fg colors of the menus
    -- Scrollbar = {fg = c.none, bg = c.fg3},        -- bg & fg of the main window's scrollbars
    -- Tooltip = {--[[ font = "",]] link = "Pmenu"}, -- current font, bg & fg colors of the menus
}

hl.syntax = {
    Boolean = fgs.orange,
    Number = fgs.purple,
    Float = fgs.purple,
    PreProc = {fg = c.sea_green, gui = italic},
    PreCondit = fgs.sea_green,
    Include = {fg = c.red, gui = italic},
    Define = fgs.purple,
    Conditional = {fg = c.purple, gui = italic},
    Repeat = {fg = c.purple, gui = italic},
    Keyword = {fg = c.red, gui = italic},
    Typedef = {fg = c.peach_red, gui = bold},
    Exception = {fg = c.orange, gui = bold},
    Statement = {fg = c.red, gui = bold},
    Error = fgs.red,
    StorageClass = fgs.red,
    Tag = fgs.orange,
    Label = fgs.orange,
    Structure = fgs.red,
    Operator = fgs.orange,
    Special = fgs.green,
    SpecialChar = fgs.philippine_green,
    Type = {fg = c.green, gui = bold},
    Function = {fg = c.magenta, gui = bold},
    String = fgs.yellow,
    Character = fgs.yellow,
    Constant = fgs.aqua,
    Macro = fgs.aqua,
    Identifier = fgs.blue,
    Delimiter = fgs.purple,
    Ignore = fgs.coyote_brown1,
    Comment = fgs.coyote_brown1,
    SpecialComment = {fg = c.coyote_brown1, gui = italic},
    Todo = {fg = c.purple, bg = c.none, gui = bold},
    Underlined = {fg = c.none, gui = "underline"},
    Title = {fg = c.orange, gui = bold},           -- titles for output from ":set all", ":autocmd" etc
    Title1 = {fg = c.infra_red, gui = "bold"},     -- CUSTOM: markdown heading 1
    Title2 = {fg = "#F06431", gui = "bold"},       -- CUSTOM: markdown heading 2
    Title3 = {fg = c.russian_green, gui = "bold"}, -- CUSTOM: markdown heading 3
    Title4 = {fg = c.green, gui = "bold"},         -- CUSTOM: markdown heading 4
    Title5 = {fg = c.purple, gui = "bold"},        -- CUSTOM: markdown heading 5
    Title6 = {fg = "#458588", gui = "bold"},       -- CUSTOM: markdown heading 6
    Code = fgs.puce,
    -- === Custom ===
    Bold = {fg = c.deep_lilac, gui = "bold"},
    BoldItalic = {fg = c.jade_green, gui = "bold,italic"},
    Italic = {fg = c.morning_blue, gui = "italic"},
    Strikethrough = {fg = c.beaver, gui = "strikethrough"},
}

hl.treesitter = {
    -- === Miscellaneous ===
    TSComment = {link = "Comment"},             -- Line comments and block comments
    -- TSCommentDocumentation = fgs.jasper_orange, -- comments documenting code
    -- TSError = {link = "Error"},              -- syntax/parser errors (NOTE: maybe change)
    TSNone = fgs.fg0,                           -- completely disable the highlight
    TSPreproc = {link = "PreProc"},             -- various preprocessor directives & shebangs
    TSDefine = {link = "TSPreproc"},            -- preprocessor definition directives
    TSOperator = {link = "Operator"},           -- symbolic operators (e.g. `+` / `*`)

    -- === Punctuation ===
    TSPunctBracket = {link = "Delimiter"}, -- brackets (e.g. `()` / `{}` / `[]`)
    TSPunctDelimiter = fgs.coyote_brown1,  -- delimiters (e.g. `;` / `.` / `,`)
    TSPunctSpecial = {link = "Special"},   -- special symbols (e.g. `{}` in string interpolation)

    -- === Literal ===
    TSString = {link = "String"},                -- string literals
    TSStringDocumentation = {link = "String"},   -- string documenting code (e.g. Python docstrings)
    TSStringRegex = fgs.orange,                  -- regular expressions
    TSStringEscape = {link = "SpecialChar"},     -- escape sequences
    TSStringSpecial = fgs.glorious_sunset,       -- other special strings (e.g. dates)
    TSCharacter = {link = "Character"},          -- character literals
    TSCharacterSpecial = {link = "SpecialChar"}, -- special characters (e.g. wildcards)
    TSBoolean = {link = "Boolean"},              -- boolean literals
    TSNumber = {link = "Number"},                -- numeric literals
    TSFloat = {link = "Float"},                  -- floating-point number literals

    -- === Functions ===
    TSFunction = {link = "Function"},              -- function definitions
    TSFuncCall = {link = "Function"},              -- function calls
    TSFuncBuiltin = {link = "Function"},           -- built-in functions
    TSFuncMacro = {link = "Macro"},                -- preprocessor macros
    TSMethod = fgs.blue,                           -- method definitions
    TSMethodCall = fgs.blue,                       -- method calls
    TSConstructor = {fg = c.wave_red, gui = bold}, -- constructor calls and definitions
    TSParameter = fgs.salmon,                      -- parameters of a function
    TSParameterReference = fgs.salmon,             -- parameter references within a function

    -- === Keywords ===
    TSKeyword = {link = "Keyword"},             -- various keywords
    -- TSKeywordCoroutine = {fg = c.oni_violet, gui = bold}, -- keywords related to coroutines (`async`/`await`)
    TSKeywordFunction = fgs.red,                -- keywords that define a function (`def`/`fn`/`func`)
    TSKeywordOperator = {link = "Keyword"},     -- operators that are English words (`and`/`or`)
    TSKeywordReturn = {link = "Statement"},     -- keywords like `return`/`yield`
    TSConditional = {link = "Conditional"},     -- keywords related to conditionals (`if`/`then`/`elif`...)
    TSConditionalTernary = {link = "Function"}, -- ternary operator (`?`/`:`)
    TSRepeat = {link = "Repeat"},               -- keywords related to loops (`for`/`while`/`break`)
    TSLabel = {link = "Label"},                 -- goto and other labels
    TSInclude = {link = "Include"},             -- keywords for including modules
    TSException = {link = "Exception"},         -- keywords related to exceptions (`throw`/`catch`)

    -- === Types ===
    TSType = fgs.green,                                 -- type or class definitions and annotations
    TSTypeBuiltin = {link = "Type"},                    -- built-in types
    TSTypeDefinition = {link = "Typedef"},              -- type definitions (`typedef`)
    TSTypeQualifier = fgs.red,                          -- type qualifiers (`const`/`static`)
    TSStorageClass = {link = "StorageClass"},           -- modifiers that affect storage in memory or life-time
    TSAttribute = {fg = c.glorious_sunset, gui = bold}, -- attribute annotations (decorators, [[noreturn]], etc)
    TSField = fgs.aqua,                                 -- object and struct fields
    TSProperty = fgs.aqua,                              -- similar to `@field`

    -- === Identifiers ===
    TSVariable = fgs.fg0,                           -- various variable names
    TSVariableBuiltin = fgs.blue,                   -- built-in variable names (`this`/`self`/`super`)
    TSVariableGlobal = fgs.blue,                    -- CUSTOM (I think)
    TSConstant = {fg = c.sea_green, gui = bold},    -- constant identifiers
    TSConstBuiltin = {fg = c.orange, gui = italic}, -- built-in constant values
    TSConstMacro = {fg = c.orange, gui = italic},   -- constants defined by the preprocessor
    TSNamespace = {fg = c.orange, gui = italic},    -- modules or namespaces
    TSNamespaceBuiltin = fgs.russian_green,
    TSSymbol = fgs.fg0,                             -- symbols or atoms

    -- === Tags ===
    TSTag = {fg = c.magenta, gui = bold},        -- XML tag names
    TSTagAttribute = {fg = c.green, gui = bold}, -- XML tag attributes
    TSTagDelimiter = {link = "Delimiter"},       -- XML tag delimiters

    -- === Text ===
    TSAnnotation = {fg = c.blue, gui = italic},
    TSTextAttribute = {fg = c.green, gui = bold},

    TSText = fgs.yellow,                          -- non-structured text
    TSTextQuote = {link = "String"},              -- text quotations (NOTE: unsure if correct)
    TSURI = {fg = c.amethyst, gui = "underline"}, -- URIs (e.g. hyperlinks)
    TSMath = fgs.green,                           -- math environments
    TSEnviroment = fgs.fg0,                       -- text environments of markup languages
    TSEnviromentName = fgs.green,                 -- text indicating the type of an environment
    TSTextReference = fgs.blue,                   -- text references, footnotes, citations, etc.
    TSLiteral = {link = "TSCode"},                -- literal or verbatim text (e.g., inline code)
    TSLiteralBlock = fgs.purple,                  -- literal or verbatim text as a stand-alone block
    TSDiffAdd = {fg = c.none, bg = c.diff_add},
    TSDiffChange = {fg = c.none, bg = c.diff_change},
    TSDiffDelete = {fg = c.none, bg = c.diff_delete},

    TSStrong = {link = "Bold"},          -- bold text
    TSEmphasis = {link = "Italic"},      -- text with emphasis
    TSUnderline = {link = "Underlined"}, -- underlined text
    TSStrike = {link = "Strikethrough"}, -- strikethrough text
    TSTitle = {link = "Title"},          -- text that is part of a title

    TSTodo = {link = "Todo"},
    TSNote = {fg = c.blue, gui = bold},
    TSWarning = {fg = c.yellow, gui = bold},
    TSDanger = {fg = c.infra_red, gui = bold},

    -- === Custom ===
    TSBold = {link = "Bold"},
    TSItalic = {link = "Italic"},
    TSCode = {link = "Code"},

    TSError = {fg = c.red, gui = bold},
    TSWarn = {link = "TSWarning"},
    TSnfo = {fg = c.blue, gui = bold},
    TSHint = {fg = c.amethyst, gui = bold},
    TSDebug = {fg = c.orange, gui = bold},
    TSTrace = {fg = c.deep_lilac, gui = bold},
}

hl.langs08.treesitter = {
    -- === Miscellaneous ===
    ["@comment"] = {link = "Comment"},              -- line and block comments
    -- ["@comment.documentation"] = fgs.jasper_orange, -- comments documenting code
    -- ["@error"] = {link = "Error"},                  -- syntax/parser errors (NOTE: maybe change)
    ["@none"] = fgs.fg0,                            -- completely disable the highlight
    ["@preproc"] = {link = "PreProc"},              -- various preprocessor directives & shebangs
    ["@define"] = {link = "@preproc"},              -- preprocessor definition directives
    ["@operator"] = {link = "Operator"},            -- symbolic operators (e.g. `+` / `*`)

    -- === Punctuation ===
    ["@punctuation.bracket"] = {link = "Delimiter"}, -- brackets (e.g. `()` / `{}` / `[]`)
    ["@punctuation.delimiter"] = fgs.coyote_brown1,  -- delimiters (e.g. `;` / `.` / `,`)
    ["@punctuation.special"] = {link = "Special"},   -- special symbols (e.g. `{}` in string interpolation)

    -- === Literal ===
    ["@string"] = {link = "String"},                 -- string literals
    ["@string.documentation"] = {link = "String"},   -- string documenting code (e.g. Python docstrings)
    ["@string.regex"] = fgs.orange,                  -- regular expressions
    ["@string.escape"] = {link = "SpecialChar"},     -- escape sequences
    ["@string.special"] = fgs.glorious_sunset,       -- other special strings (e.g. dates)
    ["@character"] = {link = "Character"},           -- character literals
    ["@character.special"] = {link = "SpecialChar"}, -- special characters (e.g. wildcards)
    ["@boolean"] = {link = "Boolean"},               -- boolean literals
    ["@number"] = {link = "Number"},                 -- numeric literals
    ["@float"] = {link = "Float"},                   -- floating-point number literals

    -- === Functions ===
    ["@function"] = {link = "Function"},              -- function definitions
    ["@function.call"] = {link = "Function"},         -- function calls
    ["@function.builtin"] = {link = "Function"},      -- built-in functions
    ["@function.macro"] = {link = "Macro"},           -- preprocessor macros
    ["@method"] = fgs.blue,                           -- method definitions
    ["@method.call"] = fgs.blue,                      -- method calls
    ["@constructor"] = {fg = c.wave_red, gui = bold}, -- constructor calls and definitions
    ["@parameter"] = fgs.salmon,                      -- parameters of a function
    ["@parameter.reference"] = fgs.salmon,            -- parameter references within a function

    -- === Keywords ===
    ["@keyword"] = {link = "Keyword"},              -- various keywords
    -- ["@keyword.coroutine"] = {fg = c.oni_violet, gui = bold}, -- keywords related to coroutines (`async`/`await`)
    ["@keyword.function"] = fgs.red,                -- keywords that define a function (`def`/`fn`/`func`)
    ["@keyword.operator"] = {link = "Keyword"},     -- operators that are English words (`and`/`or`)
    ["@keyword.return"] = {link = "Statement"},     -- keywords like `return`/`yield`
    ["@conditional"] = {link = "Conditional"},      -- keywords related to conditionals (`if`/`then`/`elif`...)
    ["@conditional.ternary"] = {link = "Function"}, -- ternary operator (`?`/`:`)
    ["@repeat"] = {link = "Repeat"},                -- keywords related to loops (`for`/`while`/`break`)
    ["@debug"] = fgs.slate_grey,                    -- keywords related to debugging (NOTE: maybe change)
    ["@label"] = {link = "Label"},                  -- goto and other labels
    ["@include"] = {link = "Include"},              -- keywords for including modules
    ["@exception"] = {link = "Exception"},          -- keywords related to exceptions (`throw`/`catch`)

    -- === Types ===
    ["@type"] = fgs.green,                                 -- type or class definitions and annotations
    ["@type.builtin"] = {fg = c.green, gui = bold},        -- built-in types
    ["@type.definition"] = {link = "Typedef"},             -- type definitions (`typedef`)
    ["@type.qualifier"] = fgs.red,                         -- type qualifiers (`const`/`static`)
    ["@storageclass"] = {link = "StorageClass"},           -- modifiers that affect storage in memory or life-time
    ["@attribute"] = {fg = c.glorious_sunset, gui = bold}, -- attribute annotations (decorators, [[noreturn]], etc)
    ["@field"] = fgs.aqua,                                 -- object and struct fields
    ["@property"] = fgs.aqua,                              -- similar to `@field`

    -- === Identifiers ===
    ["@variable"] = fgs.fg0,                               -- various variable names
    ["@variable.builtin"] = fgs.blue,                      -- built-in variable names (`this`/`self`/`super`)
    ["@variable.global"] = fgs.blue,                       -- CUSTOM
    ["@constant"] = {fg = c.sea_green, gui = bold},        -- constant identifiers
    ["@constant.builtin"] = {fg = c.orange, gui = italic}, -- built-in constant values
    ["@constant.macro"] = {fg = c.orange, gui = italic},   -- constants defined by the preprocessor
    ["@namespace"] = {fg = c.orange, gui = italic},        -- modules or namespaces
    ["@namespace.builtin"] = fgs.russian_green,
    ["@symbol"] = fgs.fg0,                                 -- symbols or atoms

    -- === Tags ===
    ["@tag"] = {fg = c.magenta, gui = bold},         -- XML tag names
    ["@tag.attribute"] = {fg = c.green, gui = bold}, -- XML tag attributes
    ["@tag.delimiter"] = {link = "Delimiter"},       -- XML tag delimiters

    -- === Text ===
    ["@text.annotation"] = {fg = c.blue, gui = italic},
    ["@text.attribute"] = {fg = c.green, gui = bold},

    ["@text"] = fgs.yellow,                               -- non-structured text
    ["@text.quote"] = fgs.yellow,                         -- text quotations
    ["@text.uri"] = {fg = c.amethyst, gui = "underline"}, -- URIs (e.g. hyperlinks)
    ["@text.math"] = fgs.green,                           -- math environments
    ["@text.environment"] = fgs.fg0,                      -- text environments of markup languages
    ["@text.environment.name"] = fgs.green,               -- text indicating the type of an environment
    ["@text.reference"] = fgs.blue,                       -- text references, footnotes, citations, etc.
    ["@text.literal"] = {link = "TSCode"},                -- literal or verbatim text (e.g., inline code)
    ["@text.literal.block"] = fgs.purple,                 -- literal or verbatim text as a stand-alone block
    ["@text.diff.add"] = {fg = c.none, bg = c.diff_add},
    ["@text.diff.change"] = {fg = c.none, bg = c.diff_change},
    ["@text.diff.delete"] = {fg = c.none, bg = c.diff_delete},

    ["@text.strong"] = {link = "Bold"},          -- bold text
    ["@text.emphasis"] = {link = "Italic"},      -- text with emphasis
    ["@text.underline"] = {link = "Underlined"}, -- underlined text
    ["@text.strike"] = {link = "Strikethrough"}, -- strikethrough text
    ["@text.title"] = {link = "Title"},          -- text that is part of a title
    ["@text.title.1"] = {link = "Title1"},
    ["@text.title.2"] = {link = "Title2"},
    ["@text.title.3"] = {link = "Title3"},
    ["@text.title.4"] = {link = "Title4"},
    ["@text.title.5"] = {link = "Title5"},
    ["@text.title.6"] = {link = "Title6"},

    ["@text.todo"] = {link = "Todo"},
    ["@text.note"] = {fg = c.blue, gui = bold},
    ["@text.warning"] = {fg = c.yellow, gui = bold},
    ["@text.danger"] = {fg = c.infra_red, gui = bold},

    -- === Custom ===
    ["@bold"] = {link = "Bold"},
    ["@italic"] = {link = "Italic"},
    ["@underline"] = {link = "Underlined"},
    ["@strike"] = {link = "Strikethrough"},
    ["@code"] = {link = "Code"},

    ["@text.error"] = {fg = c.red, gui = bold},
    ["@text.warn"] = {link = "@text.warning"},
    ["@text.info"] = {fg = c.blue, gui = bold},
    ["@text.hint"] = {fg = c.amethyst, gui = bold},
    ["@text.debug"] = {fg = c.orange, gui = bold},
    ["@text.trace"] = {fg = c.deep_lilac, gui = bold},

    -- ["@conceal"] = {},                               -- for captures that are only used for concealing
    -- ["@spell"] = {},                                 -- for defining regions to be spellchecked
    -- ["@nospell"] = {},                               -- for defining regions to be spellchecked
}

--  ╭──────────╮
--  │ Solidity │
--  ╰──────────╯
hl.langs.solidity = {
    -- vim-solidity: https://github.com/thesis/vim-solidity
    solConstructor = {fg = c.blue, gui = bold},
    SolContract = fgs.orange,
    solContractName = {fg = c.aqua, gui = bold},
    solOperator = {link = "Operator"},
    solMethodParens = {link = "Delimiter"},
    solFunction = {link = "Keyword"},
    solFuncName = {link = "Function"},
    solFuncReturn = {link = "TSKeywordReturn"},
    solFuncModifier = {link = "StorageClass"},
    solModifier = {link = "StorageClass"},
    solMethod = {link = "Function"},
    solModifierInsert = {fg = c.magenta, gui = bold},
    solConstant = {link = "TSConstant"},
    -- === Treesitter ===
    solidityTSFunction = {link = "TSFunction"},
    solidityTSKeyword = fgs.orange,
    solidityTSType = {link = "TSTypeBuiltin"},
    solidityTSTag = {fg = c.blue, gui = bold},
    solidityTSMethod = {link = "TSFunction"},
    solidityTSMethodCall = {link = "TSFunction"},
    solidityTSField = {link = "TSField"},
}

hl.langs08.solidity = {
    ["@function.solidity"] = {link = "@function"},
    ["@keyword.solidity"] = fgs.orange,
    ["@type.solidity"] = {link = "@type.builtin"},
    ["@tag.solidity"] = {fg = c.blue, gui = bold},
    ["@method.solidity"] = {link = "@function"},
    ["@method.call.solidity"] = {link = "@function"},
    ["@field.solidity"] = {link = "@field"},
}

--  ╭──────╮
--  │ Help │
--  ╰──────╯
hl.langs.vimdoc = {
    helpSpecial = {link = "Special"},
    helpNote = {fg = c.purple, gui = bold},
    helpHeader = {fg = c.sea_green, gui = bold},
    helpVim = {fg = c.blue, gui = bold}, -- Main header/title
    helpHyperTextEntry = {fg = c.yellow, gui = bold},
    -- === Treesitter ===
    vimdocTSTitle = {fg = c.red, gui = bold},
    vimdocTSLiteral = fgs.purple,
    vimdocTSTextReference = {link = "TSTypeBuiltin"},
    vimdocTSLabel = fgs.blue,
    vimdocTSString = {link = "TSString"},
    vimdocTSURI = {link = "TSURI"},
    vimdocTSParameter = {link = "TSParameter"},
    -- old
    helpTSTitle = fgs.red,
    helpTSLabel = fgs.blue,
    helpTSString = {link = "TSString"},
    helpTSURI = {link = "TSURI"},
}

hl.langs08.vimdoc = {
    ["@text.title.vimdoc"] = {fg = c.red, gui = bold},
    ["@text.literal.vimdoc"] = fgs.purple,
    ["@text.reference.vimdoc"] = {link = "@type.builtin"},
    ["@label.vimdoc"] = fgs.blue,
    ["@string.vimdoc"] = {link = "@string"},
    ["@text.uri.vimdoc"] = {link = "@text.uri"},
    ["@parameter.vimdoc"] = {link = "@paramter"},
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
    markdownH1 = {link = "Title1"}, -- affects code hover documentation
    markdownH2 = {link = "Title2"},
    markdownH3 = {link = "Title3"},
    markdownH4 = {link = "Title4"},
    markdownH5 = {link = "Title5"},
    markdownH6 = {link = "Title6"},
    markdownUrl = {link = "TSURI"},
    markdownUrlDelimiter = fgs.coyote_brown1,
    markdownUrlTitleDelimiter = fgs.yellow,
    markdownItalic = {link = "Italic"},
    markdownItalicDelimiter = {fg = c.coyote_brown1, gui = "italic"},
    markdownBold = {link = "Bold"},
    markdownBoldDelimiter = fgs.coyote_brown1,
    markdownCode = fgs.yellow, -- affects code hover documentation
    markdownCodeBlock = fgs.purple,
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
    -- === Treesitter ===
    markdownTSNone = fgs.purple,                     -- Fenced code block
    markdownTSPunctDelimiter = {link = "TSPreproc"}, -- Fenced code block delim
    markdownTSLiteral = {link = "TSCode"},
    markdownTSEmphasis = {fg = c.morning_blue, gui = "italic"},
    markdownTSURI = {link = "TSURI"},
    markdownTSStrong = {link = "Bold"},
    markdownTSTextReference = {fg = c.blue, gui = underline},
    markdownTSTextQuote = {link = "TSString"},
    markdownTSPunctSpecial = {fg = c.red, gui = bold},

    markdownTSTodoChecked = {fg = c.amethyst, gui = "bold"},
    markdownTSTodoUnchecked = {fg = c.blue, gui = "bold"},
}

hl.langs08.markdown = {
    ["@none.markdown"] = fgs.purple,                           -- Fenced code block
    ["@punctuation.delimiter.markdown"] = {link = "@preproc"}, -- Fenced code block delim
    ["@text.literal.markdown"] = {link = "@code"},
    ["@text.emphasis.markdown"] = {fg = c.morning_blue, gui = "italic"},
    ["@text.uri.markdown"] = {link = "@text.uri"},
    ["@text.strong.markdown"] = {link = "Bold"},
    ["@text.reference.markdown"] = {fg = c.blue, gui = underline},
    ["@text.quote.markdown"] = {link = "@string"},
    ["@punctuation.special.markdown"] = {fg = c.red, gui = bold},

    ["@text.todo.checked"] = {link = "markdownTSTodoChecked"},
    ["@text.todo.unchecked"] = {link = "markdownTSTodoUnchecked"},
}

-- https://github.com/vimwiki/vimwiki
hl.plugins.vimwiki = {
    VimwikiBold = {link = "Bold"},
    VimwikiBoldItalic = {link = "BoldItalic"},
    VimwikiItalicBold = {link = "BoldItalic"},
    VimwikiCode = {link = "TSCode"},
    VimwikiItalic = {link = "Italic"},
    VimwikiPre = fgs.purple,
    VimwikiPreDelim = {link = "PreProc"},
    VimwikiTag = fgs.red,
    VimwikiDelText = {fg = c.salmon, gui = "strikethrough"},
    VimwikiListTodo = {link = "markdownTSTodoUnchecked"},
    VimwikiCheckBoxDone = {link = "markdownTSTodoChecked"},
    VimwikiHeader1 = {link = "Title1"},
    VimwikiHeader2 = {link = "Title2"},
    VimwikiHeader3 = {link = "Title3"},
    VimwikiHeader4 = {link = "Title4"},
    VimwikiHeader5 = {link = "Title5"},
    VimwikiHeader6 = {link = "Title6"},
    VimwikiWeblink1 = {fg = c.aqua, gui = "underline"},
    VimwikiWeblink1Char = {fg = c.orange, gui = underline},
    VimwikiWikiLink1 = {fg = c.orange, gui = "underline"},
    VimwikiNoExistsLink = {fg = c.red, gui = "underline,bold"},
    VimwikiImage = {fg = c.blue, gui = "underline"},
    VimwikiMarkers = {link = "Comment"},
    VimwikiCellSeparator = {link = "markdownTSPunctSpecial"},
    VimwikiTableRow = {link = "Title"},
}

--  ╭─────╮
--  │ Tex │
--  ╰─────╯
hl.langs.tex = {
    -- Latex: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_TEX
    texStatement = {link = "Statement"},
    texOnlyMath = fgs.coyote_brown1,
    texDefName = {link = "Function"},
    texNewCmd = {fg = c.orange, gui = bold},
    texBeginEnd = {link = "Statement"},
    texBeginEndName = {link = "Statement"},
    texDocType = fgs.purple,
    texDocTypeArgs = {link = "TSParameter"},
    -- Vimtex: https://github.com/lervag/vimtex
    texCmd = {link = "Function"},
    texCmdClass = {link = "Type"},
    texCmdTitle = {link = "Title"},
    texCmdAuthor = {link = "Title"},
    texCmdPart = fgs.purple,
    texCmdBib = fgs.purple,
    texCmdPackage = {link = "Include"},
    texCmdNew = {fg = c.orange, gui = bold},
    texArgNew = {link = "TSParameter"},
    texPartArgTitle = {fg = c.blue, gui = italic},
    texFileArg = {link = "Directory"},
    texEnvArgName = {fg = c.aqua, gui = "bold"},
    texMathEnvArgName = {fg = c.blue, gui = italic},
    texTitleArg = {link = "Title"},
    texAuthorArg = {link = "Title"},
    -- Not in original
    texCmdEnv = fgs.aqua,
    texMathZoneX = fgs.orange,
    texMathZoneXX = fgs.orange,
    texMathDelimZone = fgs.coyote_brown1,
    texMathDelim = {link = "Delimiter"},
    texMathOper = {link = "Operator"},
    texPgfType = fgs.yellow,
    -- === Treesitter ===
    latexTSInclude = {link = "TSInclude"},
    latexTSFuncMacro = {link = "TSFuncMacro"},
    latexTSEnvironment = {fg = c.aqua, gui = "bold"},
    latexTSEnvironmentName = {fg = c.blue, gui = italic},
    latexTSMath = {link = "Delimiter"},
    latexTSTitle = {link = "Title"},
    latexTSType = {link = "TSType"},
}

hl.langs08.tex = {
    ["@include.latex"] = {link = "@include"},
    ["@function.macro.latex"] = {link = "@function.macro"},
    ["@text.environment.latex"] = {fg = c.aqua, gui = "bold"},
    ["@text.environment.name.latex"] = {fg = c.blue, gui = italic},
    ["@text.math.latex"] = {link = "Delimiter"},
    ["@text.title.latex"] = {link = "Title"},
    ["@type.latex"] = {link = "@type"},
}

--  ╭────────────╮
--  │ Javascript │
--  ╰────────────╯
hl.langs.javascript = {
    -- vim-javascript: https://github.com/pangloss/vim-javascript
    jsThis = {link = "TSVariableBuiltin"},
    jsUndefined = {link = "TSConstBuiltin"},
    jsNull = {link = "TSConstBuiltin"},
    jsNan = {link = "TSConstBuiltin"},
    jsSuper = {link = "TSVariableBuiltin"},
    jsPrototype = {link = "TSField"},
    jsFunction = {link = "Keyword"},
    jsGlobalNodeObjects = {link = "TSVariableBuiltin"},
    jsGlobalObjects = {link = "TSVariableBuiltin"},
    jsArrowFunction = {link = "Function"},
    jsArrowFuncArgs = {link = "TSParameter"},
    jsFuncArgs = {link = "TSParameter"},
    jsObjectProp = {link = "TSField"},
    jsVariableDef = {link = "TSVariable"},
    jsObjectKey = {link = "TSField"},
    jsParen = {link = "TSPunctBracket"},
    jsParenIfElse = {link = "TSPunctBracket"},
    jsParenRepeat = {link = "TSPunctBracket"},
    jsParenSwitch = {link = "TSPunctBracket"},
    jsParenCatch = {link = "TSPunctBracket"},
    jsBracket = {link = "TSPunctBracket"},
    jsBlockLabel = {link = "TSLabel"},
    jsFunctionKey = {link = "Function"},
    jsClassDefinition = {link = "TSType"},
    jsDot = {link = "Operator"},
    jsDestructuringBlock = {link = "Operator"},
    jsSpreadExpression = {link = "Operator"},
    jsSpreadOperator = {link = "Operator"},
    jsModuleKeyword = {link = "Keyword"},
    jsObjectValue = {link = "TSField"},
    jsTemplateExpression = {link = "SpecialChar"},
    jsTemplateBraces = {link = "TSPunctBracket"},
    jsClassMethodType = {link = "TSMethod"},
    -- yajs: https://github.com/othree/yajs.vim
    javascriptEndColons = {link = "typescriptEndColons"},
    javascriptOpSymbol = {link = "Operator"},
    javascriptOpSymbols = {link = "Operator"},
    javascriptIdentifierName = {link = "TSVariable"},
    javascriptVariable = {link = "TSVariable"},
    javascriptObjectLabel = {link = "TSField"},
    javascriptObjectLabelColon = {link = "typescriptObjectColon"},
    javascriptPropertyNameString = {link = "TSField"},
    javascriptFuncArg = {link = "TSParameter"},
    javascriptIdentifier = fgs.purple,
    javascriptArrowFunc = {link = "Function"},
    javascriptTemplate = {link = "SpecialChar"},
    javascriptTemplateSubstitution = {link = "SpecialChar"},
    javascriptTemplateSB = {link = "SpecialChar"},
    javascriptNodeGlobal = {link = "TSVariableBuiltin"},
    javascriptDocTags = {fg = c.purple, gui = italic},
    javascriptDocNotation = fgs.purple,
    javascriptClassSuper = {link = "TSVariableBuiltin"},
    javascriptClassName = {link = "TSType"},
    javascriptClassSuperName = {link = "TSType"},
    javascriptBrackets = {link = "TSPunctBracket"},
    javascriptBraces = {link = "TSPunctBracket"},
    javascriptLabel = {link = "TSLabel"},
    javascriptDotNotation = {link = "Operator"},
    javascriptGlobalArrayDot = {link = "Operator"},
    javascriptGlobalBigIntDot = {link = "Operator"},
    javascriptGlobalDateDot = {link = "Operator"},
    javascriptGlobalJSONDot = {link = "Operator"},
    javascriptGlobalMathDot = {link = "Operator"},
    javascriptGlobalNumberDot = {link = "Operator"},
    javascriptGlobalObjectDot = {link = "Operator"},
    javascriptGlobalPromiseDot = {link = "Operator"},
    javascriptGlobalRegExpDot = {link = "Operator"},
    javascriptGlobalStringDot = {link = "Operator"},
    javascriptGlobalSymbolDot = {link = "Operator"},
    javascriptGlobalURLDot = {link = "Operator"},
    javascriptMethod = {link = "TSMethod"},
    javascriptMethodName = {link = "TSMethod"},
    javascriptObjectMethodName = {link = "TSMethod"},
    javascriptGlobalMethod = {link = "TSMethod"},
    javascriptDOMStorageMethod = {link = "TSMethod"},
    javascriptFileMethod = {link = "TSMethod"},
    javascriptFileReaderMethod = {link = "TSMethod"},
    javascriptFileListMethod = {link = "TSMethod"},
    javascriptBlobMethod = {link = "TSMethod"},
    javascriptURLStaticMethod = {link = "TSMethod"},
    javascriptNumberStaticMethod = {link = "TSMethod"},
    javascriptNumberMethod = {link = "TSMethod"},
    javascriptDOMNodeMethod = {link = "TSMethod"},
    javascriptES6BigIntStaticMethod = {link = "TSMethod"},
    javascriptBOMWindowMethod = {link = "TSMethod"},
    javascriptHeadersMethod = {link = "TSMethod"},
    javascriptRequestMethod = {link = "TSMethod"},
    javascriptResponseMethod = {link = "TSMethod"},
    javascriptES6SetMethod = {link = "TSMethod"},
    javascriptReflectMethod = {link = "TSMethod"},
    javascriptPaymentMethod = {link = "TSMethod"},
    javascriptPaymentResponseMethod = {link = "TSMethod"},
    javascriptTypedArrayStaticMethod = {link = "TSMethod"},
    javascriptGeolocationMethod = {link = "TSMethod"},
    javascriptES6MapMethod = {link = "TSMethod"},
    javascriptServiceWorkerMethod = {link = "TSMethod"},
    javascriptCacheMethod = {link = "TSMethod"},
    javascriptFunctionMethod = {link = "TSMethod"},
    javascriptXHRMethod = {link = "TSMethod"},
    javascriptBOMNavigatorMethod = {link = "TSMethod"},
    javascriptDOMEventTargetMethod = {link = "TSMethod"},
    javascriptDOMEventMethod = {link = "TSMethod"},
    javascriptIntlMethod = {link = "TSMethod"},
    javascriptDOMDocMethod = {link = "TSMethod"},
    javascriptStringStaticMethod = {link = "TSMethod"},
    javascriptStringMethod = {link = "TSMethod"},
    javascriptSymbolStaticMethod = {link = "TSMethod"},
    javascriptRegExpMethod = {link = "TSMethod"},
    javascriptObjectStaticMethod = {link = "TSMethod"},
    javascriptObjectMethod = {link = "TSMethod"},
    javascriptBOMLocationMethod = {link = "TSMethod"},
    javascriptJSONStaticMethod = {link = "TSMethod"},
    javascriptGeneratorMethod = {link = "TSMethod"},
    javascriptEncodingMethod = {link = "TSMethod"},
    javascriptPromiseStaticMethod = {link = "TSMethod"},
    javascriptPromiseMethod = {link = "TSMethod"},
    javascriptBOMHistoryMethod = {link = "TSMethod"},
    javascriptDOMFormMethod = {link = "TSMethod"},
    javascriptClipboardMethod = {link = "TSMethod"},
    javascriptBroadcastMethod = {link = "TSMethod"},
    javascriptDateStaticMethod = {link = "TSMethod"},
    javascriptDateMethod = {link = "TSMethod"},
    javascriptConsoleMethod = {link = "TSMethod"},
    javascriptArrayStaticMethod = {link = "TSMethod"},
    javascriptArrayMethod = {link = "TSMethod"},
    javascriptMathStaticMethod = {link = "TSMethod"},
    javascriptSubtleCryptoMethod = {link = "TSMethod"},
    javascriptCryptoMethod = {link = "TSMethod"},
    javascriptProp = {link = "TSField"},
    javascriptBOMWindowProp = {link = "TSField"},
    javascriptDOMStorageProp = {link = "TSField"},
    javascriptFileReaderProp = {link = "TSField"},
    javascriptURLUtilsProp = {link = "TSField"},
    javascriptNumberStaticProp = {link = "TSField"},
    javascriptDOMNodeProp = {link = "TSField"},
    javascriptRequestProp = {link = "TSField"},
    javascriptResponseProp = {link = "TSField"},
    javascriptES6SetProp = {link = "TSField"},
    javascriptPaymentProp = {link = "TSField"},
    javascriptPaymentResponseProp = {link = "TSField"},
    javascriptPaymentAddressProp = {link = "TSField"},
    javascriptPaymentShippingOptionProp = {link = "TSField"},
    javascriptTypedArrayStaticProp = {link = "TSField"},
    javascriptServiceWorkerProp = {link = "TSField"},
    javascriptES6MapProp = {link = "TSField"},
    javascriptRegExpStaticProp = {link = "TSField"},
    javascriptRegExpProp = {link = "TSField"},
    javascriptXHRProp = {link = "TSField"},
    javascriptBOMNavigatorProp = {link = "TSField"},
    javascriptDOMEventProp = {link = "TSField"},
    javascriptBOMNetworkProp = {link = "TSField"},
    javascriptDOMDocProp = {link = "TSField"},
    javascriptSymbolStaticProp = {link = "TSField"},
    javascriptSymbolProp = {link = "TSField"},
    javascriptBOMLocationProp = {link = "TSField"},
    javascriptEncodingProp = {link = "TSField"},
    javascriptCryptoProp = {link = "TSField"},
    javascriptBOMHistoryProp = {link = "TSField"},
    javascriptDOMFormProp = {link = "TSField"},
    javascriptDataViewProp = {link = "TSField"},
    javascriptBroadcastProp = {link = "TSField"},
    javascriptMathStaticProp = {link = "TSField"},
    -- vim-jsx-pretty: https://github.com/maxmellon/vim-jsx-pretty
    jsxTagName = {link = "tsxTSTag"},
    jsxTag = {link = "tsxTSTag"},
    jsxOpenPunct = {link = "TSPunctBracket"},
    jsxClosePunct = {link = "TSPunctBracket"},
    jsxEscapeJs = {link = "SpecialChar"},
    jsxAttrib = {link = "tsxTSTagAttribute"},
    jsxCloseTag = {fg = c.aqua, gui = bold},
    jsxComponentName = {fg = c.blue, gui = bold},
    -- === Treesitter ===
    javascriptTSConstructor = {link = "TSConstructor"},
    javascriptTSException = {link = "TSException"},
    javascriptTSKeyword = {link = "Keyword"},
    javascriptTSKeywordReturn = {link = "TSKeywordReturn"},
    javascriptTSMethodCall = {link = "Function"},
    javascriptTSMethod = {link = "Function"},
    javascriptTSParameter = {link = "TSParameter"},
    javascriptTSProperty = {link = "TSField"},
    javascriptTSPunctBracket = {link = "TSPunctBracket"},
    javascriptTSPunctSpecial = {link = "TSPunctSpecial"},
    javascriptTSTypeBuiltin = {link = "TSTypeBuiltin"},
    javascriptTSVariableBuiltin = {link = "TSVariableBuiltin"},
}

hl.langs08.javascript = {
    ["@constructor.javascript"] = {link = "@constructor"},
    ["@exception.javascript"] = {link = "@exception"},
    ["@keyword.javascript"] = {link = "@keyword"},
    ["@keyword.return.javascript"] = {link = "@keyword.return"},
    ["@method.call.javascript"] = {link = "@function.call"},
    ["@method.javascript"] = {link = "@function"},
    ["@parameter.javascript"] = {link = "@parameter"},
    ["@property.javascript"] = {link = "@field"},
    ["@punctuation.bracket.javascript"] = {link = "@punctuation.bracket"},
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
    typescriptGlobalObjects = {link = "TSVariableGlobal"},
    typescriptInterpolation = fgs.green,
    typescriptInterpolationDelimiter = fgs.green,
    typescriptTypeBrackets = {link = "TSPunctBracket"},
    typescriptBraces = {link = "TSPunctBracket"},
    typescriptParens = {link = "TSPunctBracket"},
    -- yats: https://github.com/HerringtonDarkholme/yats.vim
    typescriptVariable = {link = "TSVariable"},
    typescriptVariableDeclaration = {link = "TSVariable"},
    typescriptAliasDeclaration = {link = "Type"},
    typescriptTypeReference = {link = "Type"},
    typescriptBoolean = {link = "Boolean"},
    typescriptCase = {link = "Conditional"},
    typescriptConditional = {link = "Conditional"},
    typescriptRepeat = {link = "Repeat"},
    typescriptAbstract = {link = "Keyword"},
    typescriptEnumKeyword = {link = "Keyword"},
    typescriptEnum = {link = "Type"},
    typescriptInterfaceName = {link = "Type"},
    typescriptTypeAnnotation = {link = "Type"},
    typescriptArrowFunc = {link = "Function"},
    typescriptCall = {link = "Function"},
    typescriptIdentifierName = fgs.aqua,
    typescriptProp = {link = "TSField"},
    typescriptMember = {link = "TSField"},
    typescriptMemberOptionality = {link = "Operator"},
    typescriptMethodAccessor = {link = "Operator"},
    typescriptAssign = {link = "Operator"},
    typescriptBinaryOp = {link = "Operator"},
    typescriptUnaryOp = {link = "Operator"},
    typescriptObjectLabel = {link = "Type"},
    typescriptObjectColon = fgs.coyote_brown1,
    typescriptEndColons = fgs.fg0,
    typescriptFuncTypeArrow = {link = "Function"},
    typescriptFuncComma = fgs.fg0,
    typescriptFunctionMethod = {link = "Function"},
    typescriptFuncName = {link = "Function"},
    typescriptFuncKeyword = {link = "Keyword"},
    typescriptClassName = {link = "TSTypeBuiltin"},
    typescriptClassHeritage = {link = "TSTypeBuiltin"},
    typescriptInterfaceHeritage = {link = "TSTypeBuiltin"},
    typescriptIdentifier = {link = "TSTypeBuiltin"},
    typescriptGlobal = {link = "TSVariableGlobal"},
    typescriptNodeGlobal = {link = "TSVariableGlobal"},
    typescriptOperator = {link = "Operator"},
    typescriptExport = {link = "Keyword"},
    typescriptDefaultParam = fgs.orange,
    typescriptImport = {link = "Include"},
    typescriptTypeParameter = {link = "TSType"},
    typescriptReadonlyModifier = {link = "Keyword"},
    typescriptAccessibilityModifier = {link = "Keyword"},
    typescriptAmbientDeclaration = {fg = c.red, gui = italic},
    typescriptTemplateSubstitution = {link = "SpecialChar"},
    typescriptTemplateSB = {link = "SpecialChar"},
    typescriptExceptions = {link = "TSException"},
    typescriptCastKeyword = {link = "Keyword"},
    typescriptOptionalMark = {link = "Operator"},
    typescriptNull = {link = "TSConstBuiltin"},
    typescriptMappedIn = {fg = c.red, gui = italic},
    typescriptTernaryOp = {link = "Function"},
    typescriptParenExp = {link = "Operator"},
    typescriptIndexExpr = {link = "Operator"},
    typescriptDotNotation = {link = "Operator"},
    typescriptGlobalNumberDot = {link = "Operator"},
    typescriptGlobalStringDot = {link = "Operator"},
    typescriptGlobalArrayDot = {link = "Operator"},
    typescriptGlobalObjectDot = {link = "Operator"},
    typescriptGlobalSymbolDot = {link = "Operator"},
    typescriptGlobalMathDot = {link = "Operator"},
    typescriptGlobalDateDot = {link = "Operator"},
    typescriptGlobalJSONDot = {link = "Operator"},
    typescriptGlobalRegExpDot = {link = "Operator"},
    typescriptGlobalPromiseDot = {link = "Operator"},
    typescriptGlobalURLDot = {link = "Operator"},
    typescriptGlobalMethod = {link = "TSMethod"},
    typescriptDOMStorageMethod = {link = "TSMethod"},
    typescriptFileMethod = {link = "TSMethod"},
    typescriptFileReaderMethod = {link = "TSMethod"},
    typescriptFileListMethod = {link = "TSMethod"},
    typescriptBlobMethod = {link = "TSMethod"},
    typescriptURLStaticMethod = {link = "TSMethod"},
    typescriptNumberStaticMethod = {link = "TSMethod"},
    typescriptNumberMethod = {link = "TSMethod"},
    typescriptDOMNodeMethod = {link = "TSMethod"},
    typescriptPaymentMethod = {link = "TSMethod"},
    typescriptPaymentResponseMethod = {link = "TSMethod"},
    typescriptHeadersMethod = {link = "TSMethod"},
    typescriptRequestMethod = {link = "TSMethod"},
    typescriptResponseMethod = {link = "TSMethod"},
    typescriptES6SetMethod = {link = "TSMethod"},
    typescriptReflectMethod = {link = "TSMethod"},
    typescriptBOMWindowMethod = {link = "TSMethod"},
    typescriptGeolocationMethod = {link = "TSMethod"},
    typescriptCacheMethod = {link = "TSMethod"},
    typescriptES6MapMethod = {link = "TSMethod"},
    typescriptRegExpMethod = {link = "TSMethod"},
    typescriptXHRMethod = {link = "TSMethod"},
    typescriptBOMNavigatorMethod = {link = "TSMethod"},
    typescriptServiceWorkerMethod = {link = "TSMethod"},
    typescriptIntlMethod = {link = "TSMethod"},
    typescriptDOMEventTargetMethod = {link = "TSMethod"},
    typescriptDOMEventMethod = {link = "TSMethod"},
    typescriptDOMDocMethod = {link = "TSMethod"},
    typescriptStringStaticMethod = {link = "TSMethod"},
    typescriptStringMethod = {link = "TSMethod"},
    typescriptSymbolStaticMethod = {link = "TSMethod"},
    typescriptObjectStaticMethod = {link = "TSMethod"},
    typescriptObjectMethod = {link = "TSMethod"},
    typescriptObjectType = {link = "TSMethod"},
    typescriptJSONStaticMethod = {link = "TSMethod"},
    typescriptEncodingMethod = {link = "TSMethod"},
    typescriptBOMLocationMethod = {link = "TSMethod"},
    typescriptPromiseStaticMethod = {link = "TSMethod"},
    typescriptPromiseMethod = {link = "TSMethod"},
    typescriptSubtleCryptoMethod = {link = "TSMethod"},
    typescriptCryptoMethod = {link = "TSMethod"},
    typescriptBOMHistoryMethod = {link = "TSMethod"},
    typescriptDOMFormMethod = {link = "TSMethod"},
    typescriptConsoleMethod = {link = "TSMethod"},
    typescriptDateStaticMethod = {link = "TSMethod"},
    typescriptDateMethod = {link = "TSMethod"},
    typescriptArrayStaticMethod = {link = "TSMethod"},
    typescriptArrayMethod = {link = "TSMethod"},
    typescriptMathStaticMethod = {link = "TSMethod"},
    typescriptStringProperty = {link = "TSField"},
    typescriptDOMStorageProp = {link = "TSField"},
    typescriptFileReaderProp = {link = "TSField"},
    typescriptURLUtilsProp = {link = "TSField"},
    typescriptNumberStaticProp = {link = "TSField"},
    typescriptDOMNodeProp = {link = "TSField"},
    typescriptBOMWindowProp = {link = "TSField"},
    typescriptRequestProp = {link = "TSField"},
    typescriptResponseProp = {link = "TSField"},
    typescriptPaymentProp = {link = "TSField"},
    typescriptPaymentResponseProp = {link = "TSField"},
    typescriptPaymentAddressProp = {link = "TSField"},
    typescriptPaymentShippingOptionProp = {link = "TSField"},
    typescriptES6SetProp = {link = "TSField"},
    typescriptServiceWorkerProp = {link = "TSField"},
    typescriptES6MapProp = {link = "TSField"},
    typescriptRegExpStaticProp = {link = "TSField"},
    typescriptRegExpProp = {link = "TSField"},
    typescriptBOMNavigatorProp = {link = "TSField"},
    typescriptXHRProp = {link = "TSField"},
    typescriptDOMEventProp = {link = "TSField"},
    typescriptDOMDocProp = {link = "TSField"},
    typescriptBOMNetworkProp = {link = "TSField"},
    typescriptSymbolStaticProp = {link = "TSField"},
    typescriptEncodingProp = {link = "TSField"},
    typescriptBOMLocationProp = {link = "TSField"},
    typescriptCryptoProp = {link = "TSField"},
    typescriptDOMFormProp = {link = "TSField"},
    typescriptBOMHistoryProp = {link = "TSField"},
    typescriptMathStaticProp = {link = "TSField"},
    -- === Treesitter ===
    typescriptTSParameter = {link = "TSParameter"},
    typescriptTSTypeBuiltin = {link = "TSTypeBuiltin"},
    typescriptTSKeywordReturn = {link = "TSKeywordReturn"},
    typescriptTSPunctBracket = {link = "TSPunctBracket"},
    typescriptTSPunctSpecial = {link = "TSPunctSpecial"},
    typescriptTSPunctDelimiter = {link = "TSPunctBracket"},
    typescriptTSVariableBuiltin = {link = "TSVariableBuiltin"},
    typescriptTSException = {link = "TSException"},
    typescriptTSConstructor = {link = "TSConstructor"},
    typescriptTSProperty = {link = "TSField"},
    typescriptTSMethod = {link = "Function"},
    typescriptTSMethodCall = {link = "TSFuncCall"},
    typescriptTSKeyword = {link = "Keyword"},
}

hl.langs08.typescript = {
    ["@parameter.typescript"] = {link = "@parameter"},
    ["@type.builtin.typescript"] = {link = "@type.builtin"},
    ["@keyword.return.typescript"] = {link = "@keyword.return"},
    ["@punctuation.bracket.typescript"] = {link = "@punctuation.bracket"},
    ["@punctuation.special.typescript"] = {link = "@punctuation.special"},
    ["@punctuation.delimiter.typescript"] = {link = "@punctuation.bracket"},
    ["@variable.builtin.typescript"] = {link = "@variable.builtin"},
    ["@exception.typescript"] = {link = "@exception"},
    ["@constructor.typescript"] = {link = "@constructor"},
    ["@property.typescript"] = {link = "@field"},
    ["@method.typescript"] = {link = "@function"},
    ["@method.call.typescript"] = {link = "@function.call"},
    ["@keyword.typescript"] = {link = "@keyword"},
}

--  ╭─────╮
--  │ tsx │
--  ╰─────╯
hl.langs.tsx = {
    tsxTSMethod = {link = "TSFunction"},
    tsxTSMethodCall = {link = "TSFunction"},
    tsxTSConstructor = {link = "TSConstructor"},
    tsxTSProperty = {link = "TSField"},
    tsxTSPunctBracket = {link = "TSPunctBracket"},
    tsxTSTagAttribute = {link = "TSField"},
    tsxTSTag = {fg = c.orange, gui = bold},
    tsxTSVariableBuiltin = {link = "TSVariableBuiltin"},
    tsxTSException = {link = "TSException"},
}

hl.langs08.tsx = {
    ["@method.tsx"] = {link = "@function"},
    ["@method.call.tsx"] = {link = "@function.call"},
    ["@constructor.tsx"] = {link = "@constructor"},
    ["@property.tsx"] = {link = "@field"},
    ["@punctuation.bracket.tsx"] = {link = "@punctuation.bracket"},
    ["@tag.attribute.tsx"] = {link = "@field"},
    ["@tag.tsx"] = {fg = c.orange, gui = bold},
    ["@variable.builtin.tsx"] = {link = "@variable.builtin"},
    ["@exception.tsx"] = {link = "@exception"},
}

--  ╭────────╮
--  │ Python │
--  ╰────────╯
hl.langs.python = {
    pythonBuiltin = {link = "TSVariableBuiltin"},
    pythonExceptions = {link = "TSException"},
    pythonDecoratorName = {link = "Function"},
    -- python-syntax: https://github.com/vim-python/python-syntax
    pythonExClass = {link = "TSType"},
    pythonBuiltinType = {link = "TSTypeBuiltin"},
    pythonBuiltinObj = {link = "TSVariableBuiltin"},
    pythonDottedName = {link = "TSField"},
    pythonBuiltinFunc = {link = "TSFuncBuiltin"},
    pythonFunction = {link = "Function"},
    pythonDecorator = {link = "Function"},
    pythonInclude = {link = "Include"},
    pythonImport = {link = "Include"},
    pythonRun = fgs.blue,
    pythonCoding = fgs.coyote_brown1,
    pythonOperator = {link = "Operator"},
    pythonConditional = {link = "Conditional"},
    pythonRepeat = {link = "Repeat"},
    pythonException = {link = "Exception"},
    pythonNone = {link = "Type"},
    pythonDot = fgs.coyote_brown1,
    -- semshi: https://github.com/numirias/semshi
    semshiUnresolved = {fg = c.green, gui = undercurl},
    semshiImported = {link = "Include"},
    semshiParameter = {link = "TSParameter"},
    semshiParameterUnused = fgs.wenge_grey,
    semshiSelf = {link = "TSVariableBuiltin"},
    semshiGlobal = {link = "TSVariableBuiltin"},
    semshiBuiltin = {link = "TSVariableBuiltin"},
    semshiAttribute = {link = "TSAttribute"},
    semshiLocal = {link = "Keyword"},
    semshiFree = {link = "Keyword"},
    semshiErrorSign = {link = "Error"},
    semshiErrorChar = {link = "Error"},
    semshiSelected = {bg = c.fg2},
    -- === Treesitter ===
    pythonTSConstant = {link = "TSConstant"},
    pythonTSConstBuiltin = {link = "TSConstBuiltin"},
    pythonTSConstructor = {link = "TSConstructor"},
    pythonTSField = {link = "TSField"},
    pythonTSKeywordFunction = {link = "TSKeywordReturn"},
    pythonTSMethod = {link = "TSFunction"},
    pythonTSMethodCall = {link = "TSFuncCall"},
    pythonTSParameter = fgs.orange,
    pythonTSPunctBracket = {link = "TSPunctBracket"},
    pythonTSStringEscape = {link = "TSStringEscape"},
    pythonTSType = {link = "TSType"},
}

hl.langs08.python = {
    ["@constant.python"] = {link = "@constant"},
    ["@constant.builtin.python"] = {link = "@constant.builtin"},
    ["@constructor.python"] = {link = "@constructor"},
    ["@field.python"] = {link = "@field"},
    ["@keyword.function.python"] = {link = "@keyword.return"},
    ["@method.python"] = {link = "@function"},
    ["@method.call.python"] = {link = "@function.call"},
    ["@parameter.python"] = fgs.orange,
    ["@punctuation.bracket.python"] = {link = "@punctuation.bracket"},
    ["@string.escape.python"] = {link = "@string.escape"},
    ["@type.python"] = {link = "@type"},
}

--  ╭────╮
--  │ Go │
--  ╰────╯
hl.langs.go = {
    goDirective = {fg = c.purple, gui = italic},
    goConstants = {link = "Constant"},
    goTypeDecl = {link = "Keyword"},
    goDeclType = {link = "Type"},
    goFunctionCall = {link = "Function"},
    goSpaceError = {fg = c.coyote_brown1, bg = c.teaberry},
    goVarArgs = {link = "Type"},
    goBuiltins = {link = "TSVariableBuiltin"},
    goPredefinedIdentifiers = {link = "TSConstBuiltin"},
    goVar = {link = "TSVariable"},
    goField = {link = "TSField"},
    goDeclaration = fgs.blue,
    goConst = {link = "TSConstant"},
    goParamName = {link = "TSParameter"},
    -- === Treesitter ===
    goTSField = {link = "TSField"},
    goTSMethod = {link = "TSFunction"},
    goTSMethodCall = {link = "TSFuncCall"},
    goTSNamespace = {fg = c.jade_green, gui = bold},
    goTSProperty = {link = "TSField"},
    goTSPunctBracket = {link = "TSPunctBracket"},
    goTSType = {link = "TSType"},
    goTSTypeBuiltin = {link = "TSTypeBuiltin"},
}

hl.langs08.go = {
    ["@field.go"] = {link = "@field"},
    ["@method.go"] = {link = "@function"},
    ["@method.call.go"] = {link = "@function.call"},
    ["@namespace.go"] = {fg = c.jade_green, gui = bold},
    ["@property.go"] = {link = "@field"},
    ["@punctuation.bracket.go"] = {link = "@punctuation.bracket"},
    ["@type.go"] = {link = "@type"},
    ["@type.builtin.go"] = {link = "@type.builtin"},
}

--  ╭──────╮
--  │ Rust │
--  ╰──────╯
hl.langs.rust = {
    -- rust.vim: https://github.com/rust-lang/rust.vim
    rustStructure = {link = "Structure"},
    rustIdentifier = fgs.purple,
    rustModPath = {link = "TSNamespace"},
    rustModPathSep = {link = "Delimiter"},
    rustSelf = {link = "TSVariableBuiltin"},
    rustSuper = {link = "TSVariableBuiltin"},
    rustDeriveTrait = {link = "Type"},
    rustEnumVariant = {link = "TSConstant"},
    rustMacroVariable = {link = "Macro"},
    rustAssert = {link = "Macro"},
    rustPanic = {link = "Macro"},
    rustPubScopeCrate = {link = "Namespace"},
    rustArrowCharacter = {link = "Operator"},
    rustOperator = {link = "Operator"},
    -- === Treesitter ===
    rustTSConstant = {link = "TSConstBuiltin"},
    rustTSConstBuiltin = fgs.purple,
    rustTSField = {link = "TSField"},
    rustTSFuncMacro = {link = "TSFuncMacro"},
    rustTSInclude = {link = "TSInclude"},
    rustTSLabel = fgs.green,
    rustTSNamespace = {link = "TSNamespace"},
    rustTSParameter = {link = "TSParameter"},
    rustTSPunctBracket = {link = "TSPunctBracket"},
    rustTSPunctSpecial = fgs.magenta,
    rustTSStringEscape = {link = "TSStringEscape"},
    rustTSType = {link = "TSTypeBuiltin"},
    rustTSTypeBuiltin = {link = "TSTypeBuiltin"},
    rustTSVariableBuiltin = {link = "TSVariableBuiltin"},
}

hl.langs08.rust = {
    ["@constant.rust"] = {link = "@constant"},
    ["@constant.builtin.rust"] = fgs.purple,
    ["@field.rust"] = {link = "@field"},
    ["@function.macro.rust"] = {link = "@function.macro"},
    ["@include.rust"] = {link = "@include"},
    ["@label.rust"] = fgs.green,
    ["@namespace.rust"] = {link = "@namespace"},
    ["@parameter.rust"] = {link = "@parameter"},
    ["@punctuation.bracket.rust"] = {link = "@punctuation.bracket"},
    ["@punctuation.special.rust"] = fgs.magenta,
    ["@string.escape.rust"] = {link = "@string.escape"},
    ["@type.rust"] = {link = "@type.builtin"},
    ["@type.builtin.rust"] = {link = "@type.builtin"},
    ["@variable.builtin.rust"] = {link = "@variable.builtin"},
}

--  ╭──────╮
--  │ Ruby │
--  ╰──────╯
hl.langs.ruby = {
    -- builtin: https://github.com/vim-ruby/vim-ruby
    rubyStringDelimiter = fgs.yellow,
    rubyModuleName = {link = "Include"},
    rubyMacro = {link = "Macro"},
    rubyKeywordAsMethod = {link = "Keyword"},
    rubyInterpolationDelimiter = {link = "SpecialChar"},
    rubyInterpolation = {link = "SpecialChar"},
    rubyDefinedOperator = {link = "Operator"},
    rubyDefine = {link = "Keyword"},
    rubyBlockParameterList = {link = "TSParameter"},
    rubyAttribute = {link = "Type"},
    rubyArrayDelimiter = {link = "Delimiter"},
    rubyCurlyBlockDelimiter = {link = "Delimiter"},
    rubyAccess = {link = "Operator"},
    -- === Treesitter ===
    rubyTSLabel = {link = "TSLabel"},
    rubyTSNone = fgs.blue,
    rubyTSParameter = {link = "TSParameter"},
    rubyTSPunctBracket = {link = "TSPunctBracket"},
    rubyTSPunctSpecial = {link = "TSPunctSpecial"},
    rubyTSString = {link = "TSString"},
    rubyTSSymbol = fgs.aqua,
    rubyTSType = {link = "TSTypeBuiltin"},
}

hl.langs08.ruby = {
    ["@label.ruby"] = {link = "@label"},
    ["@none.ruby"] = fgs.blue,
    ["@parameter.ruby"] = {link = "@parameter"},
    ["@punctuation.bracket.ruby"] = {link = "@punctuation.bracket"},
    ["@punctuation.special.ruby"] = {link = "@punctuation.special"},
    ["@string.ruby"] = {link = "@string"},
    ["@symbol.ruby"] = fgs.aqua,
    ["@type.ruby"] = {link = "@type.builtin"},
}

--  ╭──────╮
--  │ Perl │
--  ╰──────╯
hl.langs.perl = {
    -- builtin: https://github.com/vim-perl/vim-perl
    perlStatementPackage = {link = "Type"},
    perlStatementInclude = {link = "Include"},
    perlStatementStorage = fgs.orange,
    perlStatementList = fgs.orange,
    perlMatchStartEnd = fgs.orange,
    perlVarSimpleMemberName = {link = "TSField"},
    perlVarSimpleMember = {link = "TSField"},
    perlMethod = {link = "Function"},
    perlOperator = {link = "Operator"},
    podVerbatimLine = fgs.yellow,
    podCmdText = fgs.green,
    perlDATA = {fg = c.orange, gui = italic},
    perlBraces = {link = "Delimiter"},
    -- === Treesitter ===
    perlTSVariable = fgs.blue,
    perlTSKeywordFunction = {link = "TSKeywordReturn"},
    perlTSConditionalTernary = {link = "TSFunction"},
    perlTSInclude = {fg = c.red, gui = bold},
    perlTSType = {link = "TSTypeBuiltin"},
    perlTSNamespace = fgs.blue,
    perlTSVariableBuiltin = {fg = c.sea_green, gui = bold},
    perlTSStringRegex = fgs.salmon,
    perlTSParameter = {link = "TSParameter"},
}

hl.langs08.perl = {
    ["@variable.perl"] = fgs.blue,
    ["@keyword.function.perl"] = {link = "@keyword.return"},
    ["@conditional.ternary.perl"] = {link = "@function"},
    ["@include.perl"] = {fg = c.red, gui = bold},
    ["@type.perl"] = {link = "@type.builtin"},
    ["@namespace.perl"] = fgs.blue,
    ["@variable.builtin.perl"] = {fg = c.sea_green, gui = bold},
    ["@string.regex.perl"] = fgs.salmon,
    ["@parameter.perl"] = {link = "@parameter"},
    -- === Custom ===
    ["@function.exit.perl"] = {fg = c.red, gui = bold},
    ["@function.other.perl"] = {fg = c.red, gui = bold},
    ["@function.underscore.perl"] = {fg = c.green, gui = bold},
    ["@keyword.block.perl"] = {fg = c.oni_violet, gui = bold},
    ["@keyword.scope.perl"] = fgs.orange,
}

--  ╭──────╮
--  │ Teal │
--  ╰──────╯
hl.langs.teal = {
    tealTSOperator = {link = "TSOperator"},
    tealTSParameter = {link = "TSParameter"},
    tealTSPunctBracket = {link = "TSPunctBracket"},
    tealTSFunction = {link = "TSFunction"},
    tealTSConstant = {link = "TSTypeBuiltin"},
    tealTSConstBuiltin = {link = "TSConstBuiltin"},
}

hl.langs08.teal = {
    ["@operator.teal"] = {link = "@operator"},
    ["@parameter.teal"] = {link = "@parameter"},
    ["@punctuation.bracket.teal"] = {link = "@punctuation.bracket"},
    ["@function.teal"] = {link = "@function"},
    ["@constant.teal"] = {link = "@type.builtin"},
    ["@constant.builtin.teal"] = {link = "@constant.builtin"},
    -- === Custom ===
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
    luaTable = {link = "TSField"},
    luaConstant = {link = "TSConstBuiltin"},
    luaParens = {link = "Delimiter"},
    luaFuncParens = {link = "Delimiter"},
    luaLocal = {link = "Statement"},
    luaStatement = {link = "Statement"},
    luaSpecialValue = {link = "Function"},
    luaFuncCall = {link = "Function"},
    luaFuncId = {link = "Function"},
    luaFuncName = {link = "Function"},
    luaFuncKeyword = {link = "Keyword"},
    luaFuncTable = {link = "Type"},
    luaFuncArgName = {link = "TSParameter"},
    -- luaFuncArgs = {fg = c.ube},
    -- luaFunc = {fg = c.green, gui = bold},
    -- luaFuncSig = {fg = c.yellow, gui = bold},
    luaEllipsis = {link = "Type"},
    luaSpecialTable = {link = "Type"},
    luaOperator = fgs.red,
    luaSymbolOperator = fgs.orange,
    luaCond = {link = "Conditional"},
    luaErrHand = {link = "Exception"},
    -- === Treesitter ===
    luaTSConstant = {fg = c.green, gui = bold},
    luaTSConstBuiltin = {link = "TSConstBuiltin"},
    luaTSConstructor = {link = "TSConstructor"},
    luaTSProperty = fgs.green,
    luaTSLabel = {link = "TSLabel"},
    luaTSField = {link = "TSField"},
    luaTSPreproc = fgs.purple,
    luaTSMethod = {link = "TSMethod"},
    luaTSMethodCall = {link = "TSMethod"},
    luaTSPunctBracket = {link = "TSPunctBracket"},
    luaTSNamespaceBuiltin = {link = "TSNamespaceBuiltin"},
    luaTSVariableBuiltin = {link = "TSVariableBuiltin"},
    luaTSFunction = {link = "TSFunction"},
    luaTSFuncBuiltin = {link = "TSFunction"},
    luaTSKeywordFunction = {link = "TSKeywordFunction"},
    luaTSKeywordCoroutine = {fg = c.oni_violet, gui = bold},
}

hl.langs08.lua = {
    -- ["@punctuation.delimiter.lua"] = fgs.purple,
    -- ["@function.builtin.lua"] = {fg = c.russian_green, gui = bold},
    -- ["@comment.documentation.lua"] = fgs.blue,
    ["@constant.lua"] = {fg = c.green, gui = bold},
    ["@constant.builtin.lua"] = {link = "@constant.builtin"},
    ["@constructor.lua"] = {link = "@constructor"},
    ["@property.lua"] = fgs.green,
    ["@field.lua"] = {link = "@field"},
    ["@preproc.lua"] = fgs.purple,
    ["@label.lua"] = {link = "@label"},
    ["@method.lua"] = {link = "@method"},
    ["@method.call.lua"] = {link = "@method.call"},
    ["@punctuation.bracket.lua"] = {link = "@punctuation.bracket"},
    ["@namespace.builtin.lua"] = {link = "@namespace.builtin"},
    ["@variable.builtin.lua"] = {link = "@variable.builtin"},
    ["@function.lua"] = {link = "@function"},
    ["@function.builtin.lua"] = {link = "@function"},
    ["@keyword.function.lua"] = {link = "@keyword.function"},
    ["@keyword.coroutine.lua"] = {fg = c.oni_violet, gui = bold},
    -- === Custom ===
    ["@field.builtin.lua"] = fgs.wave_red,
    ["@function.meta.lua"] = {fg = c.wave_red, gui = bold},
    ["@function.error.lua"] = {fg = c.infra_red, gui = bold},
    -- ["@function.table.lua"] = {fg = c.new, gui = bold},
    -- ["@function.import.lua"] = {fg = c.teaberry, gui = bold},
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
    luadocTSPunctBracket = {link = "TSPunctBracket"},
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
    ["@punctuation.bracket.luadoc"] = {link = "@punctuation.bracket"},
    ["@punctuation.delimiter.luadoc"] = {fg = c.orange, gui = bold},
    ["@punctuation.special.luadoc"] = {link = "@punctuation.special"},
    -- === Custom ===
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
    luapTSOperator = {link = "Operator"},
    luapTSKeyword = {link = "Keyword"},
}

hl.langs08.luap = {
    ["@punctuation.special.luap"] = fgs.green,
    ["@punctuation.bracket.luap"] = fgs.blue,
    ["@operator.luap"] = {link = "@operator"},
    ["@keyword.luap"] = {link = "@keyword"},
}

--  ╭───────╮
--  │ Regex │
--  ╰───────╯
hl.langs.regex = {
    regexTSString = {fg = c.wave_red},
    -- regexTSConstCharacter = {fg = c.drama_violet, gui = bold},
    -- regexTSConstCharacterEscape = {fg = c.russian_green, gui = bold},
    regesTSPunctDelimiter = {fg = c.ube, gui = bold},
    regexTSOperator = {fg = c.glorious_sunset, gui = bold},
    regexTSProperty = {fg = c.yellow, gui = bold},
}

hl.langs08.regex = {
    -- ["@string.regex"] = {fg = c.beaver},
    ["@string.regex"] = {fg = c.wave_red},
    ["@constant.character.regex"] = {fg = c.drama_violet, gui = bold},
    ["@constant.character.escape.regex"] = {fg = c.russian_green, gui = bold},
    ["@punctuation.delimiter.regex"] = {fg = c.ube, gui = bold},
    ["@operator.regex"] = {fg = c.glorious_sunset, gui = bold},
    ["@property.regex"] = {fg = c.yellow, gui = bold},
}

--  ╭──────╮
--  │ VimL │
--  ╰──────╯
hl.langs.vim = {
    vimCommentTitle = {fg = c.coyote_brown1, bg = c.none, gui = bold},
    vimLet = fgs.orange,
    vimVar = fgs.aqua,
    vimFunction = {fg = c.magenta, gui = bold},
    vimIsCommand = {fg = c.red, gui = bold},
    vimUserFunc = {fg = c.green, gui = bold},
    vimFuncName = {fg = c.green, gui = bold},
    vimSetEqual = fgs.green,
    vimOption = fgs.aqua,
    vimUserAttrbKey = fgs.green,
    vimUserAttrb = fgs.yellow,
    vimAutoCmdSfxList = fgs.aqua,
    vimSynType = fgs.orange,
    vimHiBang = fgs.orange,
    vimSet = fgs.green,
    vimNotation = fgs.aqua,
    vimMap = {fg = c.red, gui = bold},
    vimMapModKey = fgs.green,
    vimMapLhs = {fg = c.green, gui = bold},
    vimMapRhs = fgs.yellow,
    vimSetSep = fgs.coyote_brown,
    vimContinue = fgs.coyote_brown1, -- backslash
    -- === Treesitter ===
    vimTSBoolean = fgs.orange,
    vimTSConditional = {fg = c.purple, gui = italic},
    vimTSConstBuiltin = {fg = c.aqua, gui = italic},
    vimTSConstant = {fg = c.sea_green, gui = bold},
    vimTSException = {fg = c.orange, gui = bold},
    vimTSFuncCall = {fg = c.magenta, gui = bold},
    vimTSFunction = {fg = c.magenta, gui = bold},
    vimTSKeyword = {fg = c.red, gui = bold},
    vimTSKeywordFunction = {fg = c.red, gui = bold},
    vimTSNamespace = {fg = c.blue, gui = bold},
    vimTSOperator = fgs.orange,
    vimTSPunctBracket = fgs.green,
    vimTSPunctSpecial = {fg = c.green, gui = bold},
    vimTSRepeat = fgs.blue,
    vimTSStringSpecial = fgs.green,
    vimTSType = {fg = c.green, gui = bold},
    vimTSVariableBuiltin = {fg = c.green, gui = bold},
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
    ["@keyword.function.vim"] = {fg = c.red, gui = bold},
    ["@namespace.vim"] = {fg = c.blue, gui = bold},
    ["@operator.vim"] = fgs.orange,
    ["@punctuation.bracket.vim"] = fgs.green,
    ["@punctuation.special.vim"] = {fg = c.green, gui = bold},
    ["@repeat.vim"] = fgs.blue,
    ["@string.special.vim"] = fgs.green,
    ["@type.vim"] = {fg = c.green, gui = bold},
    ["@variable.builtin.vim"] = {fg = c.green, gui = bold},
    ["@variable.self.vim"] = {fg = c.blue},
    -- Unsupported
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
    -- === Treesitter ===
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
    ["@attribute.c"] = {fg = c.glorious_sunset, gui = bold},
    -- ["@attribute.c"] = {fg = c.beaver, gui = bold},
    -- ["@attribute.c"] = {fg = c.ponceau, gui = bold},
    -- ["@attribute.c"] = {fg = c.cure_all, gui = bold},
    -- ["@comment.documentation.c"] = fgs.jasper_orange,
}

--  ╭─────╮
--  │ CPP │
--  ╰─────╯
hl.langs.cpp = {
    cppStatement = {fg = c.purple, gui = bold},
    -- === Treesitter ===
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
    ["@conditional.ternary.cpp"] = {link = "@function"},
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
    ["@function.builtin.zig"] = {fg = c.magenta, gui = bold},
    ["@attribute.zig"] = fgs.red,
    ["@punctuation.bracket.zig"] = fgs.orange,
    ["@constant.builtin.zig"] = {fg = c.orange, gui = bold},
    -- === Custom ===
    ["@variable.self.zig"] = fgs.blue,
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
    -- === Treesitter ===
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
    sedRegexp58 = fgs.drama_violet,
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
    -- === Custom ===
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
    -- === Treesitter ===
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
    -- === Custom ===
    ["@string.unit.css"] = fgs.salmon,
}

--  ╭──────╮
--  │ SCSS │
--  ╰──────╯
hl.langs.scss = {
    -- === Treesitter ===
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
    htmlBold = {link = "Bold"},
    -- === Treesitter ===
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
    -- === Treesitter ===
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
    -- === Treesitter ===
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
    -- === Treesitter ===
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
    -- === Treesitter ===
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
    -- === Treesitter ===
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
    -- === Treesitter ===
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
    -- === Treesitter ===
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
    -- === Treesitter ===
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
        bg = utils.tern(
            cfg.diagnostics.background,
            utils.darken(c.red, 0.1, c.bg0),
            c.none
        ),
        fg = c.red,
    },
    DiagnosticVirtualTextWarn = {
        bg = utils.tern(
            cfg.diagnostics.background,
            utils.darken(c.yellow, 0.1, c.bg0),
            c.none
        ),
        fg = c.yellow,
    },
    DiagnosticVirtualTextInfo = {
        bg = utils.tern(
            cfg.diagnostics.background,
            utils.darken(c.aqua, 0.1, c.bg0),
            c.none
        ),
        fg = c.aqua,
    },
    DiagnosticVirtualTextHint = {
        bg = utils.tern(
            cfg.diagnostics.background,
            utils.darken(c.purple, 0.1, c.bg0),
            c.none
        ),
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
hl.plugins.lsp.LspDiagnosticsVirtualTextInformation =
    hl.plugins.lsp.DiagnosticVirtualTextInfo
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
    CmpItemKindFile = {link = "CocSymbolFile"},
    CmpItemKindModule = {link = "CocSymbolModule"},
    CmpItemKindClass = {link = "CocSymbolClass"},
    CmpItemKindMethod = {link = "CocSymbolMethod"},
    CmpItemKindProperty = {link = "CocSymbolProperty"},
    CmpItemKindField = {link = "CocSymbolField"},
    CmpItemKindConstructor = {link = "CocSymbolConstructor"},
    CmpItemKindEnum = {link = "CocSymbolEnum"},
    CmpItemKindEnumMember = {link = "CocSymbolEnumMember"},
    CmpItemKindInterface = {link = "CocSymbolInterface"},
    CmpItemKindFunction = {link = "CocSymbolFunction"},
    CmpItemKindVariable = {link = "CocSymbolVariable"},
    CmpItemKindConstant = {link = "CocSymbolConstant"},
    CmpItemKindText = {link = "CocSymbolString"},
    CmpItemKindValue = fgs.purple,
    CmpItemKindStruct = {link = "CocSymbolStruct"},
    CmpItemKindEvent = {link = "CocSymbolEvent"},
    CmpItemKindOperator = {link = "CocSymbolOperator"},
    CmpItemKindTypeParameter = {link = "CocSymbolTypeParameter"},
    CmpItemKindDefault = fgs.teaberry,

    CmpItemAbbr = fgs.fg0,
    CmpItemAbbrDeprecated = fgs.wenge_grey,
    CmpItemAbbrMatch = fgs.aqua,
    CmpItemAbbrMatchFuzzy = {fg = c.aqua, gui = underline},
    CmpItemMenu = fgs.grullo_grey,
    CmpItemKindColor = fgs.green,
    CmpItemKindFolder = {link = "Directory"},
    CmpItemKindKeyword = {link = "Keyword"},
    CmpItemKindReference = fgs.orange,
    CmpItemKindSnippet = fgs.jade_green,
    CmpItemKindUnit = fgs.green,
}

-- https://github.com/stevearc/aerial.nvim
hl.plugins.aerial = {
    AerialLine = {link = "QuickFixLine"},
    AerialGuide = {link = "LineNr"},
    AerialFileIcon = {link = "CocSymbolFile"},
    AerialModuleIcon = {link = "CocSymbolModule"},
    AerialNamespaceIcon = {link = "CocSymbolNamespace"},
    AerialPackageIcon = {link = "CocSymbolPackage"},
    AerialClassIcon = {link = "CocSymbolClass"},
    AerialMethodIcon = {link = "CocSymbolMethod"},
    AerialPropertyIcon = {link = "CocSymbolProperty"},
    AerialFieldIcon = {link = "CocSymbolField"},
    AerialConstructorIcon = {link = "CocSymbolConstructor"},
    AerialEnumIcon = {link = "CocSymbolEnum"},
    AerialEnumMemberIcon = {link = "CocSymbolEnumMember"},
    AerialInterfaceIcon = {link = "CocSymbolInterface"},
    AerialFunctionIcon = {link = "CocSymbolFunction"},
    AerialVariableIcon = {link = "CocSymbolVariable"},
    AerialConstantIcon = {link = "CocSymbolConstant"},
    AerialStringIcon = {link = "CocSymbolString"},
    AerialNumberIcon = {link = "CocSymbolNumber"},
    AerialBooleanIcon = {link = "CocSymbolBoolean"},
    AerialArrayIcon = {link = "CocSymbolArray"},
    AerialObjectIcon = {link = "CocSymbolObject"},
    AerialKeyIcon = {link = "CocSymbolKey"},
    AerialNullIcon = {link = "CocSymbolNull"},
    AerialStructIcon = {link = "CocSymbolStruct"},
    AerialEventIcon = {link = "CocSymbolEvent"},
    AerialOperatorIcon = {link = "CocSymbolOperator"},
    AerialTypeParameterIcon = {link = "CocSymbolTypeParameter"},
}

-- https://github.com/neoclide/coc.nvim
hl.plugins.coc = {
    CocErrorHighlight = {fg = c.none, gui = undercurl, sp = c.red},
    CocWarningHighlight = {fg = c.none, gui = undercurl, sp = c.yellow},
    CocInfoHighlight = {fg = c.none, gui = undercurl, sp = c.blue},
    CocHintHighlight = {fg = c.none, gui = undercurl, sp = c.aqua},

    CocErrorSign = fgs.red,
    CocWarningSign = fgs.yellow,
    CocInfoSign = fgs.blue,
    CocHintSign = fgs.amethyst,

    CocErrorVirtualText = fgs.coyote_brown1,
    CocWarningVirtualText = fgs.coyote_brown1,
    CocInfoVirtualText = fgs.coyote_brown1,
    CocHintVirtualText = fgs.coyote_brown1,

    CocErrorFloat = {fg = c.red, bg = c.bg3},
    CocWarningFloat = {fg = c.green, bg = c.bg3},
    CocInfoFloat = {fg = c.blue, bg = c.bg3},
    CocHintFloat = {fg = c.aqua, bg = c.bg3},

    CocFloating = {fg = c.fg1, bg = c.bg3},
    CocFloatDividingLine = fgs.beaver,
    CocFloatActive = fgs.orange,                    -- currently typed text
    CocFloatThumb = {link = "PmenuThumb"},          -- thumb of scrollbar
    CocFloatSbar = {link = "PmenuSbar"},            -- scrollbar

    CocSearch = fgs.orange,                         -- for matched input characters
    CocDisabled = fgs.grullo_grey,
    CocFadeOut = fgs.wenge_grey,                    -- faded text (i.e., not used) CocUnusedHighlight CocDeprecatedHighlight
    CocCursorRange = {fg = c.bg1, bg = c.fuzzy_wuzzy},
    CocHoverRange = {fg = c.none, gui = underbold}, -- range of current hovered symbol
    CocHighlightText = {bg = c.fg2},                -- Coc cursorhold event
    CocHighlightRead = {bg = c.fg2},                -- Coc cursorhold event (Read types)
    CocHighlightWrite = {bg = c.fg2},               -- Coc cursorhold event (Write types)
    -- CocSnippetVisual = {bg = c.bg4}, -- highlight snippet placeholders

    CocMenuSel = {fg = c.none, bg = c.bg1}, -- current menu item in menu dialog
    CocCodeLens = fgs.coyote_brown1,
    CocInlayHint = fgs.russian_green,
    CocInlayHintParameter = fgs.russian_green,
    CocInlayHintType = fgs.amethyst,

    CocPumSearch = {fg = c.orange}, -- for menu of complete items
    CocPumMenu = {fg = c.fg1},      -- items at the end like [LS]
    CocPumDeprecated = fgs.red,
    CocPumVirtualText = {fg = c.coyote_brown1},

    CocTreeTitle = {fg = c.red, gui = "bold"},
    -- Notification
    CocNotificationButton = {fg = c.red, gui = "bold"},
    CocNotificationProgress = {fg = c.blue, bg = "none"},
    CocNotificationError = fgs.red,
    CocNotificationWarning = fgs.yellow,
    CocNotificationInfo = fgs.blue,
    -- Markdown
    CocBold = {link = "Bold"},
    CocItalic = {link = "Italic"},
    CocUnderline = {link = "Underline"},
    CocStrikeThrough = {link = "Strikethrough"},
    CocMarkdownCode = {link = "markdownCode"},
    CocMarkdownHeader = {fg = c.russian_green, gui = bold},
    CocMarkdownLink = {link = "markdownLinkText"},
    -- Symbols
    CocSymbolFile = fgs.green,
    CocSymbolModule = fgs.red,
    CocSymbolNamespace = {link = "TSNamespace"},
    CocSymbolPackage = fgs.red,
    CocSymbolClass = fgs.ube,
    CocSymbolMethod = {link = "TSMethod"},
    CocSymbolProperty = {link = "TSProperty"},
    CocSymbolField = {link = "TSField"},
    CocSymbolConstructor = {link = "TSConstructor"},
    CocSymbolEnum = fgs.green,
    CocSymbolEnumMember = fgs.aqua,
    CocSymbolInterface = fgs.infra_red,
    CocSymbolFunction = fgs.red,
    CocSymbolVariable = fgs.glorious_sunset,
    CocSymbolConstant = {fg = c.aqua, gui = bold},
    CocSymbolString = {link = "String"},
    CocSymbolNumber = {link = "Number"},
    CocSymbolBoolean = {link = "Boolean"},
    CocSymbolArray = fgs.green,
    CocSymbolObject = fgs.orange,
    CocSymbolKey = fgs.purple,
    CocSymbolNull = fgs.orange,
    CocSymbolStruct = {link = "Structure"},
    CocSymbolEvent = fgs.red,
    CocSymbolOperator = {link = "Operator"},
    CocSymbolTypeParameter = fgs.green,
    CocSymbolDefault = fgs.teaberry,

    -- === Custom ===
    CocSuggestFloating = {fg = c.fg0, bg = c.bg3}, -- bg0
}

-- https://github.com/neoclide/coc-git
hl.plugins.coc_git = {
    CocGitAddedSign = {link = "GitSignsAdd"},
    CocGitChangedSign = {link = "GitSignsChange"},
    CocGitChangeRemovedSign = {link = "GitSignsChangedelete"},
    CocGitRemovedSign = {link = "GitSignsDelete"},
    CocGitTopRemovedSign = {link = "GitSignsTopdelete"},
}

-- https://github.com/weirongxu/coc-explorer
hl.plugins.coc_explorer = {
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
    GitGutterAdd = {link = "GitSignsAdd"},
    GitGutterChange = {link = "GitSignsChange"},
    GitGutterChangeDelete = {link = "GitSignsChangedelete"},
    GitGutterDelete = {link = "GitSignsDelete"},
    GitGutterAddLineNr = {link = "GitSignsAddNr"},
    GitGutterChangeLineNr = {link = "GitSignsChangeNr"},
    GitGutterChangeDeleteLineNr = {link = "GitSignsChangedeleteNr"},
    GitGutterDeleteLineNr = {link = "GitSignsDeleteNr"},
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
    WhichKeyDesc = fgs.drama_violet,
    WhichKeyGroup = {fg = c.green, gui = "bold"},
    -- WhichKeyFloat = {fg = c.fg1, bg = c.bg3},
    WhichKeyFloat = {fg = c.fg1, bg = bgs.cannon},
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

-- https://githi.com/kevinhwang91/nvim-bqf
hl.plugins.bqf = {
    BqfSign = {fg = c.deep_lilac, gui = bold},
    BqfPreviewBorder = {link = "Parameter"},
    -- BqfPreviewRange = {},
    -- BqfPreviewCursorLine = {},
    -- BqfPreviewBufLabel = {},
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
    DiffviewFilePanelPath = {link = "TSConstant"},
    DiffviewFilePanelRootPath = {link = "Directory"},
    DiffviewFilePanelTitle = {fg = c.blue, gui = bold},
    DiffviewStatusAdded = {link = "Type"},
    DiffviewStatusBroken = {fg = c.red, gui = "bold"},
    DiffviewStatusCopied = fgs.blue,
    DiffviewStatusDeleted = {link = "ErrorMsg"},
    DiffviewStatusModified = {link = "Constant"},
    DiffviewStatusRenamed = {link = "Character"},
    DiffviewStatusTypeChange = {link = "Character"},
    DiffviewStatusUnknown = fgs.teaberry,
    DiffviewStatusUnmerged = fgs.amethyst,
    DiffviewStatusUntracked = {link = "Tag"},
}

-- https://github.com/TimUntersberger/neogit
hl.plugins.neogit = {
    NeogitDiffAdd = {link = "Type"},
    NeogitDiffAddHighlight = {link = "DiffAdd"},
    NeogitDiffDelete = {link = "ErrorMsg"},
    NeogitDiffDeleteHighlight = {link = "DiffDelete"},
    NeogitDiffContextHighlight = {link = "CursorLine"},
    NeogitNotificationInfo = {link = "NotifyINFOTitle"},
    NeogitNotificationWarning = {link = "NotifyWARNTitle"},
    NeogitNotificationError = {link = "NotifyERRORTitle"},
    NeogitObjectId = {link = "Function"},
    NeogitDiffHeader = {fg = c.aqua, gui = bold},
    NeogitHunkHeader = {link = "Title"}, -- diffLine
    -- NeogitHunkHeaderHighlight = {link = "Title"},
    NeogitCommitViewHeader = {fg = c.blue, bg = c.bg2, gui = bold},
    -- NeogitCommitViewDescription = {fg = "#FFFFFF"},
    NeogitCommitMessage = {link = "String"},
    NeogitRecentcommits = {fg = c.aqua, gui = bold},
    NeogitFilePath = {link = "TSConstant"},
    NeogitBranch = {link = "Title"},
    NeogitRemote = {link = "PreProc"},
    NeogitStash = {fg = c.glorious_sunset, gui = bold},
    NeogitRebaseDone = {fg = c.salmon, gui = bold},
    NeogitUnmergedInto = {fg = c.teaberry, gui = bold},
    NeogitUnpulledFrom = {fg = c.russian_green, gui = bold},
    NeogitUnstagedChanges = {fg = c.slate_grey, gui = bold},
    NeogitCommandCodeNormal = {link = "Type"},
    NeogitCommandCodeError = {link = "ErrorMsg"},
    -- NeogitCommandText = {},
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
    gitcommitOnBranch = {link = "Title"},
    gitcommitArrow = {fg = c.magenta, gui = bold},
    gitcommitFile = {fg = c.aqua, gui = bold},
}

-- https://github.com/lewis6991/gitsigns.nvim
hl.plugins.gitsigns = {
    -- Text of signs
    GitSignsAdd = {link = "Type"},
    GitSignsChange = {fg = c.aqua, gui = bold},
    GitSignsChangedelete = {fg = c.drama_violet, gui = bold},
    GitSignsDelete = {link = "ErrorMsg"},
    GitSignsTopdelete = {fg = c.paisley_purple, gui = bold},
    GitSignsUntracked = {fg = c.yellow, gui = bold},
    -- Number column of signs (`numhl == true`)
    GitSignsAddNr = {link = "GitSignsAdd"},
    GitSignsChangeNr = {link = "GitSignsChange"},
    GitSignsChangedeleteNr = {link = "GitSignsChangedelete"},
    GitSignsDeleteNr = {link = "GitSignsDelete"},
    GitSignsTopdeleteNr = {link = "GitSignsTopdelete"},
    GitSignsUntrackedNr = {link = "GitSignsUntracked"},
    -- Buffer line of signs (`linehl == true`)
    GitSignsAddLn = {link = "DiffAdd"},
    GitSignsChangeLn = {link = "DiffText"},
    GitSignsChangedeleteLn = {link = "GitSignsChangeLn"},
    GitSignsDeleteLn = {link = "DiffDelete"},
    GitSignsUntrackedLn = {fg = c.none, bg = c.fresh_cinnamon},
    -- Word diff regions in inline previews
    GitSignsAddInline = {link = "DiffAdd"},
    GitSignsChangeInline = {link = "DiffText"},
    GitSignsDeleteInline = {link = "DiffDelete"},
    -- Word diff regions in buffer (`.word_diff == true`)
    GitSignsAddLnInline = {link = "GitSignsAdd"},
    GitSignsChangeLnInline = {link = "GitSignsChange"},
    GitSignsDeleteLnInline = {link = "GitSignsDelete"},
    -- Word diff in lines with preview_hunk_inline()/show_deleted()
    GitSignsAddVirtLnInline = {link = "DiffAdd"},
    GitSignsChangeVirtLnInline = {link = "DiffText"},
    GitSignsDeleteVirtLnInline = {link = "DiffDelete"},
    -- Lines in preview
    GitSignsAddPreview = {link = "DiffAdd"},
    GitSignsDeletePreview = {link = "DiffDelete"},
    GitSignsVirtLnum = {fg = c.magenta},           -- line numbers in inline hunks previews
    GitSignsDeleteVirtLn = {link = "DiffDelete"},
    GitSignsCurrentLineBlame = {link = "NonText"}, -- current line blame
    -- Staged text of signs
    GitSignsStagedAdd = {link = "GitSignsAdd"},
    GitSignsStagedChange = {link = "GitSignsChange"},
    GitSignsStagedChangedelete = {link = "GitSignsChangedelete"},
    GitSignsStagedDelete = {link = "GitSignsDelete"},
    GitSignsStagedTopdelete = {link = "GitSignsTopdelete"},
    -- Staged number column of signs (`numhl == true`)
    GitSignsStagedAddNr = fgs.green,
    GitSignsStagedChangeNr = fgs.aqua,
    GitSignsStagedChangedeleteNr = fgs.drama_violet,
    GitSignsStagedDeleteNr = fgs.red,
    GitSignsStagedTopdeleteNr = fgs.paisley_purple,
    -- Staged buffer line of signs (`linehl == true`)
    GitSignsStagedAddLn = {link = "GitSignsAddLn"},
    GitSignsStagedChangeLn = {link = "GitSignsChangeLn"},
    GitSignsStagedChangedeleteLn = {link = "GitSignsChangedeleteLn"},
    GitSignsStagedDeleteLn = {link = "GitSignsDeleteLn"},
    GitSignsStagedTopdeleteLn = {link = "GitSignsTopdeleteLn"},
    -- GitSignsTopdeleteLn = {link = "DiffDelete"},
    -- GitSignsAddVirtLn = {link = "DiffAdd"},
    -- GitSignsChangeVirtLn = {link = "DiffText"},
}

-- https://github.com/ibhagwan/fzf-lua
hl.plugins.fzf_lua = {
    FzfLuaNormal = {link = "Normal"},                    -- main fg/bg
    FzfLuaBorder = {link = "FloatBorder"},               -- main border
    FzfLuaTitle = {fg = c.purple, gui = bold},           -- main title
    FzfLuaPreviewNormal = {link = "FzfLuaNormal"},       -- builtin preview fg/bg
    FzfLuaPreviewBorder = {link = "FzfLuaBorder"},       -- builtin preview border
    FzfLuaPreviewTitle = {link = "FzfLuaTitle"},         -- builtin preview title
    FzfLuaCursor = {link = "Cursor"},                    -- builtin preview `Cursor`
    FzfLuaCursorLine = {link = "CursorLine"},            -- builtin preview `Cursorline`
    FzfLuaCursorLineNr = {link = "CursorLineNr"},        -- builtin preview `CursorLineNr`
    FzfLuaSearch = {link = "IncSearch"},                 -- builtin preview search matches
    FzfLuaScrollBorderEmpty = {fg = c.red, gui = bold},  -- builtin preview `border` scroll empty
    FzfLuaScrollBorderFull = {fg = c.green, gui = bold}, -- builtin preview `border` scroll full
    FzfLuaScrollFloatEmpty = {link = "PmenuSbar"},       -- builtin preview `float` scroll empty
    FzfLuaScrollFloatFull = {link = "PmenuThumb"},       -- builtin preview `float` scroll full
    FzfLuaHelpNormal = {link = "FzfLuaNormal"},          -- help win `fg/bg`
    FzfLuaHelpBorder = {fg = c.salmon, gui = bold},      -- help win border
    FzfLuaHeaderBind = {fg = c.beaver},                  -- header keybind
    FzfLuaHeaderText = {fg = c.slate_grey},              -- header text
    FzfLuaBufName = {link = "Title"},                    -- buffer name (`lines`)
    FzfLuaBufNr = {link = "Type"},                       -- buffer number (all buffers)
    FzfLuaBufLineNr = {link = "CursorLineNr"},           -- buffer line (`lines`)
    FzfLuaBufFlagCur = {link = "Constant"},              -- buffer line (`buffers`)
    FzfLuaBufFlagAlt = {link = "Tag"},                   -- buffer line (`buffers`)
    FzfLuaTabTitle = {link = "Title"},                   -- tab title (`tabs`)
    FzfLuaTabMarker = {link = "Constant"},               -- tab marker (`tabs`)
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
    TelescopePrompt = fgs.fg0,
    TelescopeTitle = {fg = c.purple, gui = bold},
    TelescopeBorder = fgs.magenta,
    TelescopeBufferLoaded = fgs.red,
    TelescopeFrecencyScores = fgs.green,
    TelescopeMatching = fgs.orange,
    TelescopeMultiIcon = fgs.aqua,
    TelescopeMultiSelection = fgs.blue,
    TelescopePathSeparator = fgs.magenta,
    TelescopePreviewBorder = fgs.magenta,
    TelescopePreviewExecute = {link = "String"},
    TelescopePreviewWrite = {fg = c.green, gui = bold},
    TelescopePreviewSocket = {link = "Function"},
    TelescopePreviewLink = {link = "TSURI"},
    TelescopePreviewBlock = {link = "Constant"},
    TelescopePreviewDirectory = {link = "Title"},
    TelescopePreviewCharDev = fgs.teaberry,
    TelescopePreviewCharPipe = fgs.teaberry,
    TelescopePreviewMatch = {link = "Search"},
    TelescopePreviewTitle = {fg = c.salmon, gui = bold},
    TelescopePromptBorder = fgs.magenta,
    TelescopePromptPrefix = fgs.red,
    TelescopePromptTitle = {link = "TelescopeTitle"},
    TelescopeResultsBorder = fgs.magenta,
    TelescopeResultsComment = {link = "Comment"},
    TelescopeResultsSpecialComment = {link = "SpecialComment"},
    TelescopeResultsTitle = {fg = c.salmon, gui = bold},
    TelescopeSelection = {fg = c.yellow, gui = bold},
    TelescopeSelectionCaret = fgs.green,
    -- TelescopeNormal = {link = "Normal"},
    -- TelescopePromptNormal = {link = "Normal"},
    -- TelescopePreviewLine = {link = "Visual"},
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
    IndentBlanklineContextChar = {fg = c.teaberry, gui = "nocombine"},
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
    NotifyERRORBody = {fg = c.beaver, bg = bgs.cannon},
    NotifyERRORIcon = fgs.red,
    NotifyERRORTitle = fgs.red,
    NotifyWARNBorder = fgs.coconut,
    NotifyWARNBody = {fg = c.beaver, bg = bgs.cannon},
    NotifyWARNIcon = fgs.yellow,
    NotifyWARNTitle = fgs.yellow,
    NotifyINFOBorder = fgs.slate_grey,
    NotifyINFOBody = {fg = c.beaver, bg = bgs.cannon},
    NotifyINFOIcon = fgs.blue,
    NotifyINFOTitle = fgs.blue,
    NotifyDEBUGBorder = fgs.jasper_orange,
    NotifyDEBUGBody = {fg = c.beaver, bg = bgs.cannon},
    NotifyDEBUGIcon = fgs.orange,
    NotifyDEBUGTitle = fgs.orange,
    NotifyTRACEBorder = fgs.drama_violet,
    NotifyTRACEBody = {fg = c.beaver, bg = bgs.cannon},
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

-- https://github.com/tversteeg/registers.nvim
hl.plugins.registers = {
    RegistersEscaped = {link = "SpecialChar"},
    RegistersWhitespace = {link = "Comment"},
    RegistersString = {link = "String"},
    RegistersNumber = {link = "Number"},
    -- NOTE: these need to be used manually within registers.nvim setup() function
    RegistersCursorline = {fg = c.purple, bg = c.royal_brown, gui = "bold,underline"}, -- when the cursor is over the line
    RegistersSelection = {fg = c.salmon, gui = bold},                                  -- selection registers, `*+`
    RegistersDefault = {link = "@bold"},                                               -- default register, `"`
    RegistersUnnamed = {link = "@function"},                                           -- unnamed register, `\\`
    RegistersReadOnly = {link = "Statement"},                                          -- read only registers, `:.%`
    RegistersExpression = {link = "@text.title"},                                      -- expression register, `=`
    RegistersBlackHole = {fg = c.amethyst},                                            -- black hole register, `_`
    RegistersAlternateBuffer = {fg = c.glorious_sunset, gui = bold},                   -- alternate buffer register, `#` [@property]
    RegistersLastSearch = {fg = c.vista_blue},                                         -- last search register, `/` [Search]
    RegistersDelete = {fg = c.fg0, bg = c.diff_delete},                                -- delete register, `-`
    RegistersYank = {link = "@type"},                                                  -- yank register, `0`
    RegistersHistory = {link = "Number"},                                              -- history registers, `1-9`
    RegistersNamed = {fg = c.slate_grey},                                              -- named registers, `a-z`
}

function M.toggle_bg()
    utils.highlight(hl.common)
end

function M.setup()
    if utils.needs_api_fix() then
        utils.highlight.alt({
            Normal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
        })
    else
        utils.highlight({Normal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)}})
    end

    utils.highlight(hl.common)
    utils.highlight(hl.syntax)
    utils.highlight(hl.treesitter)

    for lang, group in pairs(hl.langs) do
        if not vim.tbl_contains(cfg.disabled.langs, lang) then
            utils.highlight(group)
        end
    end

    for plugin, group in pairs(hl.plugins) do
        if not vim.tbl_contains(cfg.disabled.plugins, plugin) then
            utils.highlight(group)
        end
    end

    if cfg.langs08 then
        if utils.has08() then
            for lang, group in pairs(hl.langs08) do
                if not vim.tbl_contains(cfg.disabled.langs08, lang) then
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

    ---@class Kimbox.Highlight.Langs
    M.langs = vim.tbl_keys(hl.langs)
    ---@class Kimbox.Highlight.Langs08
    M.langs08 = vim.tbl_keys(hl.langs08)
    ---@class Kimbox.Highlight.Plugins
    M.plugins = vim.tbl_keys(hl.plugins)
end

return M
