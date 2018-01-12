" ----------------------------------------------
" プラグインの管理
" ----------------------------------------------

" deinが未インストールの場合はインストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

call dein#begin(expand('~/.vim/dein'))

call dein#add('kannokanno/previm')
call dein#add('plasticboy/vim-markdown')
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler')
call dein#add('tpope/vim-surround')
call dein#add('tyru/open-browser.vim')
call dein#add('lervag/vimtex')
call dein#add('itchyny/vim-parenmatch')
call dein#add('vim-scripts/twilight')
call dein#add('sjl/badwolf')

call dein#end()

filetype plugin indent on

" -----------------------------------------------
" 一般設定
" -----------------------------------------------
if has("syntax")
  syntax on
endif

if !isdirectory("~/.vim/backups")
  call system("mkdir ~/.vim/backups")
endif

if !isdirectory("~/.vim/swapfiles")
  call system("mkdir ~/.vim/swapfiles")
endif

set showmatch
set hlsearch
set number
set tabstop=2
set expandtab
set shiftwidth=2
set smartindent
set autoindent
set whichwrap=b,s,h,l,[,],<,>
set clipboard+=unnamed,autoselect
set backspace=indent,eol,start
set swapfile directory=~/.vim/swapfiles
set backup backupdir=~/.vim/backups
set list listchars=tab:>-,trail:_
set ambiwidth=double
set spell
set spelllang=en,cjk
hi clear SpellBad
hi SpellBad cterm=underline,bold

"" 外部grepを使用する
" set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
" set grepprg=grep -nh

let g:sh_indent_case_labels=1
let g:vim_markdown_folding_disabled=1
let g:loaded_matchparen = 1

" -------------------------------------------------
" コーディング
" -------------------------------------------------
"" 自動的に閉じる
" imap { {}<LEFT>
" imap [ []<LEFT>
" imap ( ()<LEFT>

"" カーソル位置を保存する
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"" 線を引く
inoreabbrev <expr> dl repeat('*', 80 - col('.'))

" PHPのシンタックスチェック
augroup phpsyntaxcheck
  autocmd!
  autocmd BufWrite *.php w !php -l
augroup END

" ---------------------------------------------------
" プラグインの設定
" ---------------------------------------------------

"" Vimfiler
let g:vimfiler_as_default_explorer=1

"" vimtex
let g:tex_flavor = "latex"

let g:vimtex_compiler_enabled = 1
let g:vimtex_compiler_options = '-pdfdvi'
let g:vimtex_compiler_continuous = 1
let g:vimtex_compiler_background = 1
let g:vimtex_compiler_callback = 1
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer
      \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
  if !a:status | return | endif

  let l:out = b:vimtex.out()
  let l:tex = expand('%:p')
  let l:cmd = [g:vimtex_view_general_viewer, '-r']
  if !empty(system('pgrep Skim'))
    call extend(l:cmd, ['-g'])
  endif
  if has('nvim')
    call jobstart(l:cmd + [line('.'), l:out, l:tex])
  elseif has('job')
    call job_start(l:cmd + [line('.'), l:out, l:tex])
  else
    call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
  endif
endfunction

let g:vimtex_toc_split_pos = "topleft"
let g:vimtex_toc_width = 10

let g:vimtex_matchparen_enabled = 0

" for neocomplete
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex = '\\ref{\s*[0-9A-Za-z_:]*'
let g:neocomplete#sources#omni#input_patterns.tex = '\\cite{\s*[0-9A-Za-z_:]*\|\\ref{\s*[0-9A-Za-z_:]*'

" ----------------------------------------------------
" キーバインド
" ----------------------------------------------------
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>
vnoremap < <gv
vnoremap > >gv

" ------------------------------------------------------------------------
" その他の設定ファイル
" ------------------------------------------------------------------------
if has('mac')

elseif has('unix')

endif

" neocompleteの設定読み込み
if version >= 704 && has('lua')
  source ~/.vim/vimrc.d/vim74.vimrc
endif

