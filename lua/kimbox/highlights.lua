local cfg = vim.g.kimbox_config
local c = require "kimbox.colors"
local util = require "kimbox.util"

local M = {}
local hl = {langs = {}, plugins = {}}

local reverse = cfg.allow_reverse and "reverse" or "none"
local bold = cfg.allow_bold and "bold" or "none"
local italic = cfg.allow_italic and "italic" or "none"
local underline = cfg.allow_underline and "underline" or "none"
local undercurl = cfg.allow_undercurl and "undercurl" or "none"

local function underbold()
    if cfg.allow_bold and cfg.allow_underline then
        return "bold,underline"
    elseif cfg.allow_bold then
        return "bold"
    elseif cfg.allow_underline then
        return "underline"
    else
        return "none"
    end
end

local function vim_highlights(highlights)
    for group_name, group_settings in pairs(highlights) do
        vim.api.nvim_command(
            string.format(
                "hi %s guifg=%s guibg=%s guisp=%s gui=%s",
                group_name,
                group_settings.fg or "none",
                group_settings.bg or "none",
                group_settings.sp or "none",
                group_settings.fmt or "none"
            )
        )
    end
end

local trans = cfg.transparent
local fgs = {
    fg0 = {fg = c.fg0},
    fg1 = {fg = c.fg1},
    fg2 = {fg = c.fg2},
    bg1 = {fg = c.bg1},
    bg2 = {fg = c.bg2},
    bg3 = {fg = c.bg3},
    grey2 = {fg = c.grey2},
    grey1 = {fg = c.grey1},
    grey0 = {fg = c.grey0},
    red = {fg = c.red},
    bg_red = {fg = c.bg_red},
    aqua = {fg = c.aqua},
    yellow = {fg = c.yellow},
    orange = {fg = c.orange},
    green = {fg = c.green},
    blue = {fg = c.blue},
    purple = {fg = c.purple},
    magenta = {fg = c.magenta},
    operator_base05 = {fg = c.operator_base05}
}

hl.common = {
    Normal = {fg = c.fg0, bg = trans and c.none or c.bg0},
    Terminal = {fg = c.fg0, bg = trans and c.none or c.bg0},
    FoldColumn = {fg = c.grey0, bg = trans and c.none or c.bg2},
    SignColumn = {fg = c.fg0, bg = trans and c.none or c.bg0},
    ToolbarLine = {fg = trans and c.fg0 or c.fg1, bg = trans and c.none or c.bg3},
    VertSplit = {fg = c.fg1, bg = c.none},
    Folded = {fg = c.grey1, bg = c.bg2},
    EndOfBuffer = {
        fg = cfg.ending_tildes and c.bg2 or c.bg0,
        bg = trans and c.none or c.bg0
    },
    IncSearch = {fg = c.bg1, bg = c.orange},
    Search = {fg = c.bg0, bg = c.green},
    ColorColumn = {bg = c.bg1},
    Conceal = {fg = c.grey1, bg = c.none},
    Cursor = {fmt = reverse},
    vCursor = {fmt = reverse},
    iCursor = {fmt = reverse},
    lCursor = {fmt = reverse},
    CursorIM = {fmt = reverse},
    CursorColumn = {bg = c.bg1},
    CursorLine = {fg = c.none, bg = c.bg1},
    CursorLineNr = {fg = c.purple, fmt = bold},
    LineNr = {fg = c.grey0},
    -- NOTE: Possibly change
    -- DiffAdded = fgs.green,
    -- DiffRemoved = fgs.red,
    -- DiffFile = fgs.aqua,
    -- DiffIndexLine = fgs.grey1,
    diffAdded = fgs.yellow,
    diffRemoved = fgs.red,
    diffChanged = fgs.blue,
    diffOldFile = fgs.green,
    diffNewFile = fgs.orange,
    diffFile = fgs.aqua,
    diffLine = fgs.grey1,
    diffIndexLine = fgs.purple,
    DiffAdd = {fg = c.none, bg = util.darken(c.green, 0.5, c.bg0)},
    DiffChange = {fg = c.none, bg = util.darken(c.yellow, 0.4, c.bg0)},
    DiffDelete = {fg = c.none, bg = util.darken(c.red, 0.6, c.bg0)},
    DiffText = {fg = c.none, bg = util.darken(c.blue, 0.5, c.bg0)},
    DiffFile = {fg = c.aqua},
    Directory = {fg = c.bg5, bg = c.none},
    ErrorMsg = {fg = c.red, fmt = underbold()},
    WarningMsg = {fg = c.green, fmt = bold},
    ModeMsg = {fg = c.fg0, fmt = bold},
    MoreMsg = {fg = c.green, fmt = bold},
    MatchParen = {fg = c.none, bg = c.bg4},
    Substitute = {fg = c.bg0, bg = c.green},
    NonText = {fg = c.bg5},
    Whitespace = {fg = c.bg5},
    SpecialKey = {fg = c.bg5},
    -- cfg.diagnostics.background and util.darken(c.red, 0.1, c.bg0) or c.none,

    Pmenu = {
        fg = c.operator_base05,
        bg = cfg.popup.background and c.bg0 or c.bg1
    },
    PmenuSel = {fg = c.red, bg = c.bg4, fmt = bold},
    -- Pmenu = { fg = c.operator_base05, bg = c.bg0 },
    -- PmenuSel = { fg = c.red, bg = c.bg1, fmt = bold },

    PmenuSbar = {fg = c.none, bg = c.fg3},
    -- PmenuSel = { fg = c.fg0, bg = c.fg1 },
    -- PmenuSel = { fg = c.bg3, bg = c.orange },
    PmenuThumb = {fg = c.none, bg = c.green},
    WildMenu = {fg = c.bg3, bg = c.green},
    Question = {fg = c.green},
    NormalFloat = {fg = c.fg1, bg = c.bg3},
    -- Tabline
    -- TabLine = { fg = c.fg, bg = c.bg1 },
    -- TabLineSel = { fg = c.bg0, bg = c.fg },
    TabLineFill = {fmt = "none"},
    -- Statusline
    -- When last status=2 or 3
    StatusLine = {fg = c.none, bg = c.none},
    StatusLineNC = {fg = c.grey1, bg = c.none},
    StatusLineTerm = {fg = c.fg0, bg = c.bg2},
    StatusLineTermNC = {fg = c.grey1, bg = c.bg1},
    -- Spell
    SpellBad = {fg = c.red, fmt = "undercurl", sp = c.red},
    SpellCap = {fg = c.blue, fmt = undercurl, sp = c.blue},
    SpellLocal = {fg = c.aqua, fmt = undercurl, sp = c.aqua},
    SpellRare = {fg = c.purple, fmt = undercurl, sp = c.purple},
    Visual = {fg = c.black, bg = c.operator_base05, fmt = reverse},
    VisualNOS = {fg = c.black, bg = c.operator_base05, fmt = reverse},
    QuickFixLine = {fg = c.purple, fmt = bold},
    Debug = {fg = c.orange},
    debugPC = {fg = c.bg0, bg = c.green},
    debugBreakpoint = {fg = c.bg0, bg = c.red},
    ToolbarButton = {fg = c.bg0, bg = c.grey2},
    FloatBorder = {fg = c.magenta},
    FloatermBorder = {fg = c.magenta}
}

hl.syntax = {
    Boolean = fgs.orange,
    Number = fgs.purple,
    Float = fgs.purple,
    PreProc = {fg = c.purple, fmt = italic},
    PreCondit = {fg = c.purple, fmt = italic},
    Include = {fg = c.purple, fmt = italic},
    Define = {fg = c.purple, fmt = italic},
    Conditional = {fg = c.purple, fmt = italic},
    Repeat = {fg = c.purple, fmt = italic},
    Keyword = {fg = c.red, fmt = italic},
    Typedef = {fg = c.red, fmt = italic},
    Exception = {fg = c.red, fmt = italic},
    -- NOTE: Why is vim Statement no longer bold after lua upgrade?
    --       This is `italic` in vimscript
    Statement = {fg = c.red, fmt = bold},
    Error = fgs.red,
    StorageClass = fgs.orange,
    Tag = fgs.orange,
    Label = fgs.orange,
    Structure = fgs.orange,
    Operator = fgs.operator_base05,
    Title = {fg = c.orange, fmt = bold},
    Special = fgs.green,
    SpecialChar = fgs.green,
    Type = {fg = c.green, fmt = bold},
    Function = {fg = c.magenta, fmt = bold},
    String = fgs.yellow,
    Character = fgs.yellow,
    Constant = fgs.aqua,
    Macro = fgs.aqua,
    Identifier = fgs.blue,
    Delimiter = fgs.fg0,
    Ignore = fgs.grey1,
    Underlined = {fg = c.none, fmt = underline},
    Comment = {fg = c.grey1, fmt = italic},
    SpecialComment = {fg = c.grey1, fmt = italic},
    Todo = {fg = c.purple, bg = c.none, fmt = italic}
}

