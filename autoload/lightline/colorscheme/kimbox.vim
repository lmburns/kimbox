" =============================================================================
" Filename: autoload/lightline/colorscheme/kimbox.vim
" Author: modified lmburns
" Email: modified burnsac@me.com
" License: MIT License
" =============================================================================

let s:colors = {
      \ 'bg0':              ['#231A0C',   '236'],
      \ 'bg1':              ['#332712',   '237'],
      \ 'bg2':              ['#332712',   '235'],
      \ 'bg3':              ['#291804',   '237'],
      \ 'bg4':              ['#5e452b',   '237'],
      \ 'bg5':              ['#5e452b',   '239'],
      \ 'fg0':              ['#D9AE80',   '223'],
      \ 'fg1':              ['#7E602C',   '225'],
      \ 'fg3':              ['#231A0C',    '17'],
      \ 'red':              ['#EF1D55',   '255'],
      \ 'magenta':          ['#A06469',   '255'],
      \ 'orange':           ['#FF5813',   '255'],
      \ 'yellow':           ['#819C3B',   '255'],
      \ 'green':            ['#FF9500',   '255'],
      \ 'aqua':             ['#7EB2B1',   '255'],
      \ 'blue':             ['#733e8b',   '255'],
      \ 'purple':           ['#98676A',   '176'],
      \ 'black':            ['#000000',    '0'],
      \ 'bg_red':           ['#DC3958',   '167'],
      \ 'grey0':            ['#7E5053',   '243'],
      \ 'grey1':            ['#7E602C',   '245'],
      \ 'grey2':            ['#a89984',   '246'],
      \ 'operator_base':  ['#e8c097',   '251'],
      \ 'none':             ['NONE',      'NONE']
  \ }

" Initialization: {{{
" Definition: {{{
let s:tab_l_fg = s:colors.grey2
let s:tab_l_bg = s:colors.bg3
let s:tab_r_fg = s:colors.bg0
let s:tab_r_bg = s:colors.grey2
let s:tab_sel_fg = s:colors.bg0
let s:tab_sel_bg = s:colors.grey2
let s:tab_middle_fg = s:colors.grey1
let s:tab_middle_bg = s:colors.bg0

let s:warningfg = s:colors.bg0
let s:warningbg = s:colors.orange
let s:errorfg = s:colors.bg0
let s:errorbg = s:colors.red

let s:normal_l1_fg = s:colors.bg0
let s:normal_l1_bg = s:colors.grey2
let s:normal_l2_fg = s:colors.grey2
let s:normal_l2_bg = s:colors.bg3
let s:normal_r1_fg = s:colors.bg0
let s:normal_r1_bg = s:colors.grey2
let s:normal_r2_fg = s:colors.grey2
let s:normal_r2_bg = s:colors.bg3
let s:normal_middle_fg = s:colors.grey2
let s:normal_middle_bg = s:colors.bg2

let s:insert_l1_fg = s:colors.bg0
let s:insert_l1_bg = s:colors.blue
let s:insert_l2_fg = s:colors.fg1
let s:insert_l2_bg = s:colors.bg3
let s:insert_r1_fg = s:colors.bg0
let s:insert_r1_bg = s:colors.blue
let s:insert_r2_fg = s:colors.fg1
let s:insert_r2_bg = s:colors.bg3
let s:insert_middle_fg = s:colors.fg1
let s:insert_middle_bg = s:colors.bg3

let s:visual_l1_fg = s:colors.bg0
let s:visual_l1_bg = s:colors.orange
let s:visual_l2_fg = s:colors.fg1
let s:visual_l2_bg = s:colors.bg3
let s:visual_r1_fg = s:colors.bg0
let s:visual_r1_bg = s:colors.orange
let s:visual_r2_fg = s:colors.fg1
let s:visual_r2_bg = s:colors.bg3
let s:visual_middle_fg = s:colors.bg0
let s:visual_middle_bg = s:colors.grey0

let s:replace_l1_fg = s:colors.bg0
let s:replace_l1_bg = s:colors.aqua
let s:replace_l2_fg = s:colors.fg1
let s:replace_l2_bg = s:colors.bg3
let s:replace_r1_fg = s:colors.bg0
let s:replace_r1_bg = s:colors.aqua
let s:replace_r2_fg = s:colors.fg1
let s:replace_r2_bg = s:colors.bg3
let s:replace_middle_fg = s:colors.fg1
let s:replace_middle_bg = s:colors.bg3

let s:command_l1_fg = s:colors.bg0
let s:command_l1_bg = s:colors.green
let s:command_l2_fg = s:colors.fg1
let s:command_l2_bg = s:colors.bg3
let s:command_r1_fg = s:colors.bg0
let s:command_r1_bg = s:colors.green
let s:command_r2_fg = s:colors.fg1
let s:command_r2_bg = s:colors.bg3
let s:command_middle_fg = s:colors.fg1
let s:command_middle_bg = s:colors.bg3

