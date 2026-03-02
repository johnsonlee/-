" Vim colorscheme based on iTerm2 Tango Dark palette
" Maintainer: johnsonlee

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "tango-dark"

" Tango Dark palette:
" Black:          #2e3436 / Bright: #555753
" Red:            #cc0000 / Bright: #ef2929
" Green:          #4e9a06 / Bright: #8ae234
" Yellow:         #c4a000 / Bright: #fce94f
" Blue:           #3465a4 / Bright: #729fcf
" Magenta:        #75507b / Bright: #ad7fa8
" Cyan:           #06989a / Bright: #34e2e2
" White:          #d3d7cf / Bright: #eeeeec
" Background:     #000000
" Foreground:     #d3d7cf

" --- General ---
hi Normal        guifg=#d3d7cf guibg=#000000 ctermfg=252  ctermbg=NONE
hi NonText       guifg=#555753 guibg=NONE    ctermfg=240  ctermbg=NONE
hi SpecialKey    guifg=#555753 guibg=NONE    ctermfg=240  ctermbg=NONE
hi Cursor        guifg=#000000 guibg=#d3d7cf
hi CursorLine    guibg=#1c1c1c ctermbg=234   cterm=NONE   gui=NONE
hi CursorColumn  guibg=#1c1c1c ctermbg=234
hi ColorColumn   guibg=#1c1c1c ctermbg=234
hi LineNr        guifg=#555753 guibg=NONE    ctermfg=240  ctermbg=NONE
hi CursorLineNr  guifg=#fce94f guibg=NONE    ctermfg=227  ctermbg=NONE gui=bold cterm=bold
hi SignColumn    guibg=NONE    ctermbg=NONE

" --- Search ---
hi Search        guifg=#000000 guibg=#fce94f ctermfg=0    ctermbg=227
hi IncSearch     guifg=#000000 guibg=#c4a000 ctermfg=0    ctermbg=178

" --- Window elements ---
hi StatusLine    guifg=#eeeeec guibg=#2e3436 ctermfg=255  ctermbg=236  gui=bold cterm=bold
hi StatusLineNC  guifg=#555753 guibg=#2e3436 ctermfg=240  ctermbg=236  gui=NONE cterm=NONE
hi VertSplit     guifg=#2e3436 guibg=#2e3436 ctermfg=236  ctermbg=236
hi TabLine       guifg=#d3d7cf guibg=#2e3436 ctermfg=252  ctermbg=236  gui=NONE cterm=NONE
hi TabLineSel    guifg=#eeeeec guibg=#000000 ctermfg=255  ctermbg=0    gui=bold cterm=bold
hi TabLineFill   guifg=#555753 guibg=#2e3436 ctermfg=240  ctermbg=236
hi Title         guifg=#eeeeec gui=bold      ctermfg=255  cterm=bold
hi Visual        guibg=#3465a4 ctermbg=61
hi MatchParen    guifg=#eeeeec guibg=#555753 ctermfg=255  ctermbg=240  gui=bold cterm=bold

" --- Popup menu ---
hi Pmenu         guifg=#d3d7cf guibg=#2e3436 ctermfg=252  ctermbg=236
hi PmenuSel      guifg=#eeeeec guibg=#3465a4 ctermfg=255  ctermbg=61
hi PmenuSbar     guibg=#2e3436 ctermbg=236
hi PmenuThumb    guibg=#555753 ctermbg=240

" --- Folding ---
hi Folded        guifg=#729fcf guibg=#1c1c1c ctermfg=110  ctermbg=234
hi FoldColumn    guifg=#729fcf guibg=NONE    ctermfg=110  ctermbg=NONE

" --- Diff ---
hi DiffAdd       guifg=NONE    guibg=#1a3a0a ctermfg=NONE ctermbg=22
hi DiffChange    guifg=NONE    guibg=#2a2a00 ctermfg=NONE ctermbg=58
hi DiffDelete    guifg=#cc0000 guibg=#3a0a0a ctermfg=160  ctermbg=52
hi DiffText      guifg=NONE    guibg=#4a4a00 ctermfg=NONE ctermbg=100  gui=bold cterm=bold

