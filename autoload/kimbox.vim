" =============================================================================
" URL: https://github.com/burnsac5040/kimbox
" Filename: autoload/kimbox.vim
" Author: sainnhe / burnsac5040
" Email: sainnhe@gmail.com / lucas@burnsac.xyz
" License: MIT License
" =============================================================================

function! kimbox#get_configuration() "{{{
  return {
        \ 'background': get(g:, 'kimbox_background', 'hard'),
        \ 'palette': get(g:, 'kimbox_palette', 'material'),
        \ 'transparent_background': get(g:, 'kimbox_transparent_background', 0),
        \ 'disable_italic_comment': get(g:, 'kimbox_disable_italic_comment', 0),
        \ 'enable_bold': get(g:, 'kimbox_enable_bold', 0),
        \ 'enable_italic': get(g:, 'kimbox_enable_italic', 0),
        \ 'cursor': get(g:, 'kimbox_cursor', 'auto'),
        \ 'visual': get(g:, 'kimbox_visual', 'grey background'),
        \ 'menu_selection_background': get(g:, 'kimbox_menu_selection_background', 'grey'),
        \ 'sign_column_background': get(g:, 'kimbox_sign_column_background', 'default'),
        \ 'current_word': get(g:, 'kimbox_current_word', get(g:, 'kimbox_transparent_background', 0) == 0 ? 'grey background' : 'bold'),
        \ 'statusline_style': get(g:, 'kimbox_statusline_style', 'default'),
        \ 'lightline_disable_bold': get(g:, 'kimbox_lightline_disable_bold', 0),
        \ 'diagnostic_text_highlight': get(g:, 'kimbox_diagnostic_text_highlight', 0),
        \ 'diagnostic_line_highlight': get(g:, 'kimbox_diagnostic_line_highlight', 0),
        \ 'better_performance': get(g:, 'kimbox_better_performance', 0),
        \ }
