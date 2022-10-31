---@diagnostic disable:need-check-nil
local M = {}
local hl = {
    langs = {},
    langs08 = {},
    plugins = {}
}

-- Location where Treesitter capture groups changed to '@capture.name'
-- Commit:    030b422d1
-- Vim patch: patch-8.2.0674

local c = require("kimbox.colors")
local utils = require("kimbox.utils")
local log = utils.log

local cfg = vim.g.kimbox_config

M.langs = hl.langs
M.plugins = hl.plugins

local reverse = cfg.allow_reverse and "reverse" or "none"
local bold = cfg.allow_bold and "bold" or "none"
local italic = cfg.allow_italic and "italic" or "none"
local underline = cfg.allow_underline and "underline" or "none"
local undercurl = cfg.allow_undercurl and "undercurl" or "none"
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

local fgs = {
    fg0 = {fg = c.fg0},
    fg1 = {fg = c.fg1},
    fg2 = {fg = c.fg2},
    bg1 = {fg = c.bg1},
    bg2 = {fg = c.bg2},
    bg3 = {fg = c.bg3},
    bg4 = {fg = c.bg4},
    grullo_grey = {fg = c.grullo_grey},
    coyote_brown1 = {fg = c.coyote_brown1},
    coyote_brown = {fg = c.coyote_brown},
    amethyst = {fg = c.amethyst},
    red = {fg = c.red},
    bg_red = {fg = c.bg_red},
    aqua = {fg = c.aqua},
    yellow = {fg = c.yellow},
    orange = {fg = c.orange},
    green = {fg = c.green},
    blue = {fg = c.blue},
    purple = {fg = c.purple},
    magenta = {fg = c.magenta},
    operator_base05 = {fg = c.operator_base05},
    philippine_green = {fg = c.philippine_green}
}

hl.common = {
    Normal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    NormalNC = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    Terminal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    FoldColumn = {fg = c.coyote_brown, bg = utils.tern(trans, c.none, c.bg2)},
    SignColumn = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    ToolbarLine = {fg = utils.tern(trans, c.fg0, c.fg1), bg = utils.tern(trans, c.none, c.bg3)},
    VertSplit = {fg = c.fg1, bg = c.none},
    WinSeparator = {link = "VertSplit"},
    Folded = {fg = c.coyote_brown1, bg = c.bg2},
    EndOfBuffer = {
        fg = utils.tern(cfg.ending_tildes, c.bg2, c.bg0),
        bg = utils.tern(trans, c.none, c.bg0)
    },
    IncSearch = {fg = c.bg1, bg = c.light_red},
    Search = {fg = c.bg0, bg = c.vista_blue},
    ColorColumn = {bg = c.bg1}, -- used for the columns set with 'colorcolumn'
    Conceal = {fg = c.coyote_brown1, bg = c.none}, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = {gui = reverse}, -- character under the cursor
    vCursor = {gui = reverse},
    iCursor = {gui = reverse},
    lCursor = {gui = reverse}, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM = {gui = reverse}, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = {bg = c.bg1}, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = {fg = c.none, bg = c.bg1}, -- Screen-line at the cursor, when 'cursorline' is set
    CursorLineNr = {fg = c.purple, gui = bold},
    LineNr = {fg = c.coyote_brown},
    -- NOTE: Possibly change
    -- DiffAdded = fgs.green,
    -- DiffRemoved = fgs.red,
    -- DiffFile = fgs.aqua,
    -- DiffIndexLine = fgs.coyote_brown1,
    diffAdded = fgs.yellow,
    diffRemoved = fgs.red,
    diffChanged = fgs.blue,
    diffOldFile = fgs.green,
    diffNewFile = fgs.orange,
    diffFile = fgs.aqua,
    diffLine = fgs.coyote_brown1,
    diffIndexLine = fgs.purple,
    DiffAdd = {fg = c.none, bg = utils.darken(c.green, 0.6, c.bg0)}, -- diff mode: Added line |diff.txt|
    DiffChange = {fg = c.none, bg = c.diff_change}, -- diff mode: Changed line |diff.txt|
    DiffDelete = {fg = c.none, bg = utils.darken(c.red, 0.6, c.bg0)}, -- diff mode: Deleted line |diff.txt|
    -- DiffText = {fg = c.none, bg = utils.darken(c.blue, 0.6, c.bg0)}, -- diff mode: Changed text within a changed line |diff.txt|
    DiffText = {fg = c.none, bg = c.diff_text}, -- diff mode: Changed text within a changed line |diff.txt|
    DiffFile = {fg = c.aqua},
    Directory = {fg = c.bg5, bg = c.none}, -- directory names (and other special names in listings)
    ErrorMsg = {fg = c.red, gui = underbold},
    WarningMsg = {fg = c.green, gui = bold},
    ModeMsg = {fg = c.fg0, gui = bold},
    MoreMsg = {fg = c.green, gui = bold},
    MatchParen = {fg = c.none, bg = c.bg4},
    Substitute = {fg = c.bg0, bg = c.green},
    NonText = {fg = c.bg5},
    Whitespace = {fg = c.bg5},
    SpecialKey = {fg = c.bg5},
    Pmenu = {
        fg = c.operator_base05,
        bg = utils.tern(cfg.popup.background, c.bg0, c.bg1)
    },
    PmenuSel = {fg = c.red, bg = c.bg4, gui = bold},
    PmenuSbar = {fg = c.none, bg = c.fg3},
    PmenuThumb = {fg = c.none, bg = c.green},
    WildMenu = {fg = c.bg3, bg = c.green}, -- Current match in 'wildmenu' completion
    WinBar = {fg = c.fg0, gui = bold}, -- window bar of current window
    WinBarNC = {fg = c.bg4, gui = bold}, -- window bar of not-current windows
    Question = {fg = c.green},
    NormalFloat = {fg = c.fg1, bg = c.bg3}, -- Normal text in floating windows.
    TabLine = {fg = c.fg, bg = c.bg1}, -- Tab pages line, not active tab page label
    TabLineSel = {fg = c.bg0, bg = c.fg, gui = bold}, -- Tab pages line, active tab page label
    TabLineFill = {gui = "none"}, -- Tab pages line, where there are no labels
    -- When last status=2 or 3
    StatusLine = {fg = c.none, bg = c.none}, -- Status line of current window.
    StatusLineNC = {fg = c.coyote_brown1, bg = c.none}, -- Status lines of not-current windows
    StatusLineTerm = {fg = c.fg0, bg = c.bg2},
    StatusLineTermNC = {fg = c.coyote_brown1, bg = c.bg1},
    -- Spell
    SpellBad = {fg = c.red, gui = "undercurl", sp = c.red},
    SpellCap = {fg = c.blue, gui = undercurl, sp = c.blue},
    SpellLocal = {fg = c.aqua, gui = undercurl, sp = c.aqua},
    SpellRare = {fg = c.purple, gui = undercurl, sp = c.purple},
    Visual = {fg = c.black, bg = c.operator_base05, gui = reverse}, -- Visual mode selection
    VisualNOS = {fg = c.black, bg = c.operator_base05, gui = reverse}, -- Visual sel when vim is "Not Owning the Selection"
    QuickFixLine = {fg = c.purple, gui = bold},
    Debug = {fg = c.orange},
    debugPC = {fg = c.bg0, bg = c.green},
    debugBreakpoint = {fg = c.bg0, bg = c.red},
    ToolbarButton = {fg = c.bg0, bg = c.grullo_grey},
    FloatBorder = {fg = c.magenta},
    FloatermBorder = {fg = c.magenta}
}