hl.treesitter = {
    TSNote = {fg = c.blue, bg = c.bg0, fmt = bold},
    TSWarning = {fg = c.green, fmt = bold},
    TSDanger = {fg = c.red, fmt = bold},
    TSAnnotation = {fg = c.blue, fmt = italic},
    TSAttribute = {fg = c.green, fmt = italic},
    TSBoolean = fgs.orange,
    TSCharacter = fgs.yellow,
    TSComment = {fg = c.grey1, fmt = italic},
    TSConditional = {fg = c.purple, fmt = italic},
    TSConstant = fgs.aqua,
    TSConstBuiltin = {fg = c.orange, fmt = italic},
    TSConstMacro = {fg = c.orange, fmt = italic},
    TSConstructor = {fg = c.yellow, fmt = bold},
    TSException = {fg = c.red, fmt = italic},
    -- TSError = { fg = c.red, fmt = italic },
    TSField = fgs.yellow,
    TSFloat = fgs.purple,
    TSFuncBuiltin = {fg = c.magenta, fmt = bold},
    TSFuncMacro = fgs.aqua,
    TSFunction = {fg = c.magenta, fmt = bold},
    TSInclude = {fg = c.red, fmt = italic},
    TSKeyword = fgs.red,
    TSKeywordFunction = fgs.red,
    TSKeywordOperator = fgs.red,
    TSLabel = fgs.orange,
    TSMethod = fgs.blue,
    TSNamespace = {fg = c.blue, fmt = italic},
    TSNone = fgs.fg0,
    TSNumber = fgs.purple,
    TSOperator = fgs.orange,
    -- fg0/orange
    TSParameter = fgs.fg0,
    TSParameterReference = fgs.fg0,
    TSProperty = fgs.yellow,
    TSPunctBracket = fgs.fg0,
    TSPunctDelimiter = fgs.grey1,
    TSPunctSpecial = fgs.green,
    TSRepeat = fgs.purple,
    TSString = fgs.yellow,
    TSStringEscape = fgs.green,
    TSStringRegex = fgs.orange,
    TSSymbol = fgs.fg0,
    TSTag = {fg = c.blue, fmt = italic},
    TSTagDelimiter = fgs.magenta,
    TSText = fgs.yellow,
    TSStrike = fgs.grey1,
    -- TSStrike = { fg = c.grey1, fmt = "strikethrough" },
    -- TSStrong = { fg = c.fg, fmt = "bold" },
    -- TSEmphasis = { fg = c.fg, fmt = "italic" },
    -- TSUnderline = { fg = c.fg, fmt = "underline" },
    TSMath = fgs.green,
    TSType = fgs.green,
    TSTypeBuiltin = fgs.green,
    TSURI = {fg = c.fg1, fmt = "underline"},
    TSVariable = fgs.fg0,
    TSVariableBuiltin = fgs.blue,
    -- ??
    TSTitle = {fg = c.orange, fmt = "bold"},
    TSLiteral = fgs.green,
    TSTextReference = fgs.blue,
    TSEnviroment = fgs.fg0,
    TSEnviromentName = fgs.fg0
}

hl.langs.markdown = {
    markdownH1 = {fg = c.red, fmt = "bold"},
    markdownH2 = {fg = c.orange, fmt = "bold"},
    markdownH3 = {fg = c.green, fmt = "bold"},
    markdownH4 = {fg = c.yellow, fmt = "bold"},
    markdownH5 = {fg = c.blue, fmt = "bold"},
    markdownH6 = {fg = c.purple, fmt = "bold"},
    markdownUrl = {fg = c.blue, fmt = "underline"},
    markdownUrlDelimiter = fgs.grey1,
    markdownUrlTitleDelimiter = fgs.yellow,
    markdownItalic = {fg = c.none, fmt = "italic"},
    markdownItalicDelimiter = {fg = c.grey1, fmt = "italic"},
    markdownBold = {fg = c.none, fmt = "bold"},
    markdownBoldDelimiter = fgs.grey1,
    markdownCode = fgs.yellow,
    markdownCodeBlock = fgs.aqua,
    markdownCodeDelimiter = fgs.aqua,
    markdownBlockquote = fgs.grey1,
    markdownListMarker = fgs.red,
    markdownOrderedListMarker = fgs.red,
    markdownRule = fgs.purple,
    markdownHeadingRule = fgs.grey1,
    markdownLinkDelimiter = fgs.grey1,
    markdownLinkTextDelimiter = fgs.grey1,
    markdownHeadingDelimiter = fgs.grey1,
    markdownLinkText = fgs.purple,
    markdownId = fgs.green,
    markdownIdDeclaration = fgs.puprle
}

