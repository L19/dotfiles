" ------------------------------------------
" Basic settings
" ------------------------------------------
" highlight corresponding brackets
set showmatch
set matchtime=1
" display lines on the present row
set cursorline
" display lines on the present column
set cursorcolumn
" show row numbers
set number
" replace tabs by spaces
set tabstop=2
set shiftwidth=2
set expandtab
" indent contexts automatically
set smartindent
set autoindent
"
set whichwrap=b,s,h,l,[,],<,>
" use clipboard in Vim
set clipboard+=unnamedplus
" delete text by using backspace
set backspace=indent,eol,start
" search texts
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split
" highlight found texts
set hlsearch
" use spell check
set spell
set spelllang=en,cjk
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline,bold
" change color scheme
" set termguicolors
set background=dark
colorscheme tender

set display=lastline
set pumheight=10
set swapfile directory=~/.cache/swapfiles
set backup backupdir=~/.cache/backups
" ------------------------------------------
" Key bind
" ------------------------------------------
" input the corresponding brackets automatically
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<Left>
inoremap $ $$<Left>
" split windows
nnoremap <silent> <S-j> :split<CR>
nnoremap <silent> <S-l> :vsplit<CR>
nnoremap <Bar> $:let pos = getpos(".")<CR>:join<CR>:call setpos('.', pos)<CR>))$
" move windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" switch normal mode and save the file by 'jj'
inoremap <silent> jj <ESC>:<C-u>w<CR>
" replace ';' by ':' in normal mode
nnoremap ; :
nnoremap : ;

nnoremap Y y$
nnoremap + <C-a>
nnoremap - <C-x>

nnoremap <ESC><ESC> :noh<CR>

" ------------------------------------------
" dein settings
" ------------------------------------------
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  let g:config_dir  = expand('~/.config/nvim/toml')
  let s:toml        = g:config_dir . '/plugins.toml'
  let s:lazy_toml   = g:config_dir . '/plugins_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