hl.syntax = {
    Boolean = fgs.orange,
    Number = fgs.purple,
    Float = fgs.purple,
    PreProc = {fg = c.purple, gui = italic},
    PreCondit = {fg = c.purple, gui = italic},
    Include = {fg = c.purple, gui = italic},
    Define = {fg = c.purple, gui = italic},
    Conditional = {fg = c.purple, gui = italic},
    Repeat = {fg = c.purple, gui = italic},
    Keyword = {fg = c.red, gui = italic},
    Typedef = {fg = c.red, gui = italic},
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
    SpecialChar = fgs.green,
    Type = {fg = c.green, gui = bold},
    Function = {fg = c.magenta, gui = bold},
    String = fgs.yellow,
    Character = fgs.yellow,
    Constant = fgs.aqua,
    Macro = fgs.aqua,
    Identifier = fgs.blue,
    Delimiter = fgs.fg0,
    Ignore = fgs.coyote_brown1,
    Underlined = {fg = c.none, gui = "underline"},
    Comment = {fg = c.coyote_brown1, gui = italic}, -- any comment
    SpecialComment = {fg = c.coyote_brown1, gui = italic},
    Todo = {fg = c.purple, bg = c.none, gui = italic}
}

hl.treesitter = {
    -- TSEmphasis = { fg = c.fg, gui = "italic" },
    -- TSError = { fg = c.red, gui = italic },
    -- TSStrike = { fg = c.coyote_brown1, gui = "strikethrough" },
    -- TSStrong = { fg = c.fg, gui = "bold" },
    -- TSUnderline = { fg = c.fg, gui = "underline" },

    TSAnnotation = {fg = c.blue, gui = italic},
    TSAttribute = {fg = c.green, gui = italic}, -- Annotations attached to code to denote some meta info
    TSBoolean = fgs.orange, -- Boolean literals
    TSCharacter = fgs.yellow, -- Character literals
    TSCharacterSpecial = {link = "SpecialChar"}, -- Special characters
    TSComment = {fg = c.coyote_brown1, gui = italic}, -- Line comments and block comments
    TSConditional = {fg = c.purple, gui = italic},
    TSConstBuiltin = {fg = c.orange, gui = italic},
    TSConstMacro = {fg = c.orange, gui = italic},
    TSConstant = {fgs = c.green, gui = bold},
    TSConstructor = {fg = c.yellow, gui = bold},
    TSDanger = {fg = c.red, gui = bold},
    TSEnviroment = fgs.fg0,
    TSEnviromentName = fgs.fg0,
    TSException = {fg = c.red, gui = italic},
    TSField = fgs.aqua,
    TSFloat = fgs.purple,
    TSFuncBuiltin = {fg = c.magenta, gui = bold},
    TSFuncMacro = fgs.aqua,
    TSFunction = {fg = c.magenta, gui = bold},
    TSInclude = {fg = c.red, gui = italic},
    TSKeyword = fgs.red,
    TSKeywordFunction = fgs.red,
    TSKeywordOperator = fgs.red,
    TSLabel = fgs.orange,
    TSLiteral = fgs.green,
    TSMath = fgs.green,
    TSMethod = fgs.blue,
    TSNamespace = {fg = c.blue, gui = italic},
    TSNone = fgs.fg0,
    TSNote = {fg = c.blue, bg = c.bg0, gui = bold},
    TSNumber = fgs.purple,
    TSOperator = fgs.orange,
    TSParameter = fgs.fg0,
    TSParameterReference = fgs.fg0,
    TSProperty = fgs.yellow,
    TSPunctBracket = fgs.fg0,
    TSPunctDelimiter = fgs.coyote_brown1,
    TSPunctSpecial = fgs.green,
    TSRepeat = fgs.purple,
    TSStrike = fgs.coyote_brown1,
    TSString = fgs.yellow,
    TSStringEscape = fgs.philippine_green,
    TSStringRegex = fgs.orange,
    TSSymbol = fgs.fg0,
    TSTag = {fg = c.blue, gui = italic},
    TSTagDelimiter = fgs.magenta,
    TSText = fgs.yellow,
    TSTextReference = fgs.blue,
    TSTitle = {fg = c.orange, gui = "bold"}, -- Text that is part of a title
    TSType = fgs.green,
    TSTypeBuiltin = fgs.green,
    TSURI = {fg = c.fg1, gui = "underline"},
    TSVariable = fgs.fg0,
    TSVariableBuiltin = fgs.blue,
    TSWarning = {fg = c.green, gui = bold}
}

hl.langs08.treesitter = {
    ["@boolean"] = fgs.orange,
    ["@character"] = fgs.yellow,
    ["@character.special"] = {link = "SpecialChar"},
    ["@comment"] = {fg = c.coyote_brown1, gui = italic},
    ["@conditional"] = {fg = c.purple, gui = italic}, -- keywords related to conditionals (e.g. `if` / `else`)
    ["@constant"] = {fgs = c.green, gui = bold},
    ["@constant.builtin"] = {fg = c.orange, gui = italic},
    ["@constant.macro"] = {fg = c.orange, gui = italic},
    ["@constructor"] = {fg = c.wave_red, gui = bold},
    -- ["@debug"] = {}, -- keywords related to debugging
    ["@exception"] = {fg = c.red, gui = italic}, -- keywords related to exceptions (e.g. `throw` / `catch`)
    ["@field"] = fgs.aqua,
    ["@float"] = fgs.purple,
    ["@function"] = {fg = c.magenta, gui = bold},
    ["@function.call"] = {fg = c.magenta, gui = bold},
    ["@function.builtin"] = {fg = c.magenta, gui = bold},
    ["@function.macro"] = fgs.aqua,
    ["@include"] = {fg = c.red, gui = italic}, -- keywords for including modules (e.g. `import` / `from` in Python)
    ["@keyword"] = fgs.red,
    ["@keyword.function"] = fgs.red, -- keywords that define a function (e.g. `func` in Go, `def` in Python)
    ["@keyword.operator"] = fgs.red, -- operators that are English words (e.g. `and` / `or`)
    ["@keyword.return"] = {fg = c.red, gui = bold}, -- keywords like `return` and `yield`
    ["@label"] = fgs.orange, -- GOTO and other labels (e.g. `label:` in C)
    ["@method"] = fgs.blue,
    -- ["@method.call"] = {},
    ["@namespace"] = {fg = c.blue, gui = italic},
    ["@none"] = fgs.fg0,
    ["@number"] = fgs.purple,
    ["@operator"] = fgs.orange,
    ["@parameter"] = fgs.fg0,
    ["@parameter.reference"] = fgs.fg0,
    ["@property"] = fgs.yellow,
    ["@punctuation.bracket"] = fgs.fg0,
    ["@punctuation.delimiter"] = fgs.coyote_brown1,
    ["@punctuation.special"] = fgs.green,
    ["@repeat"] = fgs.purple, -- keywords related to loops (e.g. `for` / `while`)
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
    ["@text.annotation"] = {fg = c.blue, gui = italic}, -- NOTE: unsure
    ["@text.attribute"] = {fg = c.green, gui = italic}, -- NOTE: unsure
    ["@text.danger"] = {fg = c.red, gui = bold},
    ["@text.diff.add"] = {fg = c.none, bg = utils.darken(c.green, 0.6, c.bg0)},
    ["@text.diff.delete"] = {fg = c.none, bg = utils.darken(c.red, 0.6, c.bg0)},
    ["@text.environment"] = fgs.fg0,
    ["@text.environment.name"] = fgs.fg0,
    ["@text.literal"] = fgs.green,
    ["@text.math"] = fgs.green,
    ["@text.note"] = {fg = c.blue, bg = c.bg0, gui = bold},
    ["@text.reference"] = fgs.blue,
    ["@text.strike"] = fgs.coyote_brown1,
    ["@text.strong"] = {fg = c.none, gui = "bold"},
    ["@text.title"] = {fg = c.orange, gui = "bold"}, -- Text that is part of a title
    ["@text.todo"] = {fg = c.red, gui = bold},
    ["@text.underline"] = {fg = c.none, gui = "underline"},
    ["@text.uri"] = {fg = c.fg1, gui = "underline"},
    ["@text.warning"] = {fg = c.green, gui = bold},
    ["@type"] = fgs.green,
    ["@type.builtin"] = fgs.green,
    -- ["@type.definition"] = fgs.green,
    ["@type.qualifier"] = fgs.red,
    ["@variable"] = fgs.fg0,
    ["@variable.builtin"] = fgs.blue

    -- ["@preproc"] = {},
    -- ["@define"] = {},
    -- ["@conceal"] = {},
    -- ["@spell"] = {}
}