endfunction "}}}
function! kimbox#get_palette(background, palette) "{{{
  if type(a:palette) == 4
    return a:palette
  endif
  if a:background ==# 'hard' "{{{
    if &background ==# 'dark'
      let palette1 = {
            \ 'bg0':              ['#221a02',   '234'],
            \ 'bg1':              ['#362712',   '235'],
            \ 'bg2':              ['#291804',   '235'],
            \ 'bg3':              ['#5e452b',   '237'],
            \ 'bg4':              ['#5e452b',   '237'],
            \ 'bg5':              ['#5e452b',   '239'],
            \ 'bg_statusline1':   ['#282828',   '235'],
            \ 'bg_statusline2':   ['#32302f',   '235'],
            \ 'bg_statusline3':   ['#504945',   '239'],
            \ 'bg_diff_green':    ['#32361a',   '22'],
            \ 'bg_visual_green':  ['#088649',   '22'],
            \ 'bg_diff_red':      ['#5f0d0d',   '52'],
            \ 'bg_visual_red':    ['#98676a',   '52'],
            \ 'bg_diff_blue':     ['#1b60a5',   '17'],
            \ 'bg_visual_blue':   ['#5b7e7a',   '17'],
            \ 'bg_visual_yellow': ['#7e602c',   '94'],
            \ 'bg_current_word':  ['#5e452b',   '236']
            \ }
    else
      let palette1 = {
            \ 'bg0':              ['#221a02',   '234'],
            \ 'bg1':              ['#362712',   '235'],
            \ 'bg2':              ['#291804',   '235'],
            \ 'bg3':              ['#5e452b',   '237'],
            \ 'bg4':              ['#5e452b',   '237'],
            \ 'bg5':              ['#5e452b',   '239'],
            \ 'bg_statusline1':   ['#282828',   '235'],
            \ 'bg_statusline2':   ['#32302f',   '235'],
            \ 'bg_statusline3':   ['#504945',   '239'],
            \ 'bg_diff_green':    ['#32361a',   '22'],
            \ 'bg_visual_green':  ['#088649',   '22'],
            \ 'bg_diff_red':      ['#5f0d0d',   '52'],
            \ 'bg_visual_red':    ['#98676a',   '52'],
            \ 'bg_diff_blue':     ['#1b60a5',   '17'],
            \ 'bg_visual_blue':   ['#5b7e7a',   '17'],
            \ 'bg_visual_yellow': ['#7e602c',   '94'],
            \ 'bg_current_word':  ['#5e452b',   '236']
            \ }
    endif "}}}
  elseif a:background ==# 'medium' "{{{
    if &background ==# 'dark'
      let palette1 = {
            \ 'bg0':              ['#221a02',   '234'],
            \ 'bg1':              ['#362712',   '235'],
            \ 'bg2':              ['#291804',   '235'],
            \ 'bg3':              ['#5e452b',   '237'],
            \ 'bg4':              ['#5e452b',   '237'],
            \ 'bg5':              ['#5e452b',   '239'],
            \ 'bg_statusline1':   ['#282828',   '235'],
            \ 'bg_statusline2':   ['#32302f',   '235'],
            \ 'bg_statusline3':   ['#504945',   '239'],
            \ 'bg_diff_green':    ['#32361a',   '22'],
            \ 'bg_visual_green':  ['#088649',   '22'],
            \ 'bg_diff_red':      ['#5f0d0d',   '52'],
            \ 'bg_visual_red':    ['#98676a',   '52'],
            \ 'bg_diff_blue':     ['#1b60a5',   '17'],
            \ 'bg_visual_blue':   ['#5b7e7a',   '17'],
            \ 'bg_visual_yellow': ['#7e602c',   '94'],
            \ 'bg_current_word':  ['#5e452b',   '236']
            \ }
    else
      let palette1 = {
            \ 'bg0':              ['#221a02',   '234'],
            \ 'bg1':              ['#362712',   '235'],
            \ 'bg2':              ['#291804',   '235'],
            \ 'bg3':              ['#5e452b',   '237'],
            \ 'bg4':              ['#5e452b',   '237'],
            \ 'bg5':              ['#5e452b',   '239'],
            \ 'bg_statusline1':   ['#282828',   '235'],
            \ 'bg_statusline2':   ['#32302f',   '235'],
            \ 'bg_statusline3':   ['#504945',   '239'],
            \ 'bg_diff_green':    ['#32361a',   '22'],
            \ 'bg_visual_green':  ['#088649',   '22'],
            \ 'bg_diff_red':      ['#5f0d0d',   '52'],
            \ 'bg_visual_red':    ['#98676a',   '52'],
            \ 'bg_diff_blue':     ['#1b60a5',   '17'],
            \ 'bg_visual_blue':   ['#5b7e7a',   '17'],
            \ 'bg_visual_yellow': ['#7e602c',   '94'],
            \ 'bg_current_word':  ['#5e452b',   '236']
            \ }
    endif "}}}
  elseif a:background ==# 'soft' "{{{
    if &background ==# 'dark'
      let palette1 = {
            \ 'bg0':              ['#221a02',   '234'],
            \ 'bg1':              ['#362712',   '235'],
            \ 'bg2':              ['#291804',   '235'],
            \ 'bg3':              ['#5e452b',   '237'],
            \ 'bg4':              ['#5e452b',   '237'],
            \ 'bg5':              ['#5e452b',   '239'],
            \ 'bg_statusline1':   ['#282828',   '235'],
            \ 'bg_statusline2':   ['#32302f',   '235'],
            \ 'bg_statusline3':   ['#504945',   '239'],
            \ 'bg_diff_green':    ['#32361a',   '22'],
            \ 'bg_visual_green':  ['#088649',   '22'],
            \ 'bg_diff_red':      ['#5f0d0d',   '52'],
            \ 'bg_visual_red':    ['#98676a',   '52'],
            \ 'bg_diff_blue':     ['#1b60a5',   '17'],
            \ 'bg_visual_blue':   ['#5b7e7a',   '17'],
            \ 'bg_visual_yellow': ['#7e602c',   '94'],
            \ 'bg_current_word':  ['#5e452b',   '236']
            \ }
    else
      let palette1 = {
            \ 'bg0':              ['#221a02',   '234'],
            \ 'bg1':              ['#362712',   '235'],
            \ 'bg2':              ['#291804',   '235'],
            \ 'bg3':              ['#5e452b',   '237'],
            \ 'bg4':              ['#5e452b',   '237'],
            \ 'bg5':              ['#5e452b',   '239'],
            \ 'bg_statusline1':   ['#282828',   '235'],
            \ 'bg_statusline2':   ['#32302f',   '235'],
            \ 'bg_statusline3':   ['#504945',   '239'],
            \ 'bg_diff_green':    ['#32361a',   '22'],
            \ 'bg_visual_green':  ['#088649',   '22'],
            \ 'bg_diff_red':      ['#5f0d0d',   '52'],
            \ 'bg_visual_red':    ['#98676a',   '52'],
            \ 'bg_diff_blue':     ['#1b60a5',   '17'],
            \ 'bg_visual_blue':   ['#5b7e7a',   '17'],
            \ 'bg_visual_yellow': ['#7e602c',   '94'],
            \ 'bg_current_word':  ['#5e452b',   '236']
            \ }
    endif
  endif "}}}
  if a:palette ==# 'material' "{{{
    if &background ==# 'dark'
      let palette2 = {
            \ 'fg0':              ['#e8c097',   '223'],
            \ 'fg1':              ['#D3AF86',   '223'],
            \ 'red':              ['#f73759',   '212'],
            \ 'orange':           ['#F06431',   '208'],
            \ 'yellow':           ['#889B4A',   '84'],
            \ 'green':            ['#F79A32',   '228'],
            \ 'aqua':             ['#8ab1b0',   '108'],
            \ 'blue':             ['#719190',   '109'],
            \ 'purple':           ['#98676a',   '195'],
            \ 'bg_red':           ['#F14A68',   '167'],
            \ 'bg_green':         ['#a9b665',   '142'],
            \ 'bg_yellow':        ['#d8a657',   '214']
            \ }
    else
      let palette2 = {
            \ 'fg0':              ['#C2A383',   '237'],
            \ 'fg1':              ['#D3AF86',   '237'],
            \ 'red':              ['#F14A68',   '88'],
            \ 'orange':           ['#F06431',   '130'],
            \ 'yellow':           ['#FCAC51',   '136'],
            \ 'green':            ['#A3B95A',   '100'],
            \ 'aqua':             ['#4C96A8',   '165'],
            \ 'blue':             ['#8AB1B0',   '24'],
            \ 'purple':           ['#98676A',   '96'],
            \ 'bg_red':           ['#DC3958',   '88'],
            \ 'bg_green':         ['#8AB1B0',   '100'],
            \ 'bg_yellow':        ['#F79A32',   '130']
            \ }
    endif "}}}
  endif "}}}
  if &background ==# 'dark' "{{{
    let palette3 = {
          \ 'grey0':            ['#7f5d38',   '243'],
          \ 'grey1':            ['#7f5d38',   '61'],
          \ 'grey2':            ['#6e583b',   '246'],
          \ 'none':             ['NONE',      'NONE']
          \ } "}}}
  else "{{{
    let palette3 = {
          \ 'grey0':            ['#7f5d38',   '246'],
          \ 'grey1':            ['#131510',   '245'],
          \ 'grey2':            ['#6e583b',   '243'],
          \ 'none':             ['NONE',      'NONE']
          \ }
  endif "}}}
  return extend(extend(palette1, palette2), palette3)