" --- Messages ---
hi ErrorMsg      guifg=#ef2929 guibg=NONE    ctermfg=196  ctermbg=NONE gui=bold cterm=bold
hi WarningMsg    guifg=#fce94f guibg=NONE    ctermfg=227  ctermbg=NONE
hi MoreMsg       guifg=#8ae234 guibg=NONE    ctermfg=113  ctermbg=NONE
hi Question      guifg=#8ae234 guibg=NONE    ctermfg=113  ctermbg=NONE
hi ModeMsg       guifg=#d3d7cf gui=bold      ctermfg=252  cterm=bold

" --- Spelling ---
hi SpellBad      guisp=#ef2929 gui=undercurl cterm=underline ctermfg=196
hi SpellCap      guisp=#729fcf gui=undercurl cterm=underline ctermfg=110
hi SpellRare     guisp=#ad7fa8 gui=undercurl cterm=underline ctermfg=139
hi SpellLocal    guisp=#34e2e2 gui=undercurl cterm=underline ctermfg=86

" --- Syntax ---
hi Comment       guifg=#555753 ctermfg=240   gui=italic cterm=italic
hi Constant      guifg=#ef2929 ctermfg=196
hi String        guifg=#8ae234 ctermfg=113
hi Character     guifg=#8ae234 ctermfg=113
hi Number        guifg=#ef2929 ctermfg=196
hi Boolean       guifg=#ef2929 ctermfg=196
hi Float         guifg=#ef2929 ctermfg=196
hi Identifier    guifg=#34e2e2 ctermfg=86    gui=NONE cterm=NONE
hi Function      guifg=#fce94f ctermfg=227
hi Statement     guifg=#729fcf ctermfg=110   gui=bold cterm=bold
hi Conditional   guifg=#729fcf ctermfg=110   gui=bold cterm=bold
hi Repeat        guifg=#729fcf ctermfg=110   gui=bold cterm=bold
hi Label         guifg=#729fcf ctermfg=110   gui=bold cterm=bold
hi Operator      guifg=#d3d7cf ctermfg=252
hi Keyword       guifg=#729fcf ctermfg=110   gui=bold cterm=bold
hi Exception     guifg=#729fcf ctermfg=110   gui=bold cterm=bold
hi PreProc       guifg=#ad7fa8 ctermfg=139
hi Include       guifg=#ad7fa8 ctermfg=139
hi Define        guifg=#ad7fa8 ctermfg=139
hi Macro         guifg=#ad7fa8 ctermfg=139
hi PreCondit     guifg=#ad7fa8 ctermfg=139
hi Type          guifg=#8ae234 ctermfg=113   gui=bold cterm=bold
hi StorageClass  guifg=#c4a000 ctermfg=178
hi Structure     guifg=#8ae234 ctermfg=113   gui=bold cterm=bold
hi Typedef       guifg=#8ae234 ctermfg=113   gui=bold cterm=bold
hi Special       guifg=#c4a000 ctermfg=178
hi SpecialChar   guifg=#c4a000 ctermfg=178
hi Tag           guifg=#729fcf ctermfg=110
hi Delimiter     guifg=#d3d7cf ctermfg=252
hi Debug         guifg=#ef2929 ctermfg=196
hi Underlined    guifg=#729fcf ctermfg=110   gui=underline cterm=underline
hi Ignore        guifg=#555753 ctermfg=240
hi Error         guifg=#eeeeec guibg=#cc0000 ctermfg=255  ctermbg=160
hi Todo          guifg=#000000 guibg=#fce94f ctermfg=0    ctermbg=227  gui=bold cterm=bold

" --- NERDTree ---
hi Directory     guifg=#729fcf ctermfg=110