hl.langs.tex = {
    latexTSInclude = fgs.blue,
    latexTSFuncMacro = {fg = c.fg0, fmt = bold},
    latexTSEnvironment = {fg = c.cyan, fmt = "bold"},
    latexTSEnvironmentName = fgs.yellow,
    latexTSTitle = fgs.green,
    latexTSType = fgs.blue,
    latexTSMath = fgs.orange,
    -- Latex: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_TEX
    texStatement = fgs.yellow,
    texOnlyMath = fgs.grey1,
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
    texPartArgTitle = {fg = c.blue, fmt = italic},
    texFileArg = {fg = c.blue, fmt = italic},
    texEnvArgName = {fg = c.blue, fmt = italic},
    texMathEnvArgName = {fg = c.blue, fmt = italic},
    texTitleArg = {fg = c.blue, fmt = italic},
    texAuthorArg = {fg = c.blue, fmt = italic},
    -- Not in original
    texCmdEnv = fgs.aqua,
    texMathZoneX = fgs.orange,
    texMathZoneXX = fgs.orange,
    texMathDelimZone = fgs.grey1,
    texMathDelim = fgs.purple,
    texMathOper = fgs.red,
    texPgfType = fgs.yellow
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
    jsFunction = {fg = c.red, fmt = italic},
    jsGlobalNodeObjects = {fg = c.purple, fmt = italic},
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
    jsFunctionKey = {fg = c.yellow, fmt = bold},
    jsClassDefinition = fgs.green,
    jsDot = fgs.grey1,
    jsDestructuringBlock = fgs.blue,
    jsSpreadExpression = fgs.purple,
    jsSpreadOperator = fgs.yellow,
    jsModuleKeyword = fgs.green,
    jsObjectValue = fgs.blue,
    jsTemplateExpression = fgs.green,
    jsTemplateBraces = fgs.green,
    jsClassMethodType = fgs.orange,
    -- yajs: https://github =com/othree/yajs.vim,
    javascriptEndColons = fgs.fg0,
    javascriptOpSymbol = fgs.orange,
    javascriptOpSymbols = fgs.orange,
    javascriptIdentifierName = fgs.blue,
    javascriptVariable = fgs.orange,
    javascriptObjectLabel = fgs.aqua,
    javascriptObjectLabelColon = fgs.grey1,
    javascriptPropertyNameString = fgs.aqua,
    javascriptFuncArg = fgs.blue,
    javascriptIdentifier = fgs.purple,
    javascriptArrowFunc = fgs.purple,
    javascriptTemplate = fgs.green,
    javascriptTemplateSubstitution = fgs.green,
    javascriptTemplateSB = fgs.green,
    javascriptNodeGlobal = {fg = c.purple, fmt = italic},
    javascriptDocTags = {fg = c.purple, fmt = italic},
    javascriptDocNotation = fgs.purple,
    javascriptClassSuper = fgs.purple,
    javascriptClassName = fgs.green,
    javascriptClassSuperName = fgs.green,
    javascriptBrackets = fgs.fg0,
    javascriptBraces = fgs.fg0,
    javascriptLabel = fgs.purple,
    javascriptDotNotation = fgs.grey1,
    javascriptGlobalArrayDot = fgs.grey1,
    javascriptGlobalBigIntDot = fgs.grey1,
    javascriptGlobalDateDot = fgs.grey1,
    javascriptGlobalJSONDot = fgs.grey1,
    javascriptGlobalMathDot = fgs.grey1,
    javascriptGlobalNumberDot = fgs.grey1,
    javascriptGlobalObjectDot = fgs.grey1,
    javascriptGlobalPromiseDot = fgs.grey1,
    javascriptGlobalRegExpDot = fgs.grey1,
    javascriptGlobalStringDot = fgs.grey1,
    javascriptGlobalSymbolDot = fgs.grey1,
    javascriptGlobalURLDot = fgs.grey1,
    javascriptMethod = {fg = c.yellow, fmt = bold},
    javascriptMethodName = {fg = c.yellow, fmt = bold},
    javascriptObjectMethodName = {fg = c.yellow, fmt = bold},
    javascriptGlobalMethod = {fg = c.yellow, fmt = bold},
    javascriptDOMStorageMethod = {fg = c.yellow, fmt = bold},
    javascriptFileMethod = {fg = c.yellow, fmt = bold},
    javascriptFileReaderMethod = {fg = c.yellow, fmt = bold},
    javascriptFileListMethod = {fg = c.yellow, fmt = bold},
    javascriptBlobMethod = {fg = c.yellow, fmt = bold},
    javascriptURLStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptNumberStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptNumberMethod = {fg = c.yellow, fmt = bold},
    javascriptDOMNodeMethod = {fg = c.yellow, fmt = bold},
    javascriptES6BigIntStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptBOMWindowMethod = {fg = c.yellow, fmt = bold},
    javascriptHeadersMethod = {fg = c.yellow, fmt = bold},
    javascriptRequestMethod = {fg = c.yellow, fmt = bold},
    javascriptResponseMethod = {fg = c.yellow, fmt = bold},
    javascriptES6SetMethod = {fg = c.yellow, fmt = bold},
    javascriptReflectMethod = {fg = c.yellow, fmt = bold},
    javascriptPaymentMethod = {fg = c.yellow, fmt = bold},
    javascriptPaymentResponseMethod = {fg = c.yellow, fmt = bold},
    javascriptTypedArrayStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptGeolocationMethod = {fg = c.yellow, fmt = bold},
    javascriptES6MapMethod = {fg = c.yellow, fmt = bold},
    javascriptServiceWorkerMethod = {fg = c.yellow, fmt = bold},
    javascriptCacheMethod = {fg = c.yellow, fmt = bold},
    javascriptFunctionMethod = {fg = c.yellow, fmt = bold},
    javascriptXHRMethod = {fg = c.yellow, fmt = bold},
    javascriptBOMNavigatorMethod = {fg = c.yellow, fmt = bold},
    javascriptDOMEventTargetMethod = {fg = c.yellow, fmt = bold},
    javascriptDOMEventMethod = {fg = c.yellow, fmt = bold},
    javascriptIntlMethod = {fg = c.yellow, fmt = bold},
    javascriptDOMDocMethod = {fg = c.yellow, fmt = bold},
    javascriptStringStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptStringMethod = {fg = c.yellow, fmt = bold},
    javascriptSymbolStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptRegExpMethod = {fg = c.yellow, fmt = bold},
    javascriptObjectStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptObjectMethod = {fg = c.yellow, fmt = bold},
    javascriptBOMLocationMethod = {fg = c.yellow, fmt = bold},
    javascriptJSONStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptGeneratorMethod = {fg = c.yellow, fmt = bold},
    javascriptEncodingMethod = {fg = c.yellow, fmt = bold},
    javascriptPromiseStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptPromiseMethod = {fg = c.yellow, fmt = bold},
    javascriptBOMHistoryMethod = {fg = c.yellow, fmt = bold},
    javascriptDOMFormMethod = {fg = c.yellow, fmt = bold},
    javascriptClipboardMethod = {fg = c.yellow, fmt = bold},
    javascriptBroadcastMethod = {fg = c.yellow, fmt = bold},
    javascriptDateStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptDateMethod = {fg = c.yellow, fmt = bold},
    javascriptConsoleMethod = {fg = c.yellow, fmt = bold},
    javascriptArrayStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptArrayMethod = {fg = c.yellow, fmt = bold},
    javascriptMathStaticMethod = {fg = c.yellow, fmt = bold},
    javascriptSubtleCryptoMethod = {fg = c.yellow, fmt = bold},
    javascriptCryptoMethod = {fg = c.yellow, fmt = bold},
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
    javascriptBOMNavigatorProp = {fg = c.yellow, fmt = bold},
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

    jsxTagName = {fg = c.orange, fmt = italic},
    jsxTag = {fg = c.purple, fmt = bold},
    jsxOpenPunct = fgs.yellow,
    jsxClosePunct = fgs.blue,
    jsxEscapeJs = fgs.blue,
    jsxAttrib = fgs.green,
    jsxCloseTag = {fg = c.aqua, fmt = bold},
    jsxComponentName = {fg = c.blue, fmt = bold}
}