endfunction "}}}
function! kimbox#highlight(group, fg, bg, ...) "{{{
  execute 'highlight' a:group
        \ 'guifg=' . a:fg[0]
        \ 'guibg=' . a:bg[0]
        \ 'ctermfg=' . a:fg[1]
        \ 'ctermbg=' . a:bg[1]
        \ 'gui=' . (a:0 >= 1 ?
          \ (a:1 ==# 'undercurl' ?
            \ (executable('tmux') && $TMUX !=# '' ?
              \ 'underline' :
              \ 'undercurl') :
            \ a:1) :
          \ 'NONE')
        \ 'cterm=' . (a:0 >= 1 ?
          \ (a:1 ==# 'undercurl' ?
            \ 'underline' :
            \ a:1) :
          \ 'NONE')
        \ 'guisp=' . (a:0 >= 2 ?
          \ a:2[0] :
          \ 'NONE')
endfunction "}}}
function! kimbox#ft_gen(path, last_modified, msg) "{{{
  " Generate the `after/ftplugin` directory.
  let full_content = join(readfile(a:path), "\n") " Get the content of `colors/kimbox.vim`
  let ft_content = []
  let rootpath = kimbox#ft_rootpath(a:path) " Get the path to place the `after/ftplugin` directory.
  call substitute(full_content, '" ft_begin.\{-}ft_end', '\=add(ft_content, submatch(0))', 'g') " Search for 'ft_begin.\{-}ft_end' (non-greedy) and put all the search results into a list.
  for content in ft_content
    let ft_list = []
    call substitute(matchstr(matchstr(content, 'ft_begin:.\{-}{{{'), ':.\{-}{{{'), '\(\w\|-\)\+', '\=add(ft_list, submatch(0))', 'g') " Get the file types. }}}}}}
    for ft in ft_list
      call kimbox#ft_write(rootpath, ft, content) " Write the content.
    endfor
  endfor
  call kimbox#ft_write(rootpath, 'text', "let g:kimbox_last_modified = '" . a:last_modified . "'") " Write the last modified time to `after/ftplugin/text/kimbox.vim`
  if a:msg ==# 'update'
    echohl WarningMsg | echom '[kimbox] Updated ' . rootpath . '/after/ftplugin' | echohl None
  else
    echohl WarningMsg | echom '[kimbox] Generated ' . rootpath . '/after/ftplugin' | echohl None
  endif