hl.langs.comment = {
    -- commentTSTag = {fg = c.old_rose},
    commentTSTag = {fg = c.amethyst},
    commentTSConstant = {fg = c.yellow}
}

hl.langs08.comment = {
    ["@tag.comment"] = {fg = c.peach_red},
    ["@constant.comment"] = {fg = c.amethyst}
}

hl.langs.solidity = {
    -- Regex parsing
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
    --
    -- Treesitter
    --
    solidityTSFunction = {fg = c.magenta, gui = bold},
    solidityTSKeyword = fgs.orange,
    solidityTSType = {fg = c.green, gui = bold},
    solidityTSTag = {fg = c.blue, gui = bold},
    solidityTSMethod = {fg = c.magenta, gui = bold},
    solidityTSField = fgs.aqua
}

hl.langs08.solidity = {
    ["@function.solidity"] = {fg = c.magenta, gui = bold},
    ["@keyword.solidity"] = fgs.orange,
    ["@type.solidity"] = {fg = c.green, gui = bold},
    ["@tag.solidity"] = {fg = c.blue, gui = bold},
    ["@method.solidity"] = {fg = c.magenta, gui = bold},
    ["@method.call.solidity"] = {fg = c.magenta, gui = bold},
    ["@field.solidity"] = fgs.aqua
}

hl.langs.help = {
    helpTSTitle = fgs.red,
    helpTSLabel = fgs.blue,
    helpTSString = fgs.yellow,
    helpTSURI = {fg = c.fg1, gui = "underline"}
}

hl.langs08.help = {
    ["@text.title.help"] = fgs.red,
    ["@label.help"] = fgs.blue,
    ["@string.help"] = fgs.yellow,
    ["@text.uri.help"] = {fg = c.fg1, gui = "underline"}
}

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
    markdownIdDeclaration = fgs.puprle
}

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
    --
    -- Treesitter
    --
    latexTSInclude = fgs.blue,
    latexTSFuncMacro = {fg = c.fg0, gui = bold},
    latexTSEnvironment = {fg = c.cyan, gui = "bold"},
    latexTSEnvironmentName = fgs.yellow,
    latexTSTitle = fgs.green,
    latexTSType = fgs.blue,
    latexTSMath = fgs.orange
}

hl.langs08.tex = {
    ["@include.latex"] = fgs.blue,
    ["@function.macro.latex"] = {fg = c.green, gui = bold},
    ["@text.environment.latex"] = {fg = c.cyan, gui = "bold"},
    ["@text.environment.name.latex"] = fgs.yellow,
    ["@text.title.latex"] = fgs.green,
    ["@text.math.latex"] = fgs.orange,
    ["@type.latex"] = fgs.blue
}

hl.langs.javascript = {
    -- Javascript:
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
    -- yajs: https://github.com/othree/yajs.vim,
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
    -- JavaScript React:
    -- vim-jsx-pretty: https://github.com/maxmellon/vim-jsx-pretty
    jsxTagName = {fg = c.orange, gui = italic},
    jsxTag = {fg = c.purple, gui = bold},
    jsxOpenPunct = fgs.yellow,
    jsxClosePunct = fgs.blue,
    jsxEscapeJs = fgs.blue,
    jsxAttrib = fgs.green,
    jsxCloseTag = {fg = c.aqua, gui = bold},
    jsxComponentName = {fg = c.blue, gui = bold},
    --
    -- Treesitter
    --
    javascriptTSParameter = fgs.aqua,
    javascriptTSTypeBuiltin = {fg = c.green, gui = bold},
    javascriptTSKeywordReturn = {fg = c.red, gui = bold},
    javascriptTSPunctBracket = fgs.purple,
    javascriptTSPunctSpecial = fgs.green,
    javascriptTSVariableBuiltin = fgs.blue,
    javascriptTSException = fgs.orange,
    javascriptTSConstructor = {fg = c.green, gui = bold},
    javascriptTSProperty = fgs.aqua,
    javascriptTSMethod = {fg = c.magenta, gui = bold},
    javascriptTSKeyword = fgs.red
}

hl.langs08.javascript = {
    ["@parameter.javascript"] = fgs.aqua,
    ["@type.builtin.javascript"] = {fg = c.green, gui = bold},
    ["@keyword.return.javascript"] = {fg = c.red, gui = bold},
    ["@punctuation.bracket.javascript"] = fgs.purple,
    ["@punctuation.special.javascript"] = fgs.green,
    ["@variable.builtin.javascript"] = fgs.blue,
    ["@exception.javascript"] = fgs.orange,
    ["@constructor.javascript"] = {fg = c.green, gui = bold},
    ["@property.javascript"] = fgs.aqua,
    ["@method.javascript"] = {fg = c.magenta, gui = bold},
    ["@method.call.javascript"] = {fg = c.magenta, gui = bold},
    ["@keyword.javascript"] = fgs.red
}

hl.langs.typescript = {
    -- TypeScript:
    -- vim-typescript: https://github.com/leafgarland/typescript-vim
    typescriptSource = {fg = c.purple, gui = italic},
    typescriptMessage = fgs.green,
    typescriptGlobalObjects = fgs.aqua,
    typescriptInterpolation = fgs.green,
    typescriptInterpolationDelimiter = fgs.green,
    typescriptTypeBrackets = fgs.purple,
    typescriptBraces = fgs.purple,
    typescriptParens = fgs.purple,
    -- yats: https:github.com/HerringtonDarkholme/yats.vim
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
    --
    -- Treesitter
    --
    typescriptTSParameter = fgs.aqua,
    typescriptTSTypeBuiltin = {fg = c.green, gui = bold},
    typescriptTSKeywordReturn = {fg = c.red, gui = bold},
    typescriptTSPunctBracket = fgs.purple,
    typescriptTSPunctSpecial = fgs.green,
    typescriptTSPunctDelimiter = fgs.purple,
    typescriptTSVariableBuiltin = fgs.blue,
    typescriptTSException = fgs.orange,
    typescriptTSConstructor = {fg = c.wave_red, gui = bold},
    typescriptTSProperty = fgs.aqua,
    typescriptTSMethod = {fg = c.magenta, gui = bold},
    typescriptTSKeyword = fgs.red
}