hl.langs.typescript = {
    -- TypeScript:
    -- vim-typescript: https://github.com/leafgarland/typescript-vim

    typescriptSource = {fg = c.purple, fmt = italic},
    typescriptMessage = fgs.green,
    typescriptGlobalObjects = fgs.aqua,
    typescriptInterpolation = fgs.green,
    typescriptInterpolationDelimiter = fgs.green,
    typescriptBraces = fgs.fg0,
    typescriptParens = fgs.purple,
    -- yats: https:github=com/HerringtonDarkholme/yats.vim

    typescriptMethodAccessor = {fg = c.orange, fmt = italic},
    typescriptVariable = fgs.orange,
    typescriptVariableDeclaration = fgs.aqua,
    typescriptTypeReference = fgs.green,
    typescriptBoolean = fgs.orange,
    typescriptCase = fgs.purple,
    typescriptRepeat = fgs.purple,
    typescriptEnumKeyword = {fg = c.red, fmt = italic},
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
    typescriptObjectColon = fgs.grey1,
    typescriptTypeAnnotation = fgs.grey1,
    typescriptAssign = fgs.operator_base05,
    typescriptBinaryOp = fgs.operator_base05,
    typescriptUnaryOp = fgs.orange,
    typescriptFuncComma = fgs.fg0,
    typescriptClassName = fgs.green,
    typescriptClassHeritage = fgs.green,
    typescriptInterfaceHeritage = fgs.green,
    typescriptIdentifier = fgs.purple,
    typescriptGlobal = fgs.purple,
    typescriptOperator = {fg = c.red, fmt = italic},
    typescriptNodeGlobal = {fg = c.purple, fmt = italic},
    typescriptExport = {fg = c.purple, fmt = italic},
    typescriptDefaultParam = fgs.orange,
    typescriptImport = {fg = c.red, fmt = italic},
    typescriptTypeParameter = fgs.green,
    typescriptReadonlyModifier = fgs.orange,
    typescriptAccessibilityModifier = fgs.orange,
    typescriptAmbientDeclaration = {fg = c.red, fmt = italic},
    typescriptTemplateSubstitution = fgs.green,
    typescriptTemplateSB = fgs.green,
    typescriptExceptions = fgs.green,
    typescriptCastKeyword = {fg = c.red, fmt = italic},
    typescriptOptionalMark = fgs.orange,
    typescriptNull = fgs.aqua,
    typescriptMappedIn = {fg = c.red, fmt = italic},
    typescriptFuncTypeArrow = fgs.purple,
    typescriptTernaryOp = fgs.orange,
    typescriptParenExp = fgs.blue,
    typescriptIndexExpr = fgs.blue,
    typescriptDotNotation = fgs.grey1,
    typescriptGlobalNumberDot = fgs.grey1,
    typescriptGlobalStringDot = fgs.grey1,
    typescriptGlobalArrayDot = fgs.grey1,
    typescriptGlobalObjectDot = fgs.grey1,
    typescriptGlobalSymbolDot = fgs.grey1,
    typescriptGlobalMathDot = fgs.grey1,
    typescriptGlobalDateDot = fgs.grey1,
    typescriptGlobalJSONDot = fgs.grey1,
    typescriptGlobalRegExpDot = fgs.grey1,
    typescriptGlobalPromiseDot = fgs.grey1,
    typescriptGlobalURLDot = fgs.grey1,
    typescriptGlobalMethod = {fg = c.yellow, fmt = bold},
    typescriptDOMStorageMethod = {fg = c.yellow, fmt = bold},
    typescriptFileMethod = {fg = c.yellow, fmt = bold},
    typescriptFileReaderMethod = {fg = c.yellow, fmt = bold},
    typescriptFileListMethod = {fg = c.yellow, fmt = bold},
    typescriptBlobMethod = {fg = c.yellow, fmt = bold},
    typescriptURLStaticMethod = {fg = c.yellow, fmt = bold},
    typescriptNumberStaticMethod = {fg = c.yellow, fmt = bold},
    typescriptNumberMethod = {fg = c.yellow, fmt = bold},
    typescriptDOMNodeMethod = {fg = c.yellow, fmt = bold},
    typescriptPaymentMethod = {fg = c.yellow, fmt = bold},
    typescriptPaymentResponseMethod = {fg = c.yellow, fmt = bold},
    typescriptHeadersMethod = {fg = c.yellow, fmt = bold},
    typescriptRequestMethod = {fg = c.yellow, fmt = bold},
    typescriptResponseMethod = {fg = c.yellow, fmt = bold},
    typescriptES6SetMethod = {fg = c.yellow, fmt = bold},
    typescriptReflectMethod = {fg = c.yellow, fmt = bold},
    typescriptBOMWindowMethod = {fg = c.yellow, fmt = bold},
    typescriptGeolocationMethod = {fg = c.yellow, fmt = bold},
    typescriptCacheMethod = {fg = c.yellow, fmt = bold},
    typescriptES6MapMethod = {fg = c.yellow, fmt = bold},
    typescriptFunctionMethod = {fg = c.yellow, fmt = bold},
    typescriptFuncName = fgs.magenta,
    typescriptFuncKeyword = fgs.blue,
    typescriptRegExpMethod = {fg = c.yellow, fmt = bold},
    typescriptXHRMethod = {fg = c.yellow, fmt = bold},
    typescriptBOMNavigatorMethod = {fg = c.yellow, fmt = bold},
    typescriptServiceWorkerMethod = {fg = c.yellow, fmt = bold},
    typescriptIntlMethod = {fg = c.yellow, fmt = bold},
    typescriptDOMEventTargetMethod = {fg = c.yellow, fmt = bold},
    typescriptDOMEventMethod = {fg = c.yellow, fmt = bold},
    typescriptDOMDocMethod = {fg = c.yellow, fmt = bold},
    typescriptStringStaticMethod = {fg = c.yellow, fmt = bold},
    typescriptStringMethod = {fg = c.yellow, fmt = bold},
    typescriptSymbolStaticMethod = {fg = c.yellow, fmt = bold},
    typescriptObjectStaticMethod = {fg = c.yellow, fmt = bold},
    typescriptObjectMethod = {fg = c.yellow, fmt = bold},
    typescriptJSONStaticMethod = {fg = c.yellow, fmt = bold},
    typescriptEncodingMethod = {fg = c.yellow, fmt = bold},
    typescriptBOMLocationMethod = {fg = c.yellow, fmt = bold},
    typescriptPromiseStaticMethod = {fg = c.yellow, fmt = bold},
    typescriptPromiseMethod = {fg = c.yellow, fmt = bold},
    typescriptSubtleCryptoMethod = {fg = c.yellow, fmt = bold},
    typescriptCryptoMethod = {fg = c.yellow, fmt = bold},
    typescriptBOMHistoryMethod = {fg = c.yellow, fmt = bold},
    typescriptDOMFormMethod = {fg = c.yellow, fmt = bold},
    typescriptConsoleMethod = {fg = c.yellow, fmt = bold},
    typescriptDateStaticMethod = {fg = c.yellow, fmt = bold},
    typescriptDateMethod = {fg = c.yellow, fmt = bold},
    typescriptArrayStaticMethod = {fg = c.yellow, fmt = bold},
    typescriptArrayMethod = {fg = c.yellow, fmt = bold},
    typescriptMathStaticMethod = {fg = c.yellow, fmt = bold},
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
    typescriptBOMNavigatorProp = {fg = c.yellow, fmt = bold},
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
    -- Treesitter:
    typescriptTSParameter = fgs.aqua,
    typescriptTSTypeBuiltin = {fg = c.green, fmt = bold},
    typescriptTSKeywordReturn = {fg = c.red, fmt = bold},
    typescriptTSPunctBracket = fgs.purple,
    typescriptTSPunctSpecial = fgs.green,
    typescriptTSVariableBuiltin = fgs.magenta,
    typescriptTSException = fgs.green,
    typescriptTSConstructor = {fg = c.blue, fmt = bold},
    -- typescriptTSNone = { fg = c.blue, fmt = bold },
    typescriptTSProperty = fgs.aqua,
    typescriptTSMethod = fgs.blue,
    -- orange/red,
    typescriptTSKeyword = fgs.red
}

hl.langs.dart = {
    -- Dart:
    -- dart-lang: https://github.com/dart-lang/dart-vim-plugin
    dartCoreClasses = fgs.aqua,
    dartTypeName = fgs.aqua,
    dartInterpolation = fgs.blue,
    dartTypeDef = {fg = c.red, fmt = italic},
    dartClassDecl = {fg = c.red, fmt = italic},
    dartLibrary = {fg = c.purple, fmt = italic},
    dartMetadata = fgs.blue
}

hl.langs.coffeescript = {
    -- CoffeeScript:
    -- vim-coffee-script: https://github.com/kchmck/vim-coffee-script
    coffeeExtendedOp = fgs.orange,
    coffeeSpecialOp = fgs.fg0,
    coffeeDotAccess = fgs.grey1,
    coffeeCurly = fgs.fg0,
    coffeeParen = fgs.fg0,
    coffeeBracket = fgs.fg0,
    coffeeParens = fgs.blue,
    coffeeBrackets = fgs.blue,
    coffeeCurlies = fgs.blue,
    coffeeOperator = {fg = c.red, fmt = italic},
    coffeeStatement = fgs.orange,
    coffeeSpecialIdent = fgs.purple,
    coffeeObject = fgs.purple,
    coffeeObjAssign = fgs.aqua
}

hl.langs.objectivec = {
    objcModuleImport = {fg = c.purple, fmt = italic},
    objcException = {fg = c.red, fmt = italic},
    objcProtocolList = fgs.aqua,
    objcObjDef = {fg = c.purple, fmt = italic},
    objcDirective = {fg = c.red, fmt = italic},
    objcPropertyAttribute = fgs.orange,
    objcHiddenArgument = fgs.aqua
}