let s:terminal_l1_fg = s:colors.bg0
let s:terminal_l1_bg = s:colors.purple
let s:terminal_l2_fg = s:colors.fg1
let s:terminal_l2_bg = s:colors.bg3
let s:terminal_r1_fg = s:colors.bg0
let s:terminal_r1_bg = s:colors.purple
let s:terminal_r2_fg = s:colors.fg1
let s:terminal_r2_bg = s:colors.bg3
let s:terminal_middle_fg = s:colors.fg1
let s:terminal_middle_bg = s:colors.bg3

let s:inactive_l1_fg = s:colors.grey2
let s:inactive_l1_bg = s:colors.bg1
let s:inactive_l2_fg = s:colors.grey2
let s:inactive_l2_bg = s:colors.bg1
let s:inactive_r1_fg = s:colors.grey2
let s:inactive_r1_bg = s:colors.bg1
let s:inactive_r2_fg = s:colors.grey2
let s:inactive_r2_bg = s:colors.bg1
let s:inactive_middle_fg = s:colors.grey2
let s:inactive_middle_bg = s:colors.bg1 "}}}
"}}}
" Implementation: {{{
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'command': {}, 'terminal': {}, 'tabline': {}}

let s:p.normal.middle = [ [ s:normal_middle_fg, s:normal_middle_bg ] ]
let s:p.normal.left = [ [ s:normal_l1_fg, s:normal_l1_bg, 'bold' ], [ s:normal_l2_fg, s:normal_l2_bg ] ]
let s:p.normal.right = [ [ s:normal_r1_fg, s:normal_r1_bg, 'bold' ], [ s:normal_r2_fg, s:normal_r2_bg ] ]

let s:p.insert.middle = [ [ s:insert_middle_fg, s:insert_middle_bg ] ]
let s:p.insert.left = [ [ s:insert_l1_fg, s:insert_l1_bg, 'bold' ], [ s:insert_l2_fg, s:insert_l2_bg ] ]
let s:p.insert.right = [ [ s:insert_r1_fg, s:insert_r1_bg, 'bold' ], [ s:insert_r2_fg, s:insert_r2_bg ] ]

let s:p.visual.middle = [ [ s:visual_middle_fg, s:visual_middle_bg ] ]
let s:p.visual.left = [ [ s:visual_l1_fg, s:visual_l1_bg, 'bold' ], [ s:visual_l2_fg, s:visual_l2_bg ] ]
let s:p.visual.right = [ [ s:visual_r1_fg, s:visual_r1_bg, 'bold' ], [ s:visual_r2_fg, s:visual_r2_bg ] ]

let s:p.replace.middle = [ [ s:replace_middle_fg, s:replace_middle_bg ] ]
let s:p.replace.left = [ [ s:replace_l1_fg, s:replace_l1_bg, 'bold' ], [ s:replace_l2_fg, s:replace_l2_bg ] ]
let s:p.replace.right = [ [ s:replace_r1_fg, s:replace_r1_bg, 'bold' ], [ s:replace_r2_fg, s:replace_r2_bg ] ]

let s:p.command.middle = [ [ s:command_middle_fg, s:command_middle_bg ] ]
let s:p.command.left = [ [ s:command_l1_fg, s:command_l1_bg, 'bold' ], [ s:command_l2_fg, s:command_l2_bg ] ]
let s:p.command.right = [ [ s:command_r1_fg, s:command_r1_bg, 'bold' ], [ s:command_r2_fg, s:command_r2_bg ] ]

let s:p.terminal.middle = [ [ s:terminal_middle_fg, s:terminal_middle_bg ] ]
let s:p.terminal.left = [ [ s:terminal_l1_fg, s:terminal_l1_bg, 'bold' ], [ s:terminal_l2_fg, s:terminal_l2_bg ] ]
let s:p.terminal.right = [ [ s:terminal_r1_fg, s:terminal_r1_bg, 'bold' ], [ s:terminal_r2_fg, s:terminal_r2_bg ] ]

let s:p.inactive.left = [ [ s:inactive_l1_fg, s:inactive_l1_bg ], [ s:inactive_l2_fg, s:inactive_l2_bg ] ]
let s:p.inactive.middle = [ [ s:inactive_middle_fg, s:inactive_middle_bg ] ]
let s:p.inactive.right = [ [ s:inactive_r1_fg, s:inactive_r1_bg ], [ s:inactive_r2_fg, s:inactive_r2_bg ] ]

let s:p.tabline.left = [ [ s:tab_l_fg, s:tab_l_bg] ]
let s:p.tabline.right = [ [ s:tab_r_fg, s:tab_r_bg] ]
let s:p.tabline.tabsel = [ [ s:tab_sel_fg, s:tab_sel_bg, 'bold' ] ]
let s:p.tabline.middle = [ [ s:tab_middle_fg, s:tab_middle_bg] ]

let s:p.normal.error = [ [ s:errorfg, s:errorbg ] ]
let s:p.normal.warning = [ [ s:warningfg, s:warningbg ] ]

let g:lightline#colorscheme#kimbox#palette = lightline#colorscheme#flatten(s:p)
"}}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