hl.langs08.typescript = {
    ["@parameter.typescript"] = fgs.aqua,
    ["@type.builtin.typescript"] = {fg = c.green, gui = bold},
    ["@keyword.return.typescript"] = {fg = c.red, gui = bold},
    ["@punctuation.bracket.typescript"] = fgs.purple,
    ["@punctuation.special.typescript"] = fgs.green,
    ["@punctuation.delimiter.typescript"] = fgs.purple,
    ["@variable.builtin.typescript"] = fgs.blue,
    ["@exception.typescript"] = fgs.orange,
    ["@constructor.typescript"] = {fg = c.wave_red, gui = bold},
    ["@property.typescript"] = fgs.aqua,
    ["@method.typescript"] = {fg = c.magenta, gui = bold},
    ["@method.call.typescript"] = {fg = c.magenta, gui = bold},
    ["@keyword.typescript"] = fgs.red
}

hl.langs.tsx = {
    tsxTSMethod = {fg = c.magenta, gui = bold},
    tsxTSConstructor = {fg = c.wave_red, gui = bold},
    tsxTSProperty = fgs.aqua,
    tsxTSPunctBracket = fgs.purple,
    tsxTSTagAttribute = fgs.aqua,
    tsxTSTag = {fg = c.orange, gui = italic},
    tsxTSVariableBuiltin = fgs.blue,
    tsxTSException = fgs.orange

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
    ["@exception.tsx"] = fgs.orange
}

hl.langs.graphql = {
    graphqlParameter = fgs.blue,
    graphqlVariable = {fg = c.magenta, gui = bold},
    graphqlProperty = fgs.aqua
}

hl.langs08.graphql = {
    ["@parameter.graphql"] = fgs.blue,
    ["@variable.graphql"] = {fg = c.magenta, gui = bold},
    ["@property.graphql"] = fgs.aqua
}

hl.langs.css = {
    cssAtRule = fgs.red,
    -- Treesitter
    cssTSProperty = fgs.orange,
    cssTSKeyword = fgs.red,
    cssTSType = {fg = c.red, gui = bold}
}

hl.langs08.css = {
    ["@property.css"] = fgs.orange,
    ["@keyword.css"] = fgs.red,
    ["@type.css"] = {fg = c.red, gui = bold}
}

hl.langs.scss = {
    -- scssAtRule = fgs.red,
    -- Treesitter
    scssTSProperty = fgs.orange,
    scssTSVariable = fgs.blue,
    scssTSString = fgs.yellow,
    scssTSKeyword = fgs.red,
    scssTSRepeat = fgs.purple,
    scssTSType = {fg = c.red, gui = bold},
    scssTSPunctDelimiter = fgs.aqua
}

hl.langs08.scss = {
    ["@property.scss"] = fgs.orange,
    ["@variable.scss"] = fgs.blue,
    ["@string.scss"] = fgs.yellow,
    ["@keyword.scss"] = fgs.red,
    ["@repeat.scss"] = fgs.purple,
    ["@type.scss"] = {fg = c.red, gui = bold},
    ["@punctuation.delimiter.scss"] = fgs.aqua
}

hl.langs.dart = {
    -- Dart:
    -- dart-lang: https://github.com/dart-lang/dart-vim-plugin
    dartCoreClasses = fgs.aqua,
    dartTypeName = fgs.aqua,
    dartInterpolation = fgs.blue,
    dartTypeDef = {fg = c.red, gui = italic},
    dartClassDecl = {fg = c.red, gui = italic},
    dartLibrary = {fg = c.purple, gui = italic},
    dartMetadata = fgs.blue
}

hl.langs.coffeescript = {
    -- CoffeeScript:
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
    coffeeObjAssign = fgs.aqua
}

hl.langs.html = {
    htmlTSTagAttribute = {fg = c.green, gui = bold},
    htmlTSText = fgs.fg0,
    htmlTSTag = {fg = c.red, gui = bold},
    htmlTSTagDelimiter = {fg = c.magenta, gui = bold}
}

hl.langs08.html = {
    ["@tag.attribute.html"] = {fg = c.green, gui = bold},
    ["@text.html"] = fgs.fg0,
    ["@tag.html"] = {fg = c.red, gui = bold},
    ["@tag.delimiter.html"] = {fg = c.magenta, gui = bold}
}

hl.langs.objectivec = {
    objcModuleImport = {fg = c.purple, gui = italic},
    objcException = {fg = c.red, gui = italic},
    objcProtocolList = fgs.aqua,
    objcObjDef = {fg = c.purple, gui = italic},
    objcDirective = {fg = c.red, gui = italic},
    objcPropertyAttribute = fgs.orange,
    objcHiddenArgument = fgs.aqua
}

hl.langs.python = {
    pythonBuiltin = fgs.green,
    pythonExceptions = fgs.purple,
    pythonDecoratorName = fgs.blue,
    -- python-syntax: https://github.com/vim-python/python-syntax,
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
    -- semshi: https://github.com/numirias/semshi,
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
    --
    -- Treesitter
    --
    pythonTSType = {fg = c.green, gui = bold},
    pythonTSConstructor = fgs.magenta,
    pythonTSKeywordFunction = {fg = c.red, gui = bold},
    pythonTSConstBuiltin = fgs.purple,
    pythonTSMethod = {fg = c.purple, gui = bold},
    pythonTSParameter = fgs.orange,
    pythonTSConstant = fgs.aqua,
    pythonTSField = fgs.fg0,
    pythonTSStringEscape = fgs.green,
    pythonTSPunctBracket = fgs.purple
    -- pythonTSParameter = fgs.orange,
    -- pythonTSPunctBracket = fgs.green,
    -- pythonTSPunctBracket = fgs.fg0,
}

hl.langs08.python = {
    ["@type.python"] = {fg = c.green, gui = bold},
    ["@constructor.python"] = fgs.magenta,
    ["@keyword.function.python"] = {fg = c.red, gui = bold},
    ["@constant.builtin.python"] = fgs.purple,
    ["@method.python"] = {fg = c.purple, gui = bold},
    ["@method.call.python"] = {fg = c.magenta, gui = bold},
    ["@parameter.python"] = fgs.orange,
    ["@constant.python"] = {fg = c.aqua, gui = bold},
    ["@field.python"] = fgs.aqua,
    ["@string.escape.python"] = fgs.green,
    ["@punctuation.bracket.python"] = fgs.purple
}

hl.langs.kotlin = {
    -- Kotlin:
    -- kotlin-vim: https://github.com/udalov/kotlin-vim
    ktSimpleInterpolation = fgs.green,
    ktComplexInterpolation = fgs.green,
    ktComplexInterpolationBrace = fgs.green,
    ktStructure = {fg = c.red, gui = italic},
    ktKeyword = fgs.aqua
}