endfunction "}}}
function! kimbox#ft_write(rootpath, ft, content) "{{{
  " Write the content.
  let ft_path = a:rootpath . '/after/ftplugin/' . a:ft . '/kimbox.vim' " The path of a ftplugin file.
  " create a new file if it doesn't exist
  if !filereadable(ft_path)
    call mkdir(a:rootpath . '/after/ftplugin/' . a:ft, 'p')
    call writefile([
          \ "if !exists('g:colors_name') || g:colors_name !=# 'kimbox'",
          \ '    finish',
          \ 'endif'
          \ ], ft_path, 'a') " Abort if the current color scheme is not kimbox.
    call writefile([
          \ "if index(g:kimbox_loaded_file_types, '" . a:ft . "') ==# -1",
          \ "    call add(g:kimbox_loaded_file_types, '" . a:ft . "')",
          \ 'else',
          \ '    finish',
          \ 'endif'
          \ ], ft_path, 'a') " Abort if this file type has already been loaded.
  endif
  " If there is something like `call kimbox#highlight()`, then add
  " code to initialize the palette and configuration.
  if matchstr(a:content, 'kimbox#highlight') !=# ''
    call writefile([
          \ 'let s:configuration = kimbox#get_configuration()',
          \ 'let s:palette = kimbox#get_palette(s:configuration.background, s:configuration.palette)'
          \ ], ft_path, 'a')
  endif
  " Append the content.
  call writefile(split(a:content, "\n"), ft_path, 'a')
endfunction "}}}
function! kimbox#ft_rootpath(path) "{{{
  " Get the directory where `after/ftplugin` is generated.
  if (matchstr(a:path, '^/usr/share') ==# '') || has('win32') " Return the plugin directory. The `after/ftplugin` directory should never be generated in `/usr/share`, even if you are a root user.
    return fnamemodify(a:path, ':p:h:h')
  else " Use vim home directory.
    if has('nvim')
      return stdpath('config')
    else
      if has('win32') || has ('win64')
        return $VIM . '/vimfiles'
      else
        return $HOME . '/.vim'
      endif
    endif
  endif
endfunction "}}}
function! kimbox#ft_newest(path, last_modified) "{{{
  " Determine whether the current ftplugin files are up to date by comparing the last modified time in `colors/kimbox.vim` and `after/ftplugin/text/kimbox.vim`.
  let rootpath = kimbox#ft_rootpath(a:path)
  execute 'source ' . rootpath . '/after/ftplugin/text/kimbox.vim'
  return a:last_modified ==# g:kimbox_last_modified ? 1 : 0
endfunction "}}}
function! kimbox#ft_clean(path, msg) "{{{
  " Clean the `after/ftplugin` directory.
  let rootpath = kimbox#ft_rootpath(a:path)
  " Remove `after/ftplugin/**/kimbox.vim`.
  let file_list = split(globpath(rootpath, 'after/ftplugin/**/kimbox.vim'), "\n")
  for file in file_list
    call delete(file)
  endfor
  " Remove empty directories.
  let dir_list = split(globpath(rootpath, 'after/ftplugin/*'), "\n")
  for dir in dir_list
    if globpath(dir, '*') ==# ''
      call delete(dir, 'd')
    endif
  endfor
  if globpath(rootpath . '/after/ftplugin', '*') ==# ''
    call delete(rootpath . '/after/ftplugin', 'd')
  endif
  if globpath(rootpath . '/after', '*') ==# ''
    call delete(rootpath . '/after', 'd')
  endif
  if a:msg
    echohl WarningMsg | echom '[kimbox] Cleaned ' . rootpath . '/after/ftplugin' | echohl None
  endif
endfunction "}}}
function! kimbox#ft_exists(path) "{{{
  return filereadable(kimbox#ft_rootpath(a:path) . '/after/ftplugin/text/kimbox.vim')
endfunction "}}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