hl.langs.python = {
    pythonBuiltin = fgs.green,
    pythonExceptions = fgs.purple,
    pythonDecoratorName = fgs.blue,
    -- python-syntax: https://github=com/vim-python/python-syntax,
    pythonExClass = fgs.purple,
    pythonBuiltinType = fgs.green,
    pythonBuiltinObj = fgs.blue,
    pythonDottedName = {fg = c.purple, fmt = italic},
    pythonBuiltinFunc = {fg = c.yellow, fmt = bold},
    pythonFunction = {fg = c.aqua, fmt = bold},
    pythonDecorator = fgs.orange,
    pythonInclude = {fg = c.purple, fmt = italic},
    pythonImport = {fg = c.purple, fmt = italic},
    pythonRun = fgs.blue,
    pythonCoding = fgs.grey1,
    pythonOperator = fgs.orange,
    pythonConditional = {fg = c.red, fmt = italic},
    pythonRepeat = {fg = c.red, fmt = italic},
    pythonException = {fg = c.red, fmt = italic},
    pythonNone = fgs.aqua,
    pythonDot = fgs.grey1,
    -- semshi: https://github=com/numirias/semshi,
    semshiUnresolved = {fg = c.green, fmt = undercurl},
    semshiImported = fgs.purple,
    semshiParameter = fgs.blue,
    semshiParameterUnused = fgs.grey1,
    semshiSelf = {fg = c.purple, fmt = italic},
    semshiGlobal = fgs.green,
    semshiBuiltin = fgs.green,
    semshiAttribute = fgs.aqua,
    semshiLocal = fgs.red,
    semshiFree = fgs.red,
    semshiErrorSign = fgs.red,
    semshiErrorChar = fgs.red,
    -- hi link  semshiSelected CocHighlightText

    -- Treesitter:
    pythonTSType = {fg = c.green, fmt = bold},
    pythonTSConstructor = fgs.magenta,
    pythonTSKeywordFunction = {fg = c.red, fmt = bold},
    pythonTSConstBuiltin = fgs.purple,
    pythonTSMethod = {fg = c.purple, fmt = bold},
    pythonTSParameter = fgs.orange,
    pythonTSConstant = fgs.aqua,
    pythonTSField = fgs.fg0,
    pythonTSStringEscape = fgs.green,
    pythonTSPunctBracket = fgs.purple
    -- pythonTSParameter = fgs.orange,
    -- pythonTSPunctBracket = fgs.green,
    -- pythonTSPunctBracket = fgs.fg0,
}

hl.langs.kotlin = {
    -- Kotlin:
    -- kotlin-vim: https://github.com/udalov/kotlin-vim
    ktSimpleInterpolation = fgs.green,
    ktComplexInterpolation = fgs.green,
    ktComplexInterpolationBrace = fgs.green,
    ktStructure = {fg = c.red, fmt = italic},
    ktKeyword = fgs.aqua
}

hl.langs.scala = {
    -- Scala:
    -- builtin: https://github.com/derekwyatt/vim-scala
    scalaNameDefinition = fgs.aqua,
    scalaInterpolationBoundary = fgs.green,
    scalaInterpolation = fgs.blue,
    scalaTypeOperator = fgs.orange,
    scalaOperator = fgs.orange,
    scalaKeywordModifier = fgs.orange
}

hl.langs.go = {
    goDirective = {fg = c.purple, fmt = italic},
    goConstants = fgs.aqua,
    goTypeDecl = {fg = c.purple, fmt = italic},
    goDeclType = {fg = c.orange, fmt = italic},
    goFunctionCall = {fg = c.green, fmt = bold},
    goSpaceError = {fg = c.grey1, bg = c.bg_red},
    goVarArgs = fgs.blue,
    goBuiltins = fgs.purple,
    goPredefinedIdentifiers = fgs.orange,
    goVar = fgs.orange,
    goField = fgs.aqua,
    goDeclaration = fgs.blue,
    goConst = fgs.orange,
    goParamName = fgs.aqua,
    goTSProperty = fgs.blue,
    goTSMethod = {fg = c.purple, fmt = bold},
    goTSType = {fg = c.green, fmt = bold},
    goTSTypeBuiltin = {fg = c.green, fmt = bold},
    goTSPunctBracket = fgs.purple
}

hl.langs.rust = {
    -- Rust:
    -- builtin: https://github.com/rust-lang/rust.vim
    rustStructure = fgs.orange,
    rustIdentifier = fgs.purple,
    rustModPath = fgs.orange,
    rustModPathSep = fgs.grey1,
    rustSelf = fgs.blue,
    rustSuper = fgs.blue,
    rustDeriveTrait = {fg = c.purple, fmt = italic},
    rustEnumVariant = fgs.purple,
    rustMacroVariable = fgs.blue,
    rustAssert = fgs.aqua,
    rustPanic = fgs.aqua,
    rustPubScopeCrate = {fg = c.purple, fmt = italic},
    rustArrowCharacter = fgs.orange,
    rustOperator = fgs.orange,
    -- Treesitter:
    rustTSConstBuiltin = fgs.purple,
    rustTSConstant = fgs.magenta,
    rustTSField = fgs.fg0,
    rustTSFuncMacro = fgs.aqua,
    rustTSInclude = {fg = c.red, fmt = italic},
    rustTSLabel = fgs.green,
    rustTSNamespace = fgs.orange,
    rustTSParameter = fgs.orange,
    rustTSPunctBracket = fgs.purple,
    rustTSPunctSpecial = fgs.magenta,
    rustTSStringEscape = fgs.green,
    rustTSType = {fg = c.green, fmt = bold},
    rustTSTypeBuiltin = {fg = c.green, fmt = bold},
    rustTSVariableBuiltin = fgs.blue
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
    phpFunction = {fg = c.yellow, fmt = bold},
    phpMethod = {fg = c.yellow, fmt = bold},
    phpClass = fgs.orange,
    phpSuperglobals = fgs.purple,
    phpFunctions = {fg = c.purple, fmt = bold},
    phpMethods = fgs.aqua,
    phpStructure = fgs.purple,
    phpOperator = fgs.purple,
    phpMemberSelector = fgs.fg0,
    phpVarSelector = {fg = c.orange, fmt = italic},
    phpIdentifier = {fg = c.orange, fmt = italic},
    phpBoolean = fgs.aqua,
    phpNumber = fgs.orange,
    phpHereDoc = fgs.green,
    phpSCKeyword = {fg = c.purple, fmt = italic},
    phpFCKeyword = {fg = c.purple, fmt = italic},
    phpRegion = fgs.blue
}

hl.langs.ruby = {
    -- Ruby:
    -- builtin: https://github.com/vim-ruby/vim-ruby
    rubyStringDelimiter = fgs.yellow,
    rubyModuleName = fgs.purple,
    rubyMacro = {fg = c.red, fmt = italic},
    rubyKeywordAsMethod = {fg = c.yellow, fmt = bold},
    rubyInterpolationDelimiter = fgs.green,
    rubyInterpolation = fgs.green,
    rubyDefinedOperator = fgs.orange,
    rubyDefine = {fg = c.red, fmt = italic},
    rubyBlockParameterList = fgs.blue,
    rubyAttribute = fgs.green,
    rubyArrayDelimiter = fgs.orange,
    rubyCurlyBlockDelimiter = fgs.orange,
    rubyAccess = fgs.orange,
    -- Needs global variable customization
    rubyTSLabel = fgs.blue,
    rubyTSString = fgs.yellow,
    rubyTSPunctSpecial = fgs.green,
    rubyTSPunctBracket = fgs.green,
    rubyTSParameter = fgs.orange,
    rubyTSSymbol = fgs.aqua,
    rubyTSNone = fgs.blue,
    rubyTSType = {fg = c.green, fmt = bold}
    -- rubyTSGlobalVariable = fgs.blue,
}

hl.langs.haskell = {
    -- Haskell:
    -- haskell-vim: https://github.com/neovimhaskell/haskell-vim
    haskellBrackets = fgs.blue,
    haskellIdentifier = fgs.green,
    haskellAssocType = fgs.aqua,
    haskellQuotedType = fgs.aqua,
    haskellType = fgs.aqua,
    haskellDeclKeyword = {fg = c.red, fmt = italic},
    haskellWhere = {fg = c.red, fmt = italic},
    haskellDeriving = {fg = c.purple, fmt = italic},
    haskellForeignKeywords = {fg = c.purple, fmt = italic}
}

hl.langs.perl = {
    -- Perl:
    -- builtin: https://github.com/vim-perl/vim-perl
    perlStatementPackage = {fg = c.purple, fmt = italic},
    perlStatementInclude = {fg = c.purple, fmt = italic},
    perlStatementStorage = fgs.orange,
    perlStatementList = fgs.orange,
    perlMatchStartEnd = fgs.orange,
    perlVarSimpleMemberName = fgs.aqua,
    perlVarSimpleMember = fgs.fg0,
    perlMethod = {fg = c.yellow, fmt = bold},
    perlOperator = fgs.red,
    podVerbatimLine = fgs.yellow,
    podCmdText = fgs.green,
    perlDATA = {fg = c.orange, fmt = italic},
    perlBraces = fgs.purple,
    perlTSVariable = fgs.blue
}