hl.langs.scala = {
    -- Scala:
    -- vim-scala: https://github.com/derekwyatt/vim-scala
    scalaNameDefinition = fgs.aqua,
    scalaInterpolationBoundary = fgs.green,
    scalaInterpolation = fgs.blue,
    scalaTypeOperator = fgs.orange,
    scalaOperator = fgs.orange,
    scalaKeywordModifier = fgs.orange
}

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
    --
    -- Treesitter
    --
    goTSProperty = fgs.blue,
    goTSMethod = {fg = c.purple, gui = bold},
    goTSType = {fg = c.green, gui = bold},
    goTSTypeBuiltin = {fg = c.green, gui = bold},
    goTSPunctBracket = fgs.purple
}

hl.langs08.go = {
    ["@property.go"] = fgs.blue,
    ["@method.go"] = {fg = c.purple, gui = bold},
    ["@method.call.go"] = {fg = c.magenta, gui = bold},
    ["@type.go"] = {fg = c.green, gui = bold},
    ["@type.builtin.go"] = {fg = c.green, gui = bold},
    ["@punctuation.bracket.go"] = fgs.purple
}

hl.langs.rust = {
    -- Rust:
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
    --
    -- Treesitter
    --
    rustTSConstBuiltin = fgs.purple,
    rustTSConstant = fgs.magenta,
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
    rustTSVariableBuiltin = fgs.blue
}

hl.langs08.rust = {
    ["@constant.builtin.rust"] = fgs.purple,
    ["@constant.rust"] = fgs.magenta,
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
    ["@variable.builtin.rust"] = fgs.blue
}

hl.langs.swift = {
    -- Swift:
    -- swift.vim: https://github.com/keith/swift.vim
    swiftInterpolatedWrapper = fgs.green,
    swiftInterpolatedString = fgs.blue,
    swiftProperty = fgs.aqua,
    swiftTypeDeclaration = fgs.orange,
    swiftClosureArgument = fgs.purple
}

hl.langs.php = {
    -- PHP:
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
    phpRegion = fgs.blue
}

hl.langs.ruby = {
    -- Ruby:
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
    --
    -- Treesitter
    --
    rubyTSLabel = fgs.blue,
    rubyTSString = fgs.yellow,
    rubyTSPunctSpecial = fgs.green,
    rubyTSPunctBracket = fgs.green,
    rubyTSParameter = fgs.orange,
    rubyTSSymbol = fgs.aqua,
    rubyTSNone = fgs.blue,
    rubyTSType = {fg = c.green, gui = bold}
}

hl.langs08.ruby = {
    ["@label.ruby"] = fgs.blue,
    ["@string.ruby"] = fgs.yellow,
    ["@punctuation.special.ruby"] = fgs.green,
    ["@punctuation.bracket.ruby"] = fgs.green,
    ["@parameter.ruby"] = fgs.orange,
    ["@symbol.ruby"] = fgs.aqua,
    ["@none.ruby"] = fgs.blue,
    ["@type.ruby"] = {fg = c.green, gui = bold}
}

hl.langs.haskell = {
    -- Haskell:
    -- haskell-vim: https://github.com/neovimhaskell/haskell-vim
    haskellBrackets = fgs.blue,
    haskellIdentifier = fgs.green,
    haskellAssocType = fgs.aqua,
    haskellQuotedType = fgs.aqua,
    haskellType = fgs.aqua,
    haskellDeclKeyword = {fg = c.red, gui = italic},
    haskellWhere = {fg = c.red, gui = italic},
    haskellDeriving = {fg = c.purple, gui = italic},
    haskellForeignKeywords = {fg = c.purple, gui = italic}
}

hl.langs.perl = {
    -- Perl:
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
    --
    -- Treesitter
    --
    perlTSVariable = fgs.blue
}

hl.langs08.perl = {
    ["@variable.perl"] = fgs.blue
}

hl.langs.luap = {
    luapTSPunctSpecial = fgs.green,
    luapTSPunctBracket = fgs.blue,
    luapTSOperator = fgs.orange,
    luapTSKeyword = fgs.red
}

hl.langs08.luap = {
    ["@punctuation.special.luap"] = fgs.green,
    ["@punctuation.bracket.luap"] = fgs.blue,
    ["@operator.luap"] = fgs.orange,
    ["@keyword.luap"] = fgs.red
}

hl.langs.lua = {
    -- When cursorholding
    luaFuncTable = {fg = c.red, gui = bold},
    --
    -- Treesitter
    --
    luaTSProperty = fgs.green,
    luaTSField = fgs.aqua,
    luaTSPunctBracket = fgs.purple,
    luaTSConstructor = {fg = c.green, gui = bold},
    luaTSConstant = {fg = c.green, gui = bold},
    luaTSConstantBuiltin = fgs.orange,
    luaTSKeywordFunction = fgs.red,
    luaTSMethod = fgs.blue,
    luaTSFunctionBuiltin = {fg = c.magenta, gui = bold}
}

hl.langs08.lua = {
    ["@property.lua"] = fgs.green,
    ["@field.lua"] = fgs.aqua,
    ["@punctuation.bracket.lua"] = fgs.purple,
    ["@constructor.lua"] = {fg = c.green, gui = bold},
    ["@constant.lua"] = {fg = c.green, gui = bold},
    ["@constant.builtin.lua"] = fgs.orange,
    ["@keyword.function.lua"] = fgs.red,
    ["@function.builtin"] = {fg = c.magenta, gui = bold},
    ["@method.lua"] = fgs.blue
}

hl.langs.teal = {
    tealTSOperator = fgs.orange, -- when not and as are not considered operators, i think it'd be better
    tealTSParameter = fgs.aqua,
    tealTSPunctBracket = fgs.purple,
    tealTSFunction = {fg = c.magenta, gui = bold},
    tealTSConstant = {fg = c.wave_red, gui = bold}
}

hl.langs08.teal = {
    ["@operator.teal"] = fgs.orange,
    ["@parameter.teal"] = fgs.aqua,
    ["@punctuation.bracket.teal"] = fgs.purple,
    ["@function.teal"] = {fg = c.magenta, gui = bold},
    ["@constant.teal"] = {fg = c.wave_red, gui = bold}
}

hl.langs.ocaml = {
    -- OCaml:
    -- builtin: https://github.com/rgrinberg/vim-ocaml
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
    ocamlModParam1 = fgs.blue
}

hl.langs.erlang = {
    -- Erlang:
    -- builtin: https://github.com/vim-erlang/vim-erlang-runtime
    erlangAtom = fgs.aqua,
    erlangLocalFuncRef = {fg = c.yellow, gui = bold},
    erlangLocalFuncCall = {fg = c.yellow, gui = bold},
    erlangGlobalFuncRef = {fg = c.yellow, gui = bold},
    erlangGlobalFuncCall = {fg = c.yellow, gui = bold},
    erlangAttribute = {fg = c.purple, gui = italic},
    erlangPipe = fgs.orange
}

hl.langs.elixir = {
    -- Elixir:
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
    elixirExUnitMacro = {fg = c.red, gui = italic}
}

