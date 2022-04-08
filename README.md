# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Color](#color)
  - [Options (Lua)](#options-lua)
  - [Support Filetype](#support-filetype)
  - [Support Plugin](#support-plugin)
  - [Thanks to](#thanks-to)

----

This started out as a fork of [Oceanic Material](https://github.com/glepnir/oceanic-material) theme with my custom [Kimbie Dark](https://marketplace.visualstudio.com/items?itemName=dnamsons.kimbie-dark-plus) colors, and turned into a [One Dark](https://github.com/navarasu/onedark.nvim) fork

![Kimbox](https://lmburns.com/gallery/media/large/kimbox-preview2.png)

Kimbox is a dark colorscheme for vim/neovim

## Installation

- vim-plug
```vim
Plug 'lmburns/kimbox'

lua <<EOF
require("kimbox").setup()
require("kimbox").colorscheme()
EOF

" or
let g:kimbox_config = {
1.
}
colorscheme kimbox
```

- Packer
```lua
use({ "lmburns/kimbox", config = [[require("kimbox").load()]] })
-- or
use({
  "lmburns/kimbox",
  config = function()
      require("kimbox").setup({
          -- options
      })
      require("kimbox").load()
    end
})
```

- Bufferline
```lua
-- Colors can be accessed with
local c = require("kimbox.bufferline").colors()

-- Theme itself
local t = require("kimbox.bufferline").theme()

require("bufferline").setup(
  ...
  ...
  highlights = require("kimbox.bufferline").theme()
)
```

- Lualine
```lua
-- Colors can be accessed with
local c = require("kimbox.lualine").colors()

-- Theme itself
local t = require("kimbox.lualine").theme()

require("lualine").setup(
  ...
  ...
  theme = 'kimbox'
)
```

## Color

| #39260E                                                         | #291804                                                         | #EF1D55                                                         | #DC3958                                                         | #FF5813                                                         | #FF9500                                                         | #819C3B                                                         |
| --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- |
| ![#39260E](https://via.placeholder.com/80/39260E/000000?text=+) | ![#291804](https://via.placeholder.com/80/291804/000000?text=+) | ![#EF1D55](https://via.placeholder.com/80/EF1D55/000000?text=+) | ![#DC3958](https://via.placeholder.com/80/DC3958/000000?text=+) | ![#FF5813](https://via.placeholder.com/80/FF5813/000000?text=+) | ![#FF9500](https://via.placeholder.com/80/FF9500/000000?text=+) | ![#819C3B](https://via.placeholder.com/80/819C3B/000000?text=+) |
| #7EB2B1                                                         | #4C96A8                                                         | #98676A                                                         | #A06469                                                         | #7F5D38                                                         | #A89984                                                         | #D9AE80                                                         |
| ![#7EB2B1](https://via.placeholder.com/80/7EB2B1/000000?text=+) | ![#4C96A8](https://via.placeholder.com/80/4C96A8/000000?text=+) | ![#98676A](https://via.placeholder.com/80/98676A/000000?text=+) | ![#A06469](https://via.placeholder.com/80/A06469/000000?text=+) | ![#7F5D38](https://via.placeholder.com/80/7F5D38/000000?text=+) | ![#A89984](https://via.placeholder.com/80/A89984/000000?text=+) | ![#D9AE80](https://via.placeholder.com/80/D9AE80/000000?text=+) |

## Options (Lua)

```lua
-- These options can also be set using:
vim.g.kimbox_config = {
  -- ...options
}

require("kimbox").setup({
  -- Main options --
  style = "ocean", -- choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  -- medium: #231A0C
  -- ocean: #221A02
  -- medium: #231A0C
  -- deep: #0f111B
  -- darker:#291804

  -- TODO: Work on this
  toggle_style_key = "<Leader>ts",
  toggle_style_list = { "medium", "ocean", "vscode", "deep", "darker" }, -- or require("kimbox").bgs_list

  transparent = false, -- don't set background
  term_colors = true, -- if true enable the terminal
  ending_tildes = false, -- show the end-of-buffer tildes

  -- Used with popup menus (coc.nvim mainly) --
  popup = {
    background = false, -- use background color for pmenu
  },

  -- General formatting --
  allow_bold = true,
  allow_italic = false,
  allow_underline = false,
  allow_undercurl = true,
  allow_reverse = false,

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Related --
  diagnostics = {
    background = true, -- use background color for virtual text
  }
})

require("kimbox").colorscheme()
```

### Overriding highlight groups

```lua
require("kimbox").setup({
  colors = {
    bright_orange = "#ff8800",    -- define a new color
    green = '#00ffaa',            -- redefine an existing color
  },
  highlights = {
    TSKeyword = {fg = '$green'},
    TSString = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
    TSFunction = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
  }
})
```

## Support Filetype

- Markdown
- vim-restructuredtext
- Html
- Latex
- Xml
- css
- Sass
- scss
- Less
- Javascript
- Typescript
- JavascriptReact TypescriptReact
- Dart
- CoffeeScript
- C/C++
- chromatica
- vim-lsp-cxx-highlight
- ObjectiveC
- Python
- semshi
- lua
- java
- kotlin
- Scala
- Go
- Rust
- Swift
- PHP
- Ruby
- Haskell
- Perl
- Ocaml
- Erlang
- Elixir
- Clojure
- Matlab
- Vimscript
- Makefile
- Json/Toml/Yaml/Ini
- Diff/Git commit

## Support Plugin

- neoclide/coc.nvim
- dense-analysis/ale
- neomake/neomake
- Shougo/denite.nvim
- liuchengxu/vista.vim
- scrooloose/nerdtree
- andymass/vim-matchup
- easymotion/vim-easymotion
- justinmk/vim-sneak
- luochen1990/rainbow
- itchyny/vim-cursorword
- mhinz/vim-startify
- liuchengxu/vim-which-key
- machakann/vim-sandwich
- kristijanhusak/vim-dadbod-ui
- Shougo/defx.nvim
- glepnir/dashboard-nvim

## Thanks to

- [glepnir/oceanic-material](https://github.com/glepnir/oceanic-material)

- [equinusocio/material-theme](https://github.com/equinusocio/material-theme)

- [NLKNguyen/papercolor-theme](https://github.com/NLKNguyen/papercolor-theme)

- [mhartington/oceanic-next](https://github.com/mhartington/oceanic-next)

- [sainnhe/gruvbox-material](https://github.com/sainnhe/gruvbox-material)