hl.langs.lua = {
    luaTSProperty = fgs.green,
    luaTSField = fgs.aqua,
    luaTSPunctBracket = fgs.purple,
    luaTSConstructor = {fg = c.green, fmt = bold},
    luaTSConstant = {fg = c.green, fmt = bold},
    luaTSKeywordFunction = fgs.red,
    -- When cursorholding
    luaFuncTable = {fg = c.red, fmt = bold}
}

hl.langs.teal = {
    tealTSOperator = fgs.orange, -- when not and as are not considered operators, i think it'd be better
    tealTSParameter = fgs.aqua,
    tealTSPunctBracket = fgs.purple,
    tealTSFunction = {fg = c.magenta, fmt = bold} -- doesn't pick up function definitions
}

hl.langs.ocaml = {
    -- OCaml:
    -- builtin: https://github=com/rgrinberg/vim-ocaml
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
    -- builtin: https://github=com/vim-erlang/vim-erlang-runtime
    erlangAtom = fgs.aqua,
    erlangLocalFuncRef = {fg = c.yellow, fmt = bold},
    erlangLocalFuncCall = {fg = c.yellow, fmt = bold},
    erlangGlobalFuncRef = {fg = c.yellow, fmt = bold},
    erlangGlobalFuncCall = {fg = c.yellow, fmt = bold},
    erlangAttribute = {fg = c.purple, fmt = italic},
    erlangPipe = fgs.orange
}

hl.langs.elixir = {
    -- Elixir:
    -- vim-elixir: https://github=com/elixir-editors/vim-elixir
    elixirStringDelimiter = fgs.yellow,
    elixirKeyword = fgs.orange,
    elixirInterpolation = fgs.green,
    elixirInterpolationDelimiter = fgs.green,
    elixirSelf = fgs.purple,
    elixirPseudoVariable = fgs.purple,
    elixirModuleDefine = {fg = c.purple, fmt = italic},
    elixirBlockDefinition = {fg = c.red, fmt = italic},
    elixirDefine = {fg = c.red, fmt = italic},
    elixirPrivateDefine = {fg = c.red, fmt = italic},
    elixirGuard = {fg = c.red, fmt = italic},
    elixirPrivateGuard = {fg = c.red, fmt = italic},
    elixirProtocolDefine = {fg = c.red, fmt = italic},
    elixirImplDefine = {fg = c.red, fmt = italic},
    elixirRecordDefine = {fg = c.red, fmt = italic},
    elixirPrivateRecordDefine = {fg = c.red, fmt = italic},
    elixirMacroDefine = {fg = c.red, fmt = italic},
    elixirPrivateMacroDefine = {fg = c.red, fmt = italic},
    elixirDelegateDefine = {fg = c.red, fmt = italic},
    elixirOverridableDefine = {fg = c.red, fmt = italic},
    elixirExceptionDefine = {fg = c.red, fmt = italic},
    elixirCallbackDefine = {fg = c.red, fmt = italic},
    elixirStructDefine = {fg = c.red, fmt = italic},
    elixirExUnitMacro = {fg = c.red, fmt = italic}
}

hl.langs.clojure = {
    -- Clojure:
    -- builtin: https://github=com/guns/vim-clojure-static
    clojureMacro = {fg = c.purple, fmt = italic},
    clojureFunc = {fg = c.aqua, fmt = bold},
    clojureConstant = fgs.green,
    clojureSpecial = {fg = c.red, fmt = italic},
    clojureDefine = {fg = c.red, fmt = italic},
    clojureKeyword = fgs.orange,
    clojureVariable = fgs.blue,
    clojureMeta = fgs.green,
    clojureDeref = fgs.green
}

hl.langs.r = {
    rFunction = {fg = c.purple, fmt = bold},
    rType = {fg = c.green, fmt = bold},
    rRegion = {fg = c.purple, fmt = bold},
    rAssign = {fg = c.red, fmt = bold},
    rBoolean = fgs.orange,
    rOperator = fgs.orange,
    rSection = fgs.orange,
    rRepeat = fgs.purple
}

hl.langs.matlab = {
    matlabSemicolon = fgs.fg0,
    matlabFunction = {fg = c.red, fmt = italic},
    matlabImplicit = {fg = c.yellow, fmt = bold},
    matlabDelimiter = fgs.fg0,
    matlabOperator = {fg = c.yellow, fmt = bold},
    matlabArithmeticOperator = fgs.orange,
    matlabRelationalOperator = fgs.orange,
    matlabLogicalOperator = fgs.orange
}

hl.langs.vim = {
    -- vimMapModKey = fgs.orange,
    vimCommentTitle = {fg = c.grey1, bg = c.none, fmt = bold},
    vimLet = fgs.orange,
    vimVar = fgs.aqua,
    vimFunction = {fg = c.magenta, fmt = bold},
    vimIsCommand = fgs.fg0,
    vimUserFunc = {fg = c.green, fmt = bold},
    vimFuncName = {fg = c.green, fmt = bold},
    vimMap = {fg = c.purple, fmt = italic},
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
    vimSetSep = fgs.grey0,
    vimContinue = fgs.grey1
}

hl.langs.c = {
    cInclude = fgs.blue,
    cStorageClass = fgs.purple,
    cTypedef = fgs.purple,
    cDefine = fgs.aqua,
    -- cTSInclude = fgs.blue,
    cTSInclude = fgs.red,
    cTSConstant = fgs.aqua,
    cTSConstMacro = fgs.orange,
    -- cTSFuncMacro = fgs.yellow,
    cTSOperator = fgs.orange,
    -- cTSRepeat = fgs.magenta,
    cTSRepeat = fgs.blue,
    cTSType = {fg = c.green, fmt = bold},
    cTSPunctBracket = fgs.purple
    -- cTSProperty = fgs.blue
}

hl.langs.cpp = {
    cppStatement = {fg = c.purple, fmt = bold},
    cppTSConstant = fgs.aqua,
    cppTSOperator = fgs.purple,
    cppTSConstMacro = fgs.aqua,
    cppTSNamespace = fgs.orange,
    cppTSType = {fg = c.green, fmt = bold},
    cppTSTypeBuiltin = {fg = c.green, fmt = bold},
    cppTSKeyword = fgs.red,
    cppTSInclude = {fg = c.red, fmt = italic},
    cppTSMethod = fgs.blue,
    cppTSField = fgs.yellow,
    cppTSConstructor = fgs.blue
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
    shFunctionOne = {fg = c.yellow, fmt = bold},
    shFunctionKey = {fg = c.red, fmt = italic},
    bashTSFuncBuiltin = fgs.red,
    bashTSParameter = fgs.green,
    bashTSConstant = fgs.blue,
    bashTSVariable = fgs.orange
}

hl.langs.zsh = {
    zshOptStart = {fg = c.purple, fmt = italic},
    zshOption = fgs.blue,
    zshSubst = fgs.green,
    zshFunction = {fg = c.purple, fmt = bold},
    zshDeref = fgs.blue,
    zshTypes = fgs.orange,
    zshVariableDef = fgs.blue,
    zshNumber = fgs.purple,
    zshCommand = {fg = c.red, fmt = bold},
    -- zshFlag = fgs.yellow,
    zshSubstDelim = fgs.purple,
    -- ??
    rOperator = fgs.orange,
    rOTag = fgs.blue
}

-- ========================== Config Formats ==========================

hl.langs.dosini = {
    dosiniLabel = fgs.yellow,
    dosiniValue = fgs.green,
    dosiniNumber = fgs.purple,
    dosiniHeader = {fg = c.red, fmt = bold}
}

hl.langs.makefile = {
    makeIdent = fgs.aqua,
    makeSpecTarget = fgs.green,
    makeTarget = fgs.blue,
    makeCommands = fgs.orange
}

hl.langs.json = {
    jsonKeyword = fgs.orange,
    jsonQuote = fgs.grey1,
    jsonBraces = fgs.fg0
}

