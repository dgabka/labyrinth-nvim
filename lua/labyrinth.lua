local M = {}
local config = require "labyrinth.config"

local function set_highlights()
    local utilities = require "labyrinth.utilities"
    local palette = require "labyrinth.palette"
    local styles = config.options.styles

    local groups = {}
    for group, color in pairs(config.options.groups) do
        groups[group] = utilities.parse_color(color)
    end

    local function make_border(fg)
        fg = fg or groups.border
        return {
            fg = fg,
            bg = (config.options.extend_background_behind_borders and not styles.transparency) and palette.surface
                or "NONE",
        }
    end

    local highlights = {}
    local legacy_highlights = {
        ["@attribute.diff"] = { fg = palette.sun },
        ["@boolean"] = { link = "Boolean" },
        ["@class"] = { fg = palette.leaf },
        ["@conditional"] = { link = "Conditional" },
        ["@field"] = { fg = palette.leaf },
        ["@include"] = { link = "Include" },
        ["@interface"] = { fg = palette.leaf },
        ["@macro"] = { link = "Macro" },
        ["@method"] = { fg = palette.amber },
        ["@namespace"] = { link = "Include" },
        ["@number"] = { link = "Number" },
        ["@parameter"] = { fg = palette.haze, italic = styles.italic },
        ["@preproc"] = { link = "PreProc" },
        ["@punctuation"] = { fg = palette.subtle },
        ["@punctuation.bracket"] = { link = "@punctuation" },
        ["@punctuation.delimiter"] = { link = "@punctuation" },
        ["@punctuation.special"] = { link = "@punctuation" },
        ["@regexp"] = { link = "String" },
        ["@repeat"] = { link = "Repeat" },
        ["@storageclass"] = { link = "StorageClass" },
        ["@symbol"] = { link = "Identifier" },
        ["@text"] = { fg = palette.text },
        ["@text.danger"] = { fg = groups.error },
        ["@text.diff.add"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
        ["@text.diff.delete"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
        ["@text.emphasis"] = { italic = styles.italic },
        ["@text.environment"] = { link = "Macro" },
        ["@text.environment.name"] = { link = "Type" },
        ["@text.math"] = { link = "Special" },
        ["@text.note"] = { link = "SpecialComment" },
        ["@text.strike"] = { strikethrough = true },
        ["@text.strong"] = { bold = styles.bold },
        ["@text.title"] = { link = "Title" },
        ["@text.title.1.markdown"] = { link = "markdownH1" },
        ["@text.title.1.marker.markdown"] = { link = "markdownH1Delimiter" },
        ["@text.title.2.markdown"] = { link = "markdownH2" },
        ["@text.title.2.marker.markdown"] = { link = "markdownH2Delimiter" },
        ["@text.title.3.markdown"] = { link = "markdownH3" },
        ["@text.title.3.marker.markdown"] = { link = "markdownH3Delimiter" },
        ["@text.title.4.markdown"] = { link = "markdownH4" },
        ["@text.title.4.marker.markdown"] = { link = "markdownH4Delimiter" },
        ["@text.title.5.markdown"] = { link = "markdownH5" },
        ["@text.title.5.marker.markdown"] = { link = "markdownH5Delimiter" },
        ["@text.title.6.markdown"] = { link = "markdownH6" },
        ["@text.title.6.marker.markdown"] = { link = "markdownH6Delimiter" },
        ["@text.underline"] = { underline = true },
        ["@text.uri"] = { fg = groups.link },
        ["@text.warning"] = { fg = groups.warn },
        ["@todo"] = { link = "Todo" },

        -- lukas-reineke/indent-blankline.nvim
        IndentBlanklineChar = { fg = palette.muted, nocombine = true },
        IndentBlanklineSpaceChar = { fg = palette.muted, nocombine = true },
        IndentBlanklineSpaceCharBlankline = { fg = palette.muted, nocombine = true },
    }
    local default_highlights = {
        ColorColumn = { bg = palette.surface },
        Conceal = { bg = "NONE" },
        CurSearch = { fg = palette.base, bg = palette.sun },
        Cursor = { fg = palette.text, bg = palette.highlight_high },
        CursorColumn = { bg = palette.overlay },
        -- CursorIM = {},
        CursorLine = { bg = palette.overlay },
        CursorLineNr = { fg = palette.text, bold = styles.bold },
        -- DarkenedPanel = { },
        -- DarkenedStatusline = {},
        DiffAdd = { bg = groups.git_add, blend = 20 },
        DiffChange = { bg = groups.git_change, blend = 20 },
        DiffDelete = { bg = groups.git_delete, blend = 20 },
        DiffText = { bg = groups.git_text, blend = 20 },
        diffAdded = { link = "DiffAdd" },
        diffChanged = { link = "DiffChange" },
        diffRemoved = { link = "DiffDelete" },
        Directory = { fg = palette.leaf, bold = styles.bold },
        -- EndOfBuffer = {},
        ErrorMsg = { fg = groups.error, bold = styles.bold },
        FloatBorder = make_border(),
        FloatTitle = { link = "Directory" },
        FoldColumn = { fg = palette.muted },
        Folded = { fg = palette.text, bg = groups.panel },
        IncSearch = { link = "CurSearch" },
        LineNr = { fg = palette.muted },
        MatchParen = { fg = palette.moss, bg = palette.moss, blend = 25 },
        ModeMsg = { fg = palette.subtle },
        MoreMsg = { fg = palette.haze },
        NonText = { fg = palette.muted },
        Normal = { fg = palette.text, bg = palette.base },
        NormalFloat = { bg = groups.panel },
        NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or palette.base },
        NvimInternalError = { link = "ErrorMsg" },
        Pmenu = { fg = palette.subtle, bg = groups.panel },
        PmenuExtra = { fg = palette.muted, bg = groups.panel },
        PmenuExtraSel = { fg = palette.subtle, bg = palette.overlay },
        PmenuKind = { fg = palette.leaf, bg = groups.panel },
        PmenuKindSel = { fg = palette.subtle, bg = palette.overlay },
        PmenuSbar = { bg = groups.panel },
        PmenuSel = { fg = palette.text, bg = palette.overlay },
        PmenuThumb = { bg = palette.muted },
        Question = { fg = palette.sun },
        QuickFixLine = { fg = palette.sun, bg = palette.overlay },
        RedrawDebugClear = { fg = palette.base, bg = palette.sun },
        RedrawDebugComposed = { fg = palette.base, bg = palette.moss },
        RedrawDebugRecompose = { fg = palette.base, bg = palette.crimson },
        Search = { fg = palette.base, bg = palette.text },
        SignColumn = { fg = palette.text, bg = "NONE" },
        SpecialKey = { fg = palette.leaf },
        SpellBad = { sp = palette.subtle, undercurl = true },
        SpellCap = { sp = palette.subtle, undercurl = true },
        SpellLocal = { sp = palette.subtle, undercurl = true },
        SpellRare = { sp = palette.subtle, undercurl = true },
        StatusLine = { fg = palette.subtle, bg = groups.panel },
        StatusLineNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
        StatusLineTerm = { fg = palette.base, bg = palette.moss },
        StatusLineTermNC = { fg = palette.base, bg = palette.moss, blend = 60 },
        Substitute = { link = "IncSearch" },
        TabLine = { fg = palette.subtle, bg = groups.panel },
        TabLineFill = { bg = groups.panel },
        TabLineSel = { fg = palette.text, bg = palette.overlay, bold = styles.bold },
        Title = { fg = palette.leaf, bold = styles.bold },
        VertSplit = { fg = groups.border },
        Visual = { bg = palette.highlight_med },
        -- VisualNOS = {},
        WarningMsg = { fg = groups.warn, bold = styles.bold },
        -- Whitespace = {},
        WildMenu = { link = "IncSearch" },
        WinBar = { fg = palette.subtle, bg = groups.panel },
        WinBarNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
        WinSeparator = { fg = groups.border },

        DiagnosticError = { fg = groups.error },
        DiagnosticHint = { fg = groups.hint },
        DiagnosticInfo = { fg = groups.info },
        DiagnosticWarn = { fg = groups.warn },
        DiagnosticDefaultError = { link = "DiagnosticError" },
        DiagnosticDefaultHint = { link = "DiagnosticHint" },
        DiagnosticDefaultInfo = { link = "DiagnosticInfo" },
        DiagnosticDefaultWarn = { link = "DiagnosticWarn" },
        DiagnosticFloatingError = { link = "DiagnosticError" },
        DiagnosticFloatingHint = { link = "DiagnosticHint" },
        DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
        DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
        DiagnosticSignError = { link = "DiagnosticError" },
        DiagnosticSignHint = { link = "DiagnosticHint" },
        DiagnosticSignInfo = { link = "DiagnosticInfo" },
        DiagnosticSignWarn = { link = "DiagnosticWarn" },
        DiagnosticUnderlineError = { sp = groups.error, undercurl = true },
        DiagnosticUnderlineHint = { sp = groups.hint, undercurl = true },
        DiagnosticUnderlineInfo = { sp = groups.info, undercurl = true },
        DiagnosticUnderlineWarn = { sp = groups.warn, undercurl = true },
        DiagnosticVirtualTextError = { fg = groups.error, bg = groups.error, blend = 10 },
        DiagnosticVirtualTextHint = { fg = groups.hint, bg = groups.hint, blend = 10 },
        DiagnosticVirtualTextInfo = { fg = groups.info, bg = groups.info, blend = 10 },
        DiagnosticVirtualTextWarn = { fg = groups.warn, bg = groups.warn, blend = 10 },

        Boolean = { fg = palette.amber },
        Character = { fg = palette.sun },
        Comment = { fg = palette.subtle, italic = styles.italic },
        Conditional = { fg = palette.moss },
        Constant = { fg = palette.sun },
        Debug = { fg = palette.amber },
        Define = { fg = palette.haze },
        Delimiter = { fg = palette.subtle },
        Error = { fg = palette.crimson },
        Exception = { fg = palette.moss },
        Float = { fg = palette.sun },
        Function = { fg = palette.amber },
        Identifier = { fg = palette.text },
        Include = { fg = palette.moss },
        Keyword = { fg = palette.moss },
        Label = { fg = palette.leaf },
        LspCodeLens = { fg = palette.subtle },
        LspCodeLensSeparator = { fg = palette.muted },
        LspInlayHint = { fg = palette.muted, bg = palette.muted, blend = 10 },
        LspReferenceRead = { bg = palette.highlight_med },
        LspReferenceText = { bg = palette.highlight_med },
        LspReferenceWrite = { bg = palette.highlight_med },
        Macro = { fg = palette.haze },
        Number = { fg = palette.sun },
        Operator = { fg = palette.subtle },
        PreCondit = { fg = palette.haze },
        PreProc = { link = "PreCondit" },
        Repeat = { fg = palette.moss },
        Special = { fg = palette.leaf },
        SpecialChar = { link = "Special" },
        SpecialComment = { fg = palette.haze },
        Statement = { fg = palette.moss, bold = styles.bold },
        StorageClass = { fg = palette.leaf },
        String = { fg = palette.sun },
        Structure = { fg = palette.leaf },
        Tag = { fg = palette.leaf },
        Todo = { fg = palette.amber, bg = palette.amber, blend = 20 },
        Type = { fg = palette.leaf },
        TypeDef = { link = "Type" },
        Underlined = { fg = palette.haze, underline = true },

        healthError = { fg = groups.error },
        healthSuccess = { fg = groups.info },
        healthWarning = { fg = groups.warn },

        htmlArg = { fg = palette.haze },
        htmlBold = { bold = styles.bold },
        htmlEndTag = { fg = palette.subtle },
        htmlH1 = { link = "markdownH1" },
        htmlH2 = { link = "markdownH2" },
        htmlH3 = { link = "markdownH3" },
        htmlH4 = { link = "markdownH4" },
        htmlH5 = { link = "markdownH5" },
        htmlItalic = { italic = styles.italic },
        htmlLink = { link = "markdownUrl" },
        htmlTag = { fg = palette.subtle },
        htmlTagN = { fg = palette.text },
        htmlTagName = { fg = palette.leaf },

        markdownDelimiter = { fg = palette.subtle },
        markdownH1 = { fg = groups.h1, bold = styles.bold },
        markdownH1Delimiter = { link = "markdownH1" },
        markdownH2 = { fg = groups.h2, bold = styles.bold },
        markdownH2Delimiter = { link = "markdownH2" },
        markdownH3 = { fg = groups.h3, bold = styles.bold },
        markdownH3Delimiter = { link = "markdownH3" },
        markdownH4 = { fg = groups.h4, bold = styles.bold },
        markdownH4Delimiter = { link = "markdownH4" },
        markdownH5 = { fg = groups.h5, bold = styles.bold },
        markdownH5Delimiter = { link = "markdownH5" },
        markdownH6 = { fg = groups.h6, bold = styles.bold },
        markdownH6Delimiter = { link = "markdownH6" },
        markdownLinkText = { link = "markdownUrl" },
        markdownUrl = { fg = groups.link, sp = groups.link, underline = true },

        mkdCode = { fg = palette.leaf, italic = styles.italic },
        mkdCodeDelimiter = { fg = palette.amber },
        mkdCodeEnd = { fg = palette.leaf },
        mkdCodeStart = { fg = palette.leaf },
        mkdFootnotes = { fg = palette.leaf },
        mkdID = { fg = palette.leaf, underline = true },
        mkdInlineURL = { link = "markdownUrl" },
        mkdLink = { link = "markdownUrl" },
        mkdLinkDef = { link = "markdownUrl" },
        mkdListItemLine = { fg = palette.text },
        mkdRule = { fg = palette.subtle },
        mkdURL = { link = "markdownUrl" },

        --- Identifiers
        ["@variable"] = { fg = palette.text, italic = styles.italic },
        ["@variable.builtin"] = { fg = palette.crimson, bold = styles.bold },
        ["@variable.parameter"] = { fg = palette.haze, italic = styles.italic },
        ["@variable.member"] = { fg = palette.leaf },

        ["@constant"] = { fg = palette.sun },
        ["@constant.builtin"] = { fg = palette.sun, bold = styles.bold },
        ["@constant.macro"] = { fg = palette.sun },

        ["@module"] = { fg = palette.text },
        ["@module.builtin"] = { fg = palette.text, bold = styles.bold },
        ["@label"] = { link = "Label" },

        --- Literals
        ["@string"] = { link = "String" },
        -- ["@string.documentation"] = {},
        ["@string.regexp"] = { fg = palette.haze },
        ["@string.escape"] = { fg = palette.moss },
        ["@string.special"] = { link = "String" },
        ["@string.special.symbol"] = { link = "Identifier" },
        ["@string.special.url"] = { fg = groups.link },
        -- ["@string.special.path"] = {},

        ["@character"] = { link = "Character" },
        ["@character.special"] = { link = "Character" },

        ["@boolean"] = { link = "Boolean" },
        ["@number"] = { link = "Number" },
        ["@number.float"] = { link = "Number" },
        ["@float"] = { link = "Number" },

        --- Types
        ["@type"] = { fg = palette.leaf },
        ["@type.builtin"] = { fg = palette.leaf, bold = styles.bold },
        -- ["@type.definition"] = {},
        -- ["@type.qualifier"] = {},

        -- ["@attribute"] = {},
        ["@property"] = { fg = palette.leaf, italic = styles.italic },

        --- Functions
        ["@function"] = { fg = palette.amber },
        ["@function.builtin"] = { fg = palette.amber, bold = styles.bold },
        -- ["@function.call"] = {},
        ["@function.macro"] = { link = "Function" },
        ["@function.method"] = { fg = palette.amber },
        ["@function.method.call"] = { fg = palette.haze },

        ["@constructor"] = { fg = palette.leaf },
        ["@operator"] = { link = "Operator" },

        --- Keywords
        ["@keyword"] = { link = "Keyword" },
        -- ["@keyword.coroutine"] = {},
        -- ["@keyword.function"] = {},
        ["@keyword.operator"] = { fg = palette.subtle },
        ["@keyword.import"] = { fg = palette.moss },
        ["@keyword.storage"] = { fg = palette.leaf },
        ["@keyword.repeat"] = { fg = palette.moss },
        ["@keyword.return"] = { fg = palette.moss },
        ["@keyword.debug"] = { fg = palette.amber },
        ["@keyword.exception"] = { fg = palette.moss },
        ["@keyword.conditional"] = { fg = palette.moss },
        ["@keyword.conditional.ternary"] = { fg = palette.moss },
        ["@keyword.directive"] = { fg = palette.haze },
        ["@keyword.directive.define"] = { fg = palette.haze },

        --- Punctuation
        ["@punctuation.delimiter"] = { fg = palette.subtle },
        ["@punctuation.bracket"] = { fg = palette.subtle },
        ["@punctuation.special"] = { fg = palette.subtle },

        --- Comments
        ["@comment"] = { link = "Comment" },
        -- ["@comment.documentation"] = {},

        ["@comment.error"] = { fg = groups.error },
        ["@comment.warning"] = { fg = groups.warn },
        ["@comment.todo"] = { fg = groups.todo, bg = groups.todo, blend = 20 },
        ["@comment.hint"] = { fg = groups.hint, bg = groups.hint, blend = 20 },
        ["@comment.info"] = { fg = groups.info, bg = groups.info, blend = 20 },
        ["@comment.note"] = { fg = groups.note, bg = groups.note, blend = 20 },

        --- Markup
        ["@markup.strong"] = { bold = styles.bold },
        ["@markup.italic"] = { italic = styles.italic },
        ["@markup.strikethrough"] = { strikethrough = true },
        ["@markup.underline"] = { underline = true },

        ["@markup.heading"] = { fg = palette.leaf, bold = styles.bold },

        ["@markup.quote"] = { fg = palette.subtle },
        ["@markup.math"] = { link = "Special" },
        ["@markup.environment"] = { link = "Macro" },
        ["@markup.environment.name"] = { link = "@type" },

        -- ["@markup.link"] = {},
        ["@markup.link.markdown_inline"] = { fg = palette.subtle },
        ["@markup.link.label.markdown_inline"] = { fg = palette.leaf },
        ["@markup.link.url"] = { fg = groups.link },

        -- ["@markup.raw"] = { bg = palette.surface },
        -- ["@markup.raw.block"] = { bg = palette.surface },
        ["@markup.raw.delimiter.markdown"] = { fg = palette.subtle },

        ["@markup.list"] = { fg = palette.text },
        ["@markup.list.checked"] = { fg = palette.leaf, bg = palette.leaf, blend = 10 },
        ["@markup.list.unchecked"] = { fg = palette.text },

        -- Markdown headings
        ["@markup.heading.1.markdown"] = { link = "markdownH1" },
        ["@markup.heading.2.markdown"] = { link = "markdownH2" },
        ["@markup.heading.3.markdown"] = { link = "markdownH3" },
        ["@markup.heading.4.markdown"] = { link = "markdownH4" },
        ["@markup.heading.5.markdown"] = { link = "markdownH5" },
        ["@markup.heading.6.markdown"] = { link = "markdownH6" },
        ["@markup.heading.1.marker.markdown"] = { link = "markdownH1Delimiter" },
        ["@markup.heading.2.marker.markdown"] = { link = "markdownH2Delimiter" },
        ["@markup.heading.3.marker.markdown"] = { link = "markdownH3Delimiter" },
        ["@markup.heading.4.marker.markdown"] = { link = "markdownH4Delimiter" },
        ["@markup.heading.5.marker.markdown"] = { link = "markdownH5Delimiter" },
        ["@markup.heading.6.marker.markdown"] = { link = "markdownH6Delimiter" },

        ["@diff.plus"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
        ["@diff.minus"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
        ["@diff.delta"] = { bg = groups.git_change, blend = 20 },

        ["@tag"] = { link = "Tag" },
        ["@tag.attribute"] = { fg = palette.haze },
        ["@tag.delimiter"] = { fg = palette.subtle },

        --- Non-highlighting captures
        -- ["@none"] = {},
        ["@conceal"] = { link = "Conceal" },
        ["@conceal.markdown"] = { fg = palette.subtle },

        -- ["@spell"] = {},
        -- ["@nospell"] = {},

        --- Semantic
        ["@lsp.type.comment"] = {},
        ["@lsp.type.enum"] = { link = "@type" },
        ["@lsp.type.interface"] = { link = "@interface" },
        ["@lsp.type.keyword"] = { link = "@keyword" },
        ["@lsp.type.namespace"] = { link = "@namespace" },
        ["@lsp.type.namespace.python"] = { link = "@variable" },
        ["@lsp.type.parameter"] = { link = "@parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.variable"] = {}, -- defer to treesitter for regular variables
        ["@lsp.type.variable.svelte"] = { link = "@variable" },
        ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.operator.injected"] = { link = "@operator" },
        ["@lsp.typemod.string.injected"] = { link = "@string" },
        ["@lsp.typemod.variable.constant"] = { link = "@constant" },
        ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
        ["@lsp.typemod.variable.injected"] = { link = "@variable" },

        --- Plugins
        -- romgrk/barbar.nvim
        BufferCurrent = { fg = palette.text, bg = palette.overlay },
        BufferCurrentIndex = { fg = palette.text, bg = palette.overlay },
        BufferCurrentMod = { fg = palette.leaf, bg = palette.overlay },
        BufferCurrentSign = { fg = palette.subtle, bg = palette.overlay },
        BufferCurrentTarget = { fg = palette.sun, bg = palette.overlay },
        BufferInactive = { fg = palette.subtle },
        BufferInactiveIndex = { fg = palette.subtle },
        BufferInactiveMod = { fg = palette.leaf },
        BufferInactiveSign = { fg = palette.muted },
        BufferInactiveTarget = { fg = palette.sun },
        BufferTabpageFill = { fg = "NONE", bg = "NONE" },
        BufferVisible = { fg = palette.subtle },
        BufferVisibleIndex = { fg = palette.subtle },
        BufferVisibleMod = { fg = palette.leaf },
        BufferVisibleSign = { fg = palette.muted },
        BufferVisibleTarget = { fg = palette.sun },

        -- lewis6991/gitsigns.nvim
        GitSignsAdd = { link = "SignAdd" },
        GitSignsChange = { link = "SignChange" },
        GitSignsDelete = { link = "SignDelete" },
        SignAdd = { fg = groups.git_add, bg = "NONE" },
        SignChange = { fg = groups.git_change, bg = "NONE" },
        SignDelete = { fg = groups.git_delete, bg = "NONE" },

        -- mvllow/modes.nvim
        ModesCopy = { bg = palette.sun },
        ModesDelete = { bg = palette.crimson },
        ModesInsert = { bg = palette.leaf },
        ModesVisual = { bg = palette.haze },

        -- kyazdani42/nvim-tree.lua
        NvimTreeEmptyFolderName = { fg = palette.muted },
        NvimTreeFileDeleted = { fg = groups.git_delete },
        NvimTreeFileDirty = { fg = groups.git_dirty },
        NvimTreeFileMerge = { fg = groups.git_merge },
        NvimTreeFileNew = { fg = palette.leaf },
        NvimTreeFileRenamed = { fg = groups.git_rename },
        NvimTreeFileStaged = { fg = groups.git_stage },
        NvimTreeFolderIcon = { fg = palette.subtle },
        NvimTreeFolderName = { fg = palette.leaf },
        NvimTreeGitDeleted = { fg = groups.git_delete },
        NvimTreeGitDirty = { fg = groups.git_dirty },
        NvimTreeGitIgnored = { fg = groups.git_ignore },
        NvimTreeGitMerge = { fg = groups.git_merge },
        NvimTreeGitNew = { fg = groups.git_add },
        NvimTreeGitRenamed = { fg = groups.git_rename },
        NvimTreeGitStaged = { fg = groups.git_stage },
        NvimTreeImageFile = { fg = palette.text },
        NvimTreeNormal = { link = "Normal" },
        NvimTreeOpenedFile = { fg = palette.text, bg = palette.overlay },
        NvimTreeOpenedFolderName = { link = "NvimTreeFolderName" },
        NvimTreeRootFolder = { fg = palette.leaf, bold = styles.bold },
        NvimTreeSpecialFile = { link = "NvimTreeNormal" },
        NvimTreeWindowPicker = { link = "StatusLineTerm" },

        -- nvim-neotest/neotest
        NeotestAdapterName = { fg = palette.haze },
        NeotestBorder = { fg = palette.highlight_med },
        NeotestDir = { fg = palette.leaf },
        NeotestExpandMarker = { fg = palette.highlight_med },
        NeotestFailed = { fg = palette.crimson },
        NeotestFile = { fg = palette.text },
        NeotestFocused = { fg = palette.sun, bg = palette.highlight_med },
        NeotestIndent = { fg = "" },
        NeotestMarked = { fg = palette.amber, bold = styles.bold },
        NeotestNamespace = { fg = palette.sun },
        NeotestPassed = { fg = palette.moss },
        NeotestRunning = { fg = palette.sun },
        NeotestWinSelect = { fg = palette.muted },
        NeotestSkipped = { fg = palette.subtle },
        NeotestTarget = { fg = palette.crimson },
        NeotestTest = { fg = palette.sun },
        NeotestUnknown = { fg = palette.subtle },
        NeotestWatching = { fg = palette.haze },

        -- nvim-neo-tree/neo-tree.nvim
        NeoTreeGitAdded = { fg = groups.git_add },
        NeoTreeGitConflict = { fg = groups.git_merge },
        NeoTreeGitDeleted = { fg = groups.git_delete },
        NeoTreeGitIgnored = { fg = groups.git_ignore },
        NeoTreeGitModified = { fg = groups.git_dirty },
        NeoTreeGitRenamed = { fg = groups.git_rename },
        NeoTreeGitUntracked = { fg = groups.git_untracked },
        NeoTreeTitleBar = { link = "StatusLineTerm" },

        -- folke/flash.nvim
        FlashLabel = { fg = palette.base, bg = palette.crimson },

        -- folke/which-key.nvim
        WhichKey = { fg = palette.haze },
        WhichKeyDesc = { fg = palette.sun },
        WhichKeyFloat = { bg = groups.panel },
        WhichKeyGroup = { fg = palette.leaf },
        WhichKeySeparator = { fg = palette.subtle },
        WhichKeyValue = { fg = palette.amber },

        -- lukas-reineke/indent-blankline.nvim
        IblIndent = { fg = palette.overlay },
        IblScope = { fg = palette.leaf },
        IblWhitespace = { fg = palette.overlay },

        -- hrsh7th/nvim-cmp
        CmpItemAbbr = { fg = palette.subtle },
        CmpItemAbbrDeprecated = { fg = palette.subtle, strikethrough = true },
        CmpItemAbbrMatch = { fg = palette.text, bold = styles.bold },
        CmpItemAbbrMatchFuzzy = { fg = palette.text, bold = styles.bold },
        CmpItemKind = { fg = palette.subtle },
        CmpItemKindClass = { link = "StorageClass" },
        CmpItemKindFunction = { link = "Function" },
        CmpItemKindInterface = { link = "Type" },
        CmpItemKindMethod = { link = "PreProc" },
        CmpItemKindSnippet = { link = "String" },
        CmpItemKindVariable = { link = "Identifier" },

        -- NeogitOrg/neogit
        -- https://github.com/NeogitOrg/neogit/blob/master/lua/neogit/lib/hl.lua#L109-L198
        NeogitChangeAdded = { fg = groups.git_add, bold = styles.bold, italic = styles.italic },
        NeogitChangeBothModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
        NeogitChangeCopied = { fg = groups.git_untracked, bold = styles.bold, italic = styles.italic },
        NeogitChangeDeleted = { fg = groups.git_delete, bold = styles.bold, italic = styles.italic },
        NeogitChangeModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
        NeogitChangeNewFile = { fg = groups.git_stage, bold = styles.bold, italic = styles.italic },
        NeogitChangeRenamed = { fg = groups.git_rename, bold = styles.bold, italic = styles.italic },
        NeogitChangeUpdated = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
        NeogitDiffAddHighlight = { link = "DiffAdd" },
        NeogitDiffContextHighlight = { bg = palette.surface },
        NeogitDiffDeleteHighlight = { link = "DiffDelete" },
        NeogitFilePath = { fg = palette.leaf, italic = styles.italic },
        NeogitHunkHeader = { bg = groups.panel },
        NeogitHunkHeaderHighlight = { bg = groups.panel },

        -- vimwiki/vimwiki
        VimwikiHR = { fg = palette.subtle },
        VimwikiHeader1 = { link = "markdownH1" },
        VimwikiHeader2 = { link = "markdownH2" },
        VimwikiHeader3 = { link = "markdownH3" },
        VimwikiHeader4 = { link = "markdownH4" },
        VimwikiHeader5 = { link = "markdownH5" },
        VimwikiHeader6 = { link = "markdownH6" },
        VimwikiHeaderChar = { fg = palette.subtle },
        VimwikiLink = { link = "markdownUrl" },
        VimwikiList = { fg = palette.haze },
        VimwikiNoExistsLink = { fg = palette.crimson },

        -- nvim-neorg/neorg
        NeorgHeading1Prefix = { link = "markdownH1Delimiter" },
        NeorgHeading1Title = { link = "markdownH1" },
        NeorgHeading2Prefix = { link = "markdownH2Delimiter" },
        NeorgHeading2Title = { link = "markdownH2" },
        NeorgHeading3Prefix = { link = "markdownH3Delimiter" },
        NeorgHeading3Title = { link = "markdownH3" },
        NeorgHeading4Prefix = { link = "markdownH4Delimiter" },
        NeorgHeading4Title = { link = "markdownH4" },
        NeorgHeading5Prefix = { link = "markdownH5Delimiter" },
        NeorgHeading5Title = { link = "markdownH5" },
        NeorgHeading6Prefix = { link = "markdownH6Delimiter" },
        NeorgHeading6Title = { link = "markdownH6" },
        NeorgMarkerTitle = { fg = palette.leaf, bold = styles.bold },

        -- tami5/lspsaga.nvim (fork of glepnir/lspsaga.nvim)
        DefinitionCount = { fg = palette.amber },
        DefinitionIcon = { fg = palette.amber },
        DefinitionPreviewTitle = { fg = palette.amber, bold = styles.bold },
        LspFloatWinBorder = make_border(),
        LspFloatWinNormal = { bg = groups.panel },
        LspSagaAutoPreview = { fg = palette.subtle },
        LspSagaCodeActionBorder = make_border(palette.amber),
        LspSagaCodeActionContent = { fg = palette.leaf },
        LspSagaCodeActionTitle = { fg = palette.sun, bold = styles.bold },
        LspSagaCodeActionTruncateLine = { link = "LspSagaCodeActionBorder" },
        LspSagaDefPreviewBorder = make_border(),
        LspSagaDiagnosticBorder = make_border(palette.sun),
        LspSagaDiagnosticHeader = { fg = palette.leaf, bold = styles.bold },
        LspSagaDiagnosticTruncateLine = { link = "LspSagaDiagnosticBorder" },
        LspSagaDocTruncateLine = { link = "LspSagaHoverBorder" },
        LspSagaFinderSelection = { fg = palette.sun },
        LspSagaHoverBorder = { link = "LspFloatWinBorder" },
        LspSagaLspFinderBorder = { link = "LspFloatWinBorder" },
        LspSagaRenameBorder = make_border(palette.moss),
        LspSagaRenamePromptPrefix = { fg = palette.crimson },
        LspSagaShTruncateLine = { link = "LspSagaSignatureHelpBorder" },
        LspSagaSignatureHelpBorder = make_border(palette.leaf),
        ReferencesCount = { fg = palette.amber },
        ReferencesIcon = { fg = palette.amber },
        SagaShadow = { bg = palette.overlay },
        TargetWord = { fg = palette.haze },

        -- ray-x/lsp_signature.nvim
        LspSignatureActiveParameter = { bg = palette.overlay },

        -- rlane/pounce.nvim
        PounceAccept = { fg = palette.crimson, bg = palette.crimson, blend = 20 },
        PounceAcceptBest = { fg = palette.sun, bg = palette.sun, blend = 20 },
        PounceGap = { link = "Search" },
        PounceMatch = { link = "Search" },

        -- ggandor/leap.nvim
        LeapLabelPrimary = { link = "IncSearch" },
        LeapLabelSecondary = { link = "StatusLineTerm" },
        LeapMatch = { link = "MatchParen" },

        -- phaazon/hop.nvim
        -- smoka7/hop.nvim
        HopNextKey = { fg = palette.crimson, bg = palette.crimson, blend = 20 },
        HopNextKey1 = { fg = palette.leaf, bg = palette.leaf, blend = 20 },
        HopNextKey2 = { fg = palette.moss, bg = palette.moss, blend = 20 },
        HopUnmatched = { fg = palette.muted },

        -- nvim-telescope/telescope.nvim
        TelescopeBorder = make_border(),
        TelescopeMatching = { fg = palette.amber },
        TelescopeNormal = { link = "NormalFloat" },
        TelescopePromptNormal = { link = "TelescopeNormal" },
        TelescopePromptPrefix = { fg = palette.subtle },
        TelescopeSelection = { fg = palette.text, bg = palette.overlay },
        TelescopeSelectionCaret = { fg = palette.amber, bg = palette.overlay },
        TelescopeTitle = { fg = palette.leaf, bold = styles.bold },

        -- ibhagwan/fzf-lua
        FzfLuaNormal = { link = "NormalFloat" },
        FzfLuaTitle = { fg = palette.leaf, bold = styles.bold },
        FzfLuaBorder = make_border(),
        FzfLuaHeaderText = { fg = palette.crimson },
        FzfLuaHeaderBind = { fg = palette.amber },
        FzfLuaBufFlagCur = { fg = palette.subtle },
        FzfLuaBufFlagAlt = { fg = palette.subtle },

        -- rcarriga/nvim-notify
        NotifyDEBUGBorder = make_border(),
        NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
        NotifyDEBUGTitle = { fg = palette.muted },
        NotifyERRORBorder = make_border(groups.error),
        NotifyERRORIcon = { link = "NotifyERRORTitle" },
        NotifyERRORTitle = { fg = groups.error },
        NotifyINFOBorder = make_border(groups.info),
        NotifyINFOIcon = { link = "NotifyINFOTitle" },
        NotifyINFOTitle = { fg = groups.info },
        NotifyTRACEBorder = make_border(palette.haze),
        NotifyTRACEIcon = { link = "NotifyTRACETitle" },
        NotifyTRACETitle = { fg = palette.haze },
        NotifyWARNBorder = make_border(groups.warn),
        NotifyWARNIcon = { link = "NotifyWARNTitle" },
        NotifyWARNTitle = { fg = groups.warn },

        -- rcarriga/nvim-dap-ui
        DapUIBreakpointsCurrentLine = { fg = palette.sun, bold = styles.bold },
        DapUIBreakpointsDisabledLine = { fg = palette.muted },
        DapUIBreakpointsInfo = { link = "DapUIThread" },
        DapUIBreakpointsLine = { link = "DapUIBreakpointsPath" },
        DapUIBreakpointsPath = { fg = palette.leaf },
        DapUIDecoration = { link = "DapUIBreakpointsPath" },
        DapUIFloatBorder = make_border(),
        DapUIFrameName = { fg = palette.text },
        DapUILineNumber = { link = "DapUIBreakpointsPath" },
        DapUIModifiedValue = { fg = palette.leaf, bold = styles.bold },
        DapUIScope = { link = "DapUIBreakpointsPath" },
        DapUISource = { fg = palette.haze },
        DapUIStoppedThread = { link = "DapUIBreakpointsPath" },
        DapUIThread = { fg = palette.sun },
        DapUIValue = { fg = palette.text },
        DapUIVariable = { fg = palette.text },
        DapUIWatchesEmpty = { fg = palette.crimson },
        DapUIWatchesError = { link = "DapUIWatchesEmpty" },
        DapUIWatchesValue = { link = "DapUIThread" },

        -- glepnir/dashboard-nvim
        DashboardCenter = { fg = palette.sun },
        DashboardFooter = { fg = palette.haze },
        DashboardHeader = { fg = palette.moss },
        DashboardShortcut = { fg = palette.crimson },

        -- SmiteshP/nvim-navic
        NavicIconsArray = { fg = palette.sun },
        NavicIconsBoolean = { fg = palette.amber },
        NavicIconsClass = { fg = palette.leaf },
        NavicIconsConstant = { fg = palette.sun },
        NavicIconsConstructor = { fg = palette.sun },
        NavicIconsEnum = { fg = palette.sun },
        NavicIconsEnumMember = { fg = palette.leaf },
        NavicIconsEvent = { fg = palette.sun },
        NavicIconsField = { fg = palette.leaf },
        NavicIconsFile = { fg = palette.muted },
        NavicIconsFunction = { fg = palette.moss },
        NavicIconsInterface = { fg = palette.leaf },
        NavicIconsKey = { fg = palette.haze },
        NavicIconsKeyword = { fg = palette.moss },
        NavicIconsMethod = { fg = palette.haze },
        NavicIconsModule = { fg = palette.amber },
        NavicIconsNamespace = { fg = palette.muted },
        NavicIconsNull = { fg = palette.crimson },
        NavicIconsNumber = { fg = palette.sun },
        NavicIconsObject = { fg = palette.sun },
        NavicIconsOperator = { fg = palette.subtle },
        NavicIconsPackage = { fg = palette.muted },
        NavicIconsProperty = { fg = palette.leaf },
        NavicIconsString = { fg = palette.sun },
        NavicIconsStruct = { fg = palette.leaf },
        NavicIconsTypeParameter = { fg = palette.leaf },
        NavicIconsVariable = { fg = palette.text },
        NavicSeparator = { fg = palette.subtle },
        NavicText = { fg = palette.subtle },

        -- folke/noice.nvim
        NoiceCursor = { fg = palette.highlight_high, bg = palette.text },

        -- folke/trouble.nvim
        TroubleText = { fg = palette.subtle },
        TroubleCount = { fg = palette.haze, bg = palette.surface },
        TroubleNormal = { fg = palette.text, bg = groups.panel },

        -- echasnovski/mini.clue
        MiniClueTitle = { bg = groups.panel, bold = styles.bold },

        -- echasnovski/mini.diff
        MiniDiffOverAdd = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
        MiniDiffOverChange = { fg = groups.git_change, bg = groups.git_change, blend = 20 },
        MiniDiffOverContext = { bg = palette.surface },
        MiniDiffOverDelete = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
        MiniDiffSignAdd = { fg = groups.git_add },
        MiniDiffSignChange = { fg = groups.git_change },
        MiniDiffSignDelete = { fg = groups.git_delete },

        -- echasnovski/mini.pick
        MiniPickBorderText = { bg = groups.panel },
        MiniPickPrompt = { bg = groups.panel, bold = styles.bold },

        -- echasnovski/mini.indentscope
        MiniIndentscopeSymbol = { fg = palette.muted },
        MiniIndentscopeSymbolOff = { fg = palette.muted },

        -- echasnovski/mini.statusline
        MiniStatuslineDevinfo = { fg = palette.subtle, bg = palette.overlay },
        MiniStatuslineFileinfo = { link = "MiniStatuslineDevinfo" },
        MiniStatuslineFilename = { fg = palette.muted, bg = palette.surface },
        MiniStatuslineInactive = { link = "MiniStatuslineFilename" },
        MiniStatuslineModeCommand = { fg = palette.base, bg = palette.crimson, bold = styles.bold },
        MiniStatuslineModeInsert = { fg = palette.base, bg = palette.leaf, bold = styles.bold },
        MiniStatuslineModeNormal = { fg = palette.base, bg = palette.amber, bold = styles.bold },
        MiniStatuslineModeOther = { fg = palette.base, bg = palette.amber, bold = styles.bold },
        MiniStatuslineModeReplace = { fg = palette.base, bg = palette.moss, bold = styles.bold },
        MiniStatuslineModeVisual = { fg = palette.base, bg = palette.haze, bold = styles.bold },

        -- goolord/alpha-nvim
        AlphaButtons = { fg = palette.leaf },
        AlphaFooter = { fg = palette.sun },
        AlphaHeader = { fg = palette.moss },
        AlphaShortcut = { fg = palette.amber },

        -- github/copilot.vim
        CopilotSuggestion = { fg = palette.muted, italic = styles.italic },

        -- nvim-treesitter/nvim-treesitter-context
        TreesitterContext = { bg = palette.overlay },
        TreesitterContextLineNumber = { fg = palette.amber, bg = palette.overlay },

        -- RRethy/vim-illuminate
        IlluminatedWordRead = { link = "LspReferenceRead" },
        IlluminatedWordText = { link = "LspReferenceText" },
        IlluminatedWordWrite = { link = "LspReferenceWrite" },
    }
    local transparency_highlights = {
        DiagnosticVirtualTextError = { fg = groups.error },
        DiagnosticVirtualTextHint = { fg = groups.hint },
        DiagnosticVirtualTextInfo = { fg = groups.info },
        DiagnosticVirtualTextWarn = { fg = groups.warn },

        FloatBorder = { fg = palette.muted, bg = "NONE" },
        Folded = { fg = palette.text, bg = "NONE" },
        NormalFloat = { bg = "NONE" },
        Normal = { fg = palette.text, bg = "NONE" },
        NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or "NONE" },
        Pmenu = { fg = palette.subtle, bg = "NONE" },
        PmenuKind = { fg = palette.leaf, bg = "NONE" },
        SignColumn = { fg = palette.text, bg = "NONE" },
        StatusLine = { fg = palette.subtle, bg = "NONE" },
        StatusLineNC = { fg = palette.muted, bg = "NONE" },
        TabLine = { bg = "NONE", fg = palette.subtle },
        TabLineFill = { bg = "NONE" },
        TabLineSel = { fg = palette.text, bg = "NONE", bold = styles.bold },

        -- ["@markup.raw"] = { bg = "none" },
        ["@markup.raw.markdown_inline"] = { fg = palette.sun },
        -- ["@markup.raw.block"] = { bg = "none" },

        TelescopeNormal = { fg = palette.subtle, bg = "NONE" },
        TelescopePromptNormal = { fg = palette.text, bg = "NONE" },
        TelescopeSelection = { fg = palette.text, bg = "NONE", bold = styles.bold },
        TelescopeSelectionCaret = { fg = palette.amber },

        WhichKeyFloat = { bg = "NONE" },

        IblIndent = { fg = palette.overlay, bg = "NONE" },
        IblScope = { fg = palette.leaf, bg = "NONE" },
        IblWhitespace = { fg = palette.overlay, bg = "NONE" },

        MiniClueTitle = { bg = "NONE", bold = styles.bold },

        MiniPickBorderText = { bg = "NONE" },
        MiniPickPrompt = { bg = "NONE", bold = styles.bold },
    }

    if config.options.enable.legacy_highlights then
        for group, highlight in pairs(legacy_highlights) do
            highlights[group] = highlight
        end
    end
    for group, highlight in pairs(default_highlights) do
        highlights[group] = highlight
    end
    if styles.transparency then
        for group, highlight in pairs(transparency_highlights) do
            highlights[group] = highlight
        end
    end

    -- Reconcile highlights with config
    if config.options.highlight_groups ~= nil and next(config.options.highlight_groups) ~= nil then
        for group, highlight in pairs(config.options.highlight_groups) do
            local existing = highlights[group] or {}
            -- Traverse link due to
            -- "If link is used in combination with other attributes; only the link will take effect"
            -- see: https://neovim.io/doc/user/api.html#nvim_set_hl()
            while existing.link ~= nil do
                existing = highlights[existing.link] or {}
            end
            local parsed = vim.tbl_extend("force", {}, highlight)

            if highlight.fg ~= nil then
                parsed.fg = utilities.parse_color(highlight.fg) or highlight.fg
            end
            if highlight.bg ~= nil then
                parsed.bg = utilities.parse_color(highlight.bg) or highlight.bg
            end
            if highlight.sp ~= nil then
                parsed.sp = utilities.parse_color(highlight.sp) or highlight.sp
            end

            if (highlight.inherit == nil or highlight.inherit) and existing ~= nil then
                parsed.inherit = nil
                highlights[group] = vim.tbl_extend("force", existing, parsed)
            else
                parsed.inherit = nil
                highlights[group] = parsed
            end
        end
    end

    for group, highlight in pairs(highlights) do
        if config.options.before_highlight ~= nil then
            config.options.before_highlight(group, highlight, palette)
        end
        if highlight.blend ~= nil and (highlight.blend >= 0 and highlight.blend <= 100) and highlight.bg ~= nil then
            highlight.bg = utilities.blend(highlight.bg, highlight.blend_on or palette.base, highlight.blend / 100)
        end
        vim.api.nvim_set_hl(0, group, highlight)
    end

    --- Terminal
    if config.options.enable.terminal then
        vim.g.terminal_color_0 = palette.overlay -- black
        vim.g.terminal_color_8 = palette.subtle -- bright black
        vim.g.terminal_color_1 = palette.crimson -- red
        vim.g.terminal_color_9 = palette.crimson -- bright red
        vim.g.terminal_color_2 = palette.moss -- green
        vim.g.terminal_color_10 = palette.moss -- bright green
        vim.g.terminal_color_3 = palette.sun -- yellow
        vim.g.terminal_color_11 = palette.sun -- bright yellow
        vim.g.terminal_color_4 = palette.leaf -- blue
        vim.g.terminal_color_12 = palette.leaf -- bright blue
        vim.g.terminal_color_5 = palette.haze -- magenta
        vim.g.terminal_color_13 = palette.haze -- bright magenta
        vim.g.terminal_color_6 = palette.amber -- cyan
        vim.g.terminal_color_14 = palette.amber -- bright cyan
        vim.g.terminal_color_7 = palette.text -- white
        vim.g.terminal_color_15 = palette.text -- bright white

        -- Support StatusLineTerm & StatusLineTermNC from vim
        vim.cmd [[
		augroup labyrinth
			autocmd!
			autocmd TermOpen * if &buftype=='terminal'
				\|setlocal winhighlight=StatusLine:StatusLineTerm,StatusLineNC:StatusLineTermNC
				\|else|setlocal winhighlight=|endif
			autocmd ColorSchemePre * autocmd! labyrinth
		augroup END
		]]
    end
end

---@param variant Variant | nil
function M.colorscheme(variant)
    config.extend_options { variant = variant }

    vim.opt.termguicolors = true
    if vim.g.colors_name then
        vim.cmd "hi clear"
        vim.cmd "syntax reset"
    end
    vim.g.colors_name = "labyrinth"

    set_highlights()
end

---@param options Options
function M.setup(options)
    config.extend_options(options or {})
end

return M