hl.langs.clojure = {
    -- Clojure:
    -- builtin: https://github.com/guns/vim-clojure-static
    clojureMacro = {fg = c.purple, gui = italic},
    clojureFunc = {fg = c.aqua, gui = bold},
    clojureConstant = fgs.green,
    clojureSpecial = {fg = c.red, gui = italic},
    clojureDefine = {fg = c.red, gui = italic},
    clojureKeyword = fgs.orange,
    clojureVariable = fgs.blue,
    clojureMeta = fgs.green,
    clojureDeref = fgs.green
}

hl.langs.r = {
    rFunction = {fg = c.purple, gui = bold},
    rType = {fg = c.green, gui = bold},
    rRegion = {fg = c.purple, gui = bold},
    rAssign = {fg = c.red, gui = bold},
    rBoolean = fgs.orange,
    rOperator = fgs.orange,
    rSection = fgs.orange,
    rRepeat = fgs.purple
}

hl.langs.matlab = {
    matlabSemicolon = fgs.fg0,
    matlabFunction = {fg = c.red, gui = italic},
    matlabImplicit = {fg = c.yellow, gui = bold},
    matlabDelimiter = fgs.fg0,
    matlabOperator = {fg = c.yellow, gui = bold},
    matlabArithmeticOperator = fgs.orange,
    matlabRelationalOperator = fgs.orange,
    matlabLogicalOperator = fgs.orange
}

hl.langs.vim = {
    -- vimMapModKey = fgs.orange,
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
    vimSetSep = fgs.coyote_brown,
    vimContinue = fgs.coyote_brown1,
    -- Non-treesitter Vim looks much better IMO
    --
    -- Treesitter
    --
    vimTSKeyword = {fg = c.red, gui = bold},
    vimTSNamespace = {fg = c.blue, gui = bold},
    vimTSFunction = {fg = c.magenta, gui = bold}
}

hl.langs08.vim = {
    ["@keyword.vim"] = {fg = c.red, gui = bold},
    ["@namespace.vim"] = {fg = c.blue, gui = bold},
    ["@function.vim"] = {fg = c.magenta, gui = bold}
}

hl.langs.c = {
    cInclude = fgs.blue,
    cStorageClass = fgs.purple,
    cTypedef = fgs.purple,
    cDefine = fgs.aqua,
    --
    -- Treesitter
    --
    -- cTSInclude = fgs.blue,
    -- cTSFuncMacro = fgs.yellow,
    cTSInclude = fgs.red,
    cTSConstant = fgs.aqua,
    cTSConstMacro = fgs.orange,
    cTSOperator = fgs.orange,
    cTSRepeat = fgs.blue,
    cTSType = {fg = c.green, gui = bold},
    cTSPunctBracket = fgs.purple
}

hl.langs08.c = {
    ["@include.c"] = fgs.red,
    ["@constant.c"] = fgs.aqua,
    ["@constant.macro.c"] = fgs.orange,
    ["@operator.c"] = fgs.orange,
    ["@repeat.c"] = fgs.blue,
    ["@type.c"] = {fg = c.green, gui = bold},
    ["@punctuation.bracket.c"] = fgs.purple
}

hl.langs.cpp = {
    cppStatement = {fg = c.purple, gui = bold},
    --
    -- Treesitter
    --
    cppTSConstant = fgs.aqua,
    cppTSOperator = fgs.purple,
    cppTSConstMacro = fgs.aqua,
    cppTSNamespace = fgs.orange,
    cppTSType = {fg = c.green, gui = bold},
    cppTSTypeBuiltin = {fg = c.green, gui = bold},
    cppTSKeyword = fgs.red,
    cppTSInclude = {fg = c.red, gui = italic},
    cppTSMethod = fgs.blue,
    cppTSField = fgs.yellow,
    cppTSConstructor = fgs.blue
}

hl.langs08.cpp = {
    ["@constant.cpp"] = fgs.aqua,
    ["@operator.cpp"] = fgs.purple,
    ["@constant.macro.cpp"] = fgs.aqua,
    ["@namespace.cpp"] = fgs.orange,
    ["@type.cpp"] = {fg = c.green, gui = bold},
    ["@type.builtin.cpp"] = {fg = c.green, gui = bold},
    ["@keyword.cpp"] = fgs.red,
    ["@include.cpp"] = {fg = c.red, gui = italic},
    ["@method.cpp"] = fgs.blue,
    ["@method.call.cpp"] = {fg = c.magenta, gui = bold},
    ["@field.cpp"] = fgs.yellow,
    ["@constructor.cpp"] = fgs.blue
}

hl.langs.shell = {
    shRange = fgs.fg0,
    shTestOpr = fgs.orange,
    shOption = fgs.orange,
    bashStatement = fgs.orange,
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
    --
    -- Treesitter
    --
    bashTSFuncBuiltin = fgs.red,
    bashTSParameter = fgs.green,
    bashTSConstant = fgs.blue,
    bashTSPunctSpecial = fgs.aqua,
    bashTSVariable = fgs.blue
}

hl.langs08.shell = {
    ["@function.builtin.bash"] = fgs.red,
    ["@parameter.bash"] = fgs.green,
    ["@constant.bash"] = fgs.blue,
    ["@punctuation.special.bash"] = fgs.aqua,
    ["@variable.bash"] = fgs.blue
}

hl.langs.zsh = {
    zshOptStart = {fg = c.purple, gui = italic},
    zshOption = fgs.blue,
    zshSubst = fgs.green,
    zshFunction = {fg = c.purple, gui = bold},
    zshDeref = fgs.blue,
    zshTypes = fgs.orange,
    zshVariableDef = fgs.blue,
    zshNumber = fgs.purple,
    zshCommand = {fg = c.red, gui = bold},
    -- zshFlag = fgs.yellow,
    zshSubstDelim = fgs.purple
}

hl.langs.zig = {
    zigTSTypeBuiltin = {fg = c.green, gui = bold},
    zigTSField = fgs.aqua,
    zigTSFuncMacro = fgs.aqua,
    zigTSAttribute = fgs.aqua,
    zigTSPunctBracket = fgs.orange
}

hl.langs08.zig = {
    ["@type.builtin.zig"] = {fg = c.green, gui = bold},
    ["@field.zig"] = fgs.aqua,
    ["@function.macro.zig"] = fgs.aqua,
    ["@attribute.zig"] = fgs.aqua,
    ["@punctuation.bracket.zig"] = fgs.orange
}

-- ========================== Config Formats ==========================

hl.langs.dosini = {
    dosiniLabel = fgs.yellow,
    dosiniValue = fgs.green,
    dosiniNumber = fgs.purple,
    dosiniHeader = {fg = c.red, gui = bold}
}

hl.langs.makefile = {
    makeIdent = fgs.aqua,
    makeSpecTarget = fgs.green,
    makeTarget = fgs.blue,
    makeCommands = fgs.orange
}

hl.langs.json = {
    jsonKeyword = fgs.orange,
    jsonQuote = fgs.coyote_brown1,
    jsonBraces = fgs.fg0
}

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
    --
    -- Treesitter
    --
    yamlTSField = fgs.green
}

hl.langs08.yaml = {
    ["@field.yaml"] = fgs.green
}