hl.langs.yaml = {
    yamlKey = fgs.orange,
    yamlConstant = {fg = c.red, fmt = bold},
    yamlBlockMappingKey = fgs.blue,
    yamlFloat = fgs.purple,
    yamlInteger = fgs.purple,
    yamlKeyValueDelimiter = fgs.green,
    yamlDocumentStart = {fg = c.orange, fmt = bold},
    yamlDocumentEnd = {fg = c.orange, fmt = bold},
    yamlPlainScalar = fgs.fg0,
    yamlBlockCollectionItemStart = fgs.orange,
    yamlAnchor = {fg = c.green, fmt = bold},
    yamlAlias = {fg = c.green, fmt = bold},
    yamlNodeTag = {fg = c.green, fmt = bold},
    yamlBlockMappingMerge = fgs.green,
    yamlDirective = {fg = c.red, fmt = bold},
    yamlYAMLDirective = {fg = c.red, fmt = bold},
    yamlYAMLVersion = fgs.magenta,
    yamlTSField = fgs.green
}

hl.langs.zig = {zigTSTypeBuiltin = {fg = c.green, fmt = bold}}

hl.langs.toml = {
    tomlTable = {fg = c.purple, fmt = bold},
    tomlKey = fgs.orange,
    tomlBoolean = fgs.aqua,
    tomlTableArray = {fg = c.purple, fmt = bold},
    tomlKeyValueArray = {fg = c.purple, fmt = bold}
}

hl.langs.gitcommit = {
    gitcommitSummary = fgs.red,
    gitcommitUntracked = fgs.grey1,
    gitcommitDiscarded = fgs.grey1,
    gitcommitSelected = fgs.grey1,
    gitcommitUnmerged = fgs.grey1,
    gitcommitOnBranch = fgs.grey1,
    gitcommitArrow = fgs.grey1,
    gitcommitFile = fgs.yellow
}