hl.langs.toml = {
    tomlTable = {fg = c.purple, gui = bold},
    tomlKey = fgs.orange,
    tomlBoolean = fgs.aqua,
    tomlTableArray = {fg = c.purple, gui = bold},
    tomlKeyValueArray = {fg = c.purple, gui = bold},
    --
    -- Treesitter
    --
    tomlTSProperty = fgs.orange
}

hl.langs08.toml = {
    ["@property.toml"] = fgs.orange
}

hl.langs.sxhkdrc = {
    sxhkdrcTSVariable = fgs.blue,
    sxhkdrcTSPunctuationBracket = fgs.green
}

hl.langs08.sxhkdrc = {
    ["@variable.sxhkdrc"] = fgs.blue,
    ["@punctuation.bracket.sxhkdrc"] = fgs.green
}

hl.langs.ron = {
    ronIdentifier = fgs.green,
    ronKey = fgs.red,
    ronInteger = fgs.purple,
    ronString = fgs.yellow,
    ronBoolean = fgs.orange
}

hl.langs.gitignore = {
    gitignoreTSPunctDelimiter = {fg = c.blue, gui = bold},
    gitignoreTSPunctBracket = {fg = c.magenta, gui = bold},
    gitignoreTSOperator = {fg = c.orange, gui = bold}
}

hl.langs08.gitignore = {
    ["@punctuation.delimiter.gitignore"] = {fg = c.blue, gui = bold},
    ["@punctuation.bracket.gitignore"] = {fg = c.magenta, gui = bold},
    ["@operator.gitignore"] = {fg = c.orange, gui = bold}
}

hl.langs.gitcommit = {
    gitcommitSummary = fgs.red,
    gitcommitUntracked = fgs.coyote_brown1,
    gitcommitDiscarded = fgs.coyote_brown1,
    gitcommitSelected = fgs.coyote_brown1,
    gitcommitUnmerged = fgs.coyote_brown1,
    gitcommitOnBranch = fgs.coyote_brown1,
    gitcommitArrow = fgs.coyote_brown1,
    gitcommitFile = fgs.yellow
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
        fg = c.red
    },
    DiagnosticVirtualTextWarn = {
        bg = utils.tern(cfg.diagnostics.background, utils.darken(c.yellow, 0.1, c.bg0), c.none),
        fg = c.yellow
    },
    DiagnosticVirtualTextInfo = {
        bg = utils.tern(cfg.diagnostics.background, utils.darken(c.aqua, 0.1, c.bg0), c.none),
        fg = c.aqua
    },
    DiagnosticVirtualTextHint = {
        bg = utils.tern(cfg.diagnostics.background, utils.darken(c.purple, 0.1, c.bg0), c.none),
        fg = c.purple
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
    LspCodeLens = fgs.coyote_brown1
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

hl.plugins.lsp_trouble = {
    LspTroubleText = {fg = c.fg0},
    LspTroubleCount = {fg = c.blue},
    LspTroubleNormal = {fg = c.magenta}
}

hl.plugins.lsp_saga = {
    -- LspFloatWinNormal = {bg = c.bg_float},
    -- LspSagaFinderSelection = {fg = c.bg_visual},
    LspFloatWinBorder = {fg = c.magenta},
    LspSagaBorderTitle = {fg = c.cyan},
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
    TargetWord = {fg = c.cyan}
}

hl.plugins.cmp = {
    CmpItemAbbr = fgs.fg0,
    CmpItemAbbrDeprecated = fgs.fg0,
    CmpItemAbbrMatch = fgs.aqua,
    CmpItemAbbrMatchFuzzy = {fg = c.cyan, gui = underline},
    CmpItemMenu = fgs.grey,
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
    CmpItemKindVariable = fgs.purple
}

hl.plugins.coc = {
    -- CocSnippetVisual = {bg = c.bg4}, -- highlight snippet placeholders
    CocHoverRange = {fg = c.none, gui = underbold}, -- range of current hovered symbol
    CocHighlightText = {bg = c.fg2}, -- Coc cursorhold event
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
    -- Change once this actually works
    CocInlayHint = fgs.amethyst, -- Things like Rust Analyzer (links to CocHintSign)
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
    CocSearch = fgs.orange, -- for matched input characters
    CocDisabled = {fg = c.grullo_grey},
    CocFadeOut = {fg = c.wenge_grey}, -- faded text (i.e., not used) CocUnusedHighlight CocDeprecatedHighlight
    CocCursorRange = {fg = c.bg1, bg = c.light_red},
    CocMenuSel = {fg = c.none, bg = c.bg1}, -- current menu item in menu dialog
    CocCodeLens = fgs.coyote_brown1,
    -- Popup Menu --
    CocPumSearch = {fg = c.orange}, -- for menu of complete items
    CocPumMenu = {fg = c.fg1}, -- items at the end like [LS]
    CocPumDeprecated = fgs.red,
    CocPumVirtualText = {fg = c.coyote_brown1},
    -- Tree --
    CocTreeTitle = {fg = c.red, gui = "bold"},
    -- Notification --
    CocNotificationProgress = {fg = c.blue, bg = "none"},
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
    CocSuggestFloating = {fg = c.fg0, bg = c.bg3} -- bg0
}

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
    ALEVirtualTextStyleWarning = fgs.coyote_brown1
}

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
    NeomakeVirtualtextMessag = fgs.coyote_brown1
}

-- https://github.com/b0o/incline.nvim
hl.plugins.incline = {
    InclineNormal = {link = "WinBar"},
    InclineNormalNC = {link = "WinBarNC"}
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
    VistaLineNr = fgs.fg0
}

hl.plugins.gitgutter = {
    GitGutterAdd = {fg = c.yellow, gui = bold},
    GitGutterChange = {fg = c.blue, gui = bold},
    GitGutterDelete = {fg = c.red, gui = bold},
    GitGutterChangeDelete = {fg = c.purple, gui = bold},
    GitGutterAddLineNr = fgs.green,
    GitGutterChangeLineNr = fgs.blue,
    GitGutterDeleteLineNr = fgs.red,
    GitGutterChangeDeleteLineNr = fgs.purple
}

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
    NERDTreeLinkTarget = fgs.yellow
}

hl.plugins.easymotion = {
    EasyMotionTarget = {fg = c.bg0, bg = c.green},
    EasyMotionShade = fgs.coyote_brown1
}

hl.plugins.startify = {
    StartifyBracket = fgs.coyote_brown1,
    StartifyFile = fgs.fg0,
    StartifyNumber = fgs.red,
    StartifyPath = fgs.yellow,
    StartifySlash = fgs.yellow,
    StartifySection = fgs.blue,
    StartifyHeader = fgs.orange,
    StartifySpecial = fgs.coyote_brown1,
    StartifyFooter = fgs.coyote_brown1
}

hl.plugins.whichkey = {
    WhichKey = fgs.red,
    WhichKeySeperator = fgs.yellow,
    WhichKeyGroup = fgs.green,
    WhichKeyDesc = fgs.blue,
    WhichKeyFloat = {link = "NormalFloat"},
    WhichKeyValue = {fg = c.coyote_brown1, gui = italic} -- any comment
}

hl.plugins.defx = {
    DefxIconsParentDirectory = fgs.orange,
    Defx_filename_directory = fgs.blue,
    Defx_filename_root = fgs.red
}

hl.plugins.floaterm = {
    Floaterm = {fg = c.none, bg = c.bg0},
    FloatermBorder = {fg = c.magenta, bg = c.none}
}

hl.plugins.vimwiki = {
    VimwikiBold = {fg = c.burple, gui = "bold"},
    VimwikiCode = {fg = c.puce},
    VimwikiItalic = {fg = "#83a598", gui = "italic"},
    VimwikiHeader1 = {fg = "#F14A68", gui = "bold"},
    VimwikiHeader2 = {fg = "#F06431", gui = "bold"},
    VimwikiHeader3 = {fg = "#689d6a", gui = "bold"},
    VimwikiHeader4 = {fg = c.green, gui = "bold"},
    VimwikiHeader5 = {fg = c.purple, gui = "bold"},
    VimwikiHeader6 = {fg = "#458588", gui = "bold"}
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
    AerialTypeParameterIcon = {link = "Type"}
}

hl.plugins.diffview = {
    DiffviewFilePanelTitle = {fg = c.blue, gui = bold},
    DiffviewFilePanelCounter = {fg = c.purple, gui = bold},
    DiffviewFilePanelFileName = fgs.fg0,
    DiffviewNormal = hl.common.Normal,
    DiffviewCursorLine = hl.common.CursorLine,
    DiffviewVertSplit = hl.common.VertSplit,
    DiffviewSignColumn = hl.common.SignColumn,
    DiffviewStatusLine = hl.common.StatusLine,
    DiffviewStatusLineNC = hl.common.StatusLineNC,
    DiffviewEndOfBuffer = hl.common.EndOfBuffer,
    DiffviewFilePanelRootPath = fgs.coyote_brown1,
    DiffviewFilePanelPath = fgs.coyote_brown1,
    DiffviewFilePanelInsertions = fgs.green,
    DiffviewFilePanelDeletions = fgs.red,
    DiffviewStatusAdded = fgs.green,
    DiffviewStatusUntracked = fgs.blue,
    DiffviewStatusModified = fgs.blue,
    DiffviewStatusRenamed = fgs.blue,
    DiffviewStatusCopied = fgs.blue,
    DiffviewStatusTypeChange = fgs.blue,
    DiffviewStatusUnmerged = fgs.blue,
    DiffviewStatusUnknown = fgs.red,
    DiffviewStatusDeleted = fgs.red,
    DiffviewStatusBroken = fgs.red
}

hl.plugins.neogit = {
    NeogitBranch = fgs.blue,
    NeogitDiffAdd = fgs.green,
    -- NeogitDiffAddHighlight = { bg = c.bg4 }
    -- NeogitDiffContextHighlight = { bg = c.bg4 },
    NeogitDiffDelete = fgs.red,
    -- NeogitDiffDeleteHighlight
    NeogitHunkHeader = {fg = c.orange, gui = bold},
    -- NeogitHunkHeaderHighlight
    NeogitNotificationError = fgs.bg_red,
    NeogitNotificationInfo = fgs.aqua,
    NeogitNotificationWarning = fgs.yellow,
    NeogitRemote = fgs.yellow
    -- NeogitStashes
    -- NeogitUnstagedChanges
}

hl.plugins.gitsigns = {
    GitSignsAdd = fgs.green,
    GitSignsAddLn = fgs.green,
    GitSignsAddNr = fgs.green,
    GitSignsChange = fgs.blue,
    GitSignsChangeLn = fgs.blue,
    GitSignsChangeNr = fgs.blue,
    GitSignsDelete = fgs.red,
    GitSignsDeleteLn = fgs.red,
    GitSignsDeleteNr = fgs.red
}

hl.plugins.nvim_tree = {
    NvimTreeNormal = {fg = c.fg0, bg = utils.tern(trans, c.none, c.bg0)},
    -- NOTE: Maybe fix?
    NvimTreeVertSplit = {fg = c.bg2, bg = utils.tern(trans, c.none, c.bg0)},
    NvimTreeEndOfBuffer = {
        fg = utils.tern(cfg.ending_tildes, c.bg3, c.bg0),
        bg = utils.tern(trans, c.none, c.bg0)
    },
    NvimTreeRootFolder = {fg = c.orange, gui = "bold"},
    NvimTreeGitDirty = fgs.yellow,
    NvimTreeGitNew = fgs.green,
    NvimTreeGitDeleted = fgs.red,
    NvimTreeSpecialFile = {fg = c.yellow, gui = "underline"},
    NvimTreeIndentMarker = fgs.fg0,
    NvimTreeImageFile = {fg = c.puce},
    NvimTreeSymlink = fgs.purple,
    NvimTreeFolderName = fgs.blue
}

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
    TelescopeTitle = {fg = c.purple, gui = bold}
}

hl.plugins.illuminate = {
    illuminatedWord = {link = "LspReferenceText"},
    illuminatedCurWord = {link = "LspReferenceText"}
}

hl.plugins.modes = {
    ModesCopy = {bg = c.yellow},
    ModesDelete = {bg = c.red},
    ModesInsert = {bg = c.aqua},
    ModesVisual = {bg = c.magenta}
}

hl.plugins.dashboard = {
    DashboardShortCut = {fg = c.red, gui = bold},
    DashboardFooter = {fg = c.purple, gui = bold},
    DashboardHeader = {fg = c.blue, gui = bold},
    DashboardCenter = fgs.aqua
}

hl.plugins.symbols_outline = {
    FocusedSymbol = {fg = c.bg1, bg = c.yellow, gui = bold}
}

hl.plugins.ts_rainbow = {
    rainbowcol1 = fgs.coyote_brown1,
    rainbowcol2 = fgs.yellow,
    rainbowcol3 = fgs.blue,
    rainbowcol4 = fgs.orange,
    rainbowcol5 = fgs.purple,
    rainbowcol6 = fgs.green,
    rainbowcol7 = fgs.red
}

hl.plugins.indent_blankline = {
    IndentBlanklineContextChar = {fg = c.bg_red, gui = "nocombine"}
}

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
    DapUIModifiedValue = fgs.yellow
}

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
    packerTimeLow = fgs.green
}

hl.plugins.hop = {
    HopNextKey = {fg = c.red, gui = bold},
    HopNextKey1 = {fg = c.deep_lilac, gui = bold},
    HopNextKey2 = {fg = utils.darken(c.deep_lilac, 0.7)},
    HopUnmatched = fgs.grey
}

hl.plugins.sneak = {
    Sneak = {fg = c.deep_lilac, gui = bold},
    SneakScope = {bg = c.bg4}
}

hl.plugins.lightspeed = {
    LightspeedCursor = {link = "Cursor"}
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

hl.plugins.barbar = {
    BufferCurrent = c.fg0
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

hl.plugins.fern = {
    FernBranchText = {fg = c.blue}
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

    vim.defer_fn(
        function()
            local msg = utils.messages(1, true)
            if msg and msg:match("^W18: Invalid character in group name") then
                log.err(
                    "You need to disable `langs08` or\nyou must have commit 030b422d1.\nCheck `:h lua-treesitter-highlight-groups`",
                    true,
                    {once = true}
                )
            end
        end,
        1000
    )

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
                    vim.schedule(
                        function()
                            log.err(("unknown color: '%s'"):format(name))
                        end
                    )
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
end

return M