-- ============================== Plugins =============================
-- ====================================================================
local diag_under = (undercurl == "undercurl") and undercurl or "underline"
hl.plugins.lsp = {
    LspCxxHlSkippedRegion = fgs.grey1,
    LspCxxHlSkippedRegionBeginEnd = {fg = c.purple, fmt = italic},
    LspCxxHlGroupEnumConstant = fgs.aqua,
    LspCxxHlGroupNamespace = fgs.purple,
    LspCxxHlGroupMemberVariable = fgs.aqua,
    DiagnosticError = {fg = c.red},
    DiagnosticHint = {fg = c.purple},
    DiagnosticInfo = {fg = c.cyan},
    DiagnosticWarn = {fg = c.yellow},
    DiagnosticVirtualTextError = {
        bg = cfg.diagnostics.background and util.darken(c.red, 0.1, c.bg0) or c.none,
        fg = c.red
    },
    DiagnosticVirtualTextWarn = {
        bg = cfg.diagnostics.background and util.darken(c.yellow, 0.1, c.bg0) or c.none,
        fg = c.yellow
    },
    DiagnosticVirtualTextInfo = {
        bg = cfg.diagnostics.background and util.darken(c.aqua, 0.1, c.bg0) or c.none,
        fg = c.aqua
    },
    DiagnosticVirtualTextHint = {
        bg = cfg.diagnostics.background and util.darken(c.purple, 0.1, c.bg0) or c.none,
        fg = c.purple
    },
    -- DiagnosticVirtualTextError = {
    --   bg = cfg.diagnostics.background and c.bg0 or c.bg4,
    --   fg = c.purple
    -- },

    DiagnosticUnderlineError = {fmt = diag_under, sp = c.red},
    DiagnosticUnderlineHint = {fmt = diag_under, sp = c.purple},
    DiagnosticUnderlineInfo = {fmt = diag_under, sp = c.aqua},
    DiagnosticUnderlineWarn = {fmt = diag_under, sp = c.yellow},
    LspReferenceText = {fmt = "underline"},
    LspReferenceWrite = {fmt = "underline"},
    LspReferenceRead = {fmt = "underline"}
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

hl.plugins.cmp = {
    CmpItemAbbr = fgs.fg0,
    CmpItemAbbrDeprecated = fgs.fg0,
    CmpItemAbbrMatch = fgs.aqua,
    CmpItemAbbrMatchFuzzy = {fg = c.cyan, fmt = underline},
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
    CmpItemKindText = fgs.grey1,
    CmpItemKindTypeParameter = fgs.red,
    CmpItemKindUnit = fgs.green,
    CmpItemKindValue = fgs.orange,
    CmpItemKindVariable = fgs.purple
}

hl.plugins.coc = {
    CocHoverRange = {fg = c.none, fmt = underbold()},
    -- underline
    CocHintHighlight = {fg = c.none, fmt = undercurl, sp = c.aqua},
    CocErrorFloat = {fg = c.red, bg = c.bg3},
    CocWarningFloat = {fg = c.green, bg = c.bg3},
    CocInfoFloat = {fg = c.blue, bg = c.bg3},
    CocHintFloat = {fg = c.aqua, bg = c.bg3},
    CocHighlightText = {bg = c.fg2},
    CocErrorSign = fgs.red,
    CocWarningSign = fgs.green,
    CocInfoSign = fgs.blue,
    CocHintSign = fgs.aqua,
    -- underline
    CocErrorHighlight = {fg = c.none, fmt = undercurl, sp = c.red},
    -- underline
    CocWarningHighlight = {fg = c.none, fmt = undercurl, sp = c.yellow},
    CocInfoHighlight = {fg = c.none, fmt = undercurl, sp = c.blue},
    CocWarningVirtualText = fgs.grey1,
    CocErrorVirtualText = fgs.grey1,
    CocInfoVirtualText = fgs.grey1,
    CocHintVirtualText = fgs.grey1,
    CocCodeLens = fgs.grey1,
    -- HighlightedyankRegion = { fg = c.none, fmt = reverse },
    CocGitAddedSign = fgs.yellow,
    CocGitChangeRemovedSign = fgs.purple,
    CocGitChangedSign = fgs.blue,
    CocGitRemovedSign = fgs.red,
    CocGitTopRemovedSign = fgs.red,
    -- coc-explorer
    CocExplorerBufferRoot = fgs.orange,
    CocExplorerBufferExpandIcon = fgs.aqua,
    CocExplorerBufferBufnr = fgs.purple,
    CocExplorerBufferModified = fgs.red,
    CocExplorerBufferBufname = fgs.grey0,
    CocExplorerBufferFullpath = fgs.grey0,
    CocExplorerFileRoot = fgs.orange,
    CocExplorerFileExpandIcon = fgs.aqua,
    CocExplorerFileFullpath = fgs.grey0,
    CocExplorerFileDirectory = fgs.yellow,
    CocExplorerFileGitStage = fgs.purple,
    CocExplorerFileGitUnstage = fgs.green,
    CocExplorerFileSize = fgs.blue,
    CocExplorerTimeAccessed = fgs.aqua,
    CocExplorerTimeCreated = fgs.aqua,
    CocExplorerTimeModified = fgs.aqua
}

hl.plugins.ale = {
    ALEError = {fg = c.none, fmt = undercurl, sp = c.red},
    ALEWarning = {fg = c.none, fmt = undercurl, sp = c.yellow},
    ALEInfo = {fg = c.none, fmt = undercurl, sp = c.blue},
    ALEErrorSign = fgs.red,
    ALEWarningSign = fgs.green,
    ALEInfoSign = fgs.blue,
    ALEVirtualTextError = fgs.grey1,
    ALEVirtualTextWarning = fgs.grey1,
    ALEVirtualTextInfo = fgs.grey1,
    ALEVirtualTextStyleError = fgs.grey1,
    ALEVirtualTextStyleWarning = fgs.grey1
}

hl.plugins.neomake = {
    NeomakeError = {fg = c.none, fmt = undercurl, sp = c.red},
    NeomakeErrorSign = fgs.red,
    NeomakeWarning = {fg = c.none, fmt = undercurl, sp = c.yellow},
    NeomakeWarningSign = fgs.green,
    NeomakeInfo = {fg = c.none, fmt = undercurl, sp = c.blue},
    NeomakeInfoSign = fgs.blue,
    NeomakeMessage = fgs.aqua,
    NeomakeMessageSign = fgs.aqua,
    NeomakeVirtualtextError = fgs.grey1,
    NeomakeVirtualtextWarning = fgs.grey1,
    NeomakeVirtualtextInfo = fgs.grey1,
    NeomakeVirtualtextMessag = fgs.grey1
}

hl.plugins.vista = {
    VistaBracket = fgs.grey1,
    VistaChildrenNr = fgs.orange,
    VistaKind = fgs.purple,
    VistaScope = fgs.red,
    VistaScopeKind = fgs.blue,
    VistaTag = {fg = c.yellow, fmt = bold},
    VistaPrefix = fgs.grey1,
    VistaColon = fgs.yellow,
    VistaIcon = fgs.green,
    VistaLineNr = fgs.fg0
}

hl.plugins.gitgutter = {
    GitGutterAdd = {fg = c.yellow, fmt = bold},
    GitGutterChange = {fg = c.blue, fmt = bold},
    GitGutterDelete = {fg = c.red, fmt = bold},
    GitGutterChangeDelete = {fg = c.purple, fmt = bold},
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
    NERDTreeUp = fgs.grey1,
    NERDTreeCWD = fgs.aqua,
    NERDTreeToggleOn = fgs.yellow,
    NERDTreeToggleOff = fgs.red,
    NERDTreeFlags = fgs.orange,
    NERDTreeLinkFile = fgs.grey1,
    NERDTreeLinkTarget = fgs.yellow
}

hl.plugins.easymotion = {
    EasyMotionTarget = {fg = c.bg0, bg = c.green},
    EasyMotionShade = fgs.grey1
}

hl.plugins.startify = {
    StartifyBracket = fgs.grey1,
    StartifyFile = fgs.fg0,
    StartifyNumber = fgs.red,
    StartifyPath = fgs.yellow,
    StartifySlash = fgs.yellow,
    StartifySection = fgs.blue,
    StartifyHeader = fgs.orange,
    StartifySpecial = fgs.grey1,
    StartifyFooter = fgs.grey1
}

hl.plugins.whichkey = {
    WhichKey = fgs.red,
    WhichKeySeperator = fgs.yellow,
    WhichKeyGroup = fgs.green,
    WhichKeyDesc = fgs.blue
}

hl.plugins.defx = {
    DefxIconsParentDirectory = fgs.orange,
    Defx_filename_directory = fgs.blue,
    Defx_filename_root = fgs.red
}

hl.plugins.dashboard = {
    DashboardShortCut = {fg = c.red, fmt = bold},
    DashboardFooter = {fg = c.purple, fmt = bold},
    DashboardHeader = {fg = c.blue, fmt = bold}
}

hl.plugins.floaterm = {
    Floaterm = {fg = c.none, bg = c.bg0},
    FloatermBorder = {fg = c.magenta, bg = c.none}
}

hl.plugins.hop = {
    HopNextKey = {fg = c.red, fmt = bold},
    HopNextKey1 = {fg = c.bpurple, fmt = bold},
    HopNextKey2 = {fg = util.darken(c.bpurple, 0.7)},
    HopUnmatched = fgs.grey
}

hl.plugins.vimwiki = {
    VimwikiBold = {fg = c.burple, fmt = "bold"},
    VimwikiCode = {fg = c.gruv_magenta},
    VimwikiItalic = {fg = "#83a598", fmt = "italic"},
    VimwikiHeader1 = {fg = "#F14A68", fmt = "bold"},
    VimwikiHeader2 = {fg = "#F06431", fmt = "bold"},
    VimwikiHeader3 = {fg = "#689d6a", fmt = "bold"},
    VimwikiHeader4 = {fg = c.green, fmt = "bold"},
    VimwikiHeader5 = {fg = c.purple, fmt = "bold"},
    VimwikiHeader6 = {fg = "#458588", fmt = "bold"}
}

-- comment
hl.plugins.diffview = {
    DiffviewFilePanelTitle = {fg = c.blue, fmt = bold},
    DiffviewFilePanelCounter = {fg = c.purple, fmt = bold},
    DiffviewFilePanelFileName = fgs.fg0,
    DiffviewNormal = hl.common.Normal,
    DiffviewCursorLine = hl.common.CursorLine,
    DiffviewVertSplit = hl.common.VertSplit,
    DiffviewSignColumn = hl.common.SignColumn,
    DiffviewStatusLine = hl.common.StatusLine,
    DiffviewStatusLineNC = hl.common.StatusLineNC,
    DiffviewEndOfBuffer = hl.common.EndOfBuffer,
    DiffviewFilePanelRootPath = fgs.grey1,
    DiffviewFilePanelPath = fgs.grey1,
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
    NeogitHunkHeader = {fg = c.orange, fmt = bold},
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
    NvimTreeNormal = {fg = c.fg0, bg = trans and c.none or c.bg0},
    -- NOTE: Maybe fix?
    NvimTreeVertSplit = {fg = c.bg2, bg = trans and c.none or c.bg0},
    NvimTreeEndOfBuffer = {
        fg = cfg.ending_tildes and c.bg3 or c.bg0,
        bg = trans and c.none or c.bg0
    },
    NvimTreeRootFolder = {fg = c.orange, fmt = "bold"},
    NvimTreeGitDirty = fgs.yellow,
    NvimTreeGitNew = fgs.green,
    NvimTreeGitDeleted = fgs.red,
    NvimTreeSpecialFile = {fg = c.yellow, fmt = "underline"},
    NvimTreeIndentMarker = fgs.fg0,
    NvimTreeImageFile = {fg = c.gruv_magenta},
    NvimTreeSymlink = fgs.purple,
    NvimTreeFolderName = fgs.blue
}

hl.plugins.telescope = {
    TelescopeSelection = {fg = c.yellow, fmt = bold},
    TelescopeSelectionCaret = fgs.green,
    TelescopeMultiSelection = fgs.blue,
    TelescopeMultiIcon = fgs.aqua,
    TelescopeBorder = fgs.magenta,
    TelescopePromptBorder = fgs.magenta,
    TelescopeResultsBorder = fgs.magenta,
    TelescopePreviewBorder = fgs.magenta,
    TelescopeMatching = fgs.orange,
    TelescopePromptPrefix = fgs.red,
    TelescopeTitle = {fg = c.purple, fmt = bold}
}

hl.plugins.dashboard = {
    DashboardShortCut = fgs.blue,
    DashboardHeader = fgs.yellow,
    DashboardCenter = fgs.aqua,
    DashboardFooter = {fg = c.bg_red, fmt = italic}
}

hl.plugins.symbols_outline = {
    FocusedSymbol = {fg = c.bg1, bg = c.yellow, fmt = bold}
}

hl.plugins.ts_rainbow = {
    rainbowcol1 = fgs.grey1,
    rainbowcol2 = fgs.yellow,
    rainbowcol3 = fgs.blue,
    rainbowcol4 = fgs.orange,
    rainbowcol5 = fgs.purple,
    rainbowcol6 = fgs.green,
    rainbowcol7 = fgs.red
}

function M.setup()
    vim_highlights(hl.common)
    vim_highlights(hl.syntax)
    vim_highlights(hl.treesitter)

    for _, group in pairs(hl.langs) do
        vim_highlights(group)
    end

    for _, group in pairs(hl.plugins) do
        vim_highlights(group)
    end

    -- user defined highlights: vim_highlights function cannot be used because it sets an attribute to none if not specified
    local function replace_color(prefix, color_name)
        if not color_name then
            return ""
        end
        if color_name:sub(1, 1) == "$" then
            local name = color_name:sub(2, -1)
            color_name = c[name]
            if not color_name then
                vim.schedule(
                    function()
                        vim.notify(
                            'kimbox.nvim: unknown color "' .. name .. '"',
                            vim.log.levels.ERROR,
                            {title = "kimbox.nvim"}
                        )
                    end
                )
                return ""
            end
        end
        return prefix .. "=" .. color_name
    end

    for group_name, group_settings in pairs(vim.g.kimbox_config.highlights) do
        vim.api.nvim_command(
            string.format(
                "highlight %s %s %s %s %s",
                group_name,
                replace_color("guifg", group_settings.fg),
                replace_color("guibg", group_settings.bg),
                replace_color("guisp", group_settings.sp),
                replace_color("gui", group_settings.fmt)
            )
        )
    end
end

return M
