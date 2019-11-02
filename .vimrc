" ----------------------------------------------
" プラグインの管理
" ----------------------------------------------
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

"   call dein#add('altercation/vim-colors-solarized')
"   call dein#add('davidhalter/jedi-vim')
"   call dein#add('kannokanno/previm')
"   call dein#add('plasticboy/vim-markdown')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimfiler')
"   call dein#add('tpope/vim-surround')
"   call dein#add('tyru/open-browser.vim')
  call dein#add('lervag/vimtex')
"   call dein#add('itchyny/vim-parenmatch')
"   call dein#add('vim-scripts/twilight')
"   call dein#add('sjl/badwolf')
"   call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#add('Shougo/neco-vim')
  call dein#add('Shougo/neco-syntax')
  call dein#add('poppyschmo/deoplete-latex')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" -----------------------------------------------
" 一般設定
" -----------------------------------------------
if has("syntax")
  syntax on
endif

if !isdirectory("~/.cache/backups")
  call system("mkdir ~/.cache/backups")
endif

if !isdirectory("~/.cache/swapfiles")
  call system("mkdir ~/.cache/swapfiles")
endif

set showmatch
set hlsearch
set cursorline
set number
set tabstop=2
set expandtab
set shiftwidth=2
set smartindent
set autoindent
set whichwrap=b,s,h,l,[,],<,>
set clipboard+=unnamed,autoselect
set backspace=indent,eol,start
set swapfile directory=~/.cache/swapfiles
set backup backupdir=~/.cache/backups
set list listchars=tab:>-,trail:_
set ambiwidth=double
set spell
set spelllang=en,cjk
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline,bold
set formatoptions+=mM
set textwidth=0

"" 外部grepを使用する
" set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
" set grepprg=grep -nh

let g:sh_indent_case_labels=1
let g:vim_markdown_folding_disabled=1
let g:loaded_matchparen = 1

"" ステータスライン
set statusline=%F
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[ROW=%l/%L]
set laststatus=2

" let &colorcolumn=join(range(81,999),",")
" hi ColorColumn ctermbg=235 guibg=#2c2d27

" -------------------------------------------------
" コーディング
" -------------------------------------------------
"" カーソル位置を保存する
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal g`\"" | endif
endif

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
" autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit
" autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit
nnoremap <silent> <Leader>z :<C-u>VimFilerBufferDir -split -simple -winwidth=30 -toggle -no-quit<CR>

"" vimtex
let g:tex_flavor = "latex"
let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }
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
autocmd BufReadPre *.tex let b:vimtex_main = 'main.tex'


" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" jedi-vim
set completeopt=menuone                        " 補完候補を呼び出すとき常にポップアップメニューを使う
autocmd! User jedi-vim call s:jedivim_hook()   " vim-plugの遅延ロード呼び出し
function! s:jedivim_hook()              " jedi-vimを使うときだけ呼び出す処理を関数化
  let g:jedi#auto_initialization    = 0 " 自動で実行される初期化処理を無効
  let g:jedi#auto_vim_configuration = 0 " 'completeopt' オプションを上書きしない
  let g:jedi#popup_on_dot           = 0 " ドット(.)を入力したとき自動で補完しない
  let g:jedi#popup_select_first     = 0 " 補完候補の1番目を選択しない
  let g:jedi#show_call_signatures   = 0 " 関数の引数表示を無効(ポップアップのバグを踏んだことがあるため)
  autocmd FileType python setlocal omnifunc=jedi#completions   " 補完エンジンはjediを使う
endfunction
" ----------------------------------------------------
" キーバインド
" ----------------------------------------------------

inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<Left>
inoremap $ $$<Left>

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
nnoremap sy :<C-u>Unite history/yank<CR>
nnoremap sb :<C-u>Unite buffer<CR>
nnoremap sf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap srr :<C-u>Unite -buffer-name=register register<CR>
nnoremap su :<C-u>Unite file_mru buffer<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>
vnoremap < <gv
vnoremap > >gv

" ノーマルモード時だけ ; と : を入れ替える
nnoremap ; :
nnoremap : ;

" ------------------------------------------------------------------------
" その他の設定ファイル
" ------------------------------------------------------------------------
if has('mac')

elseif has('unix')

endif

" " neocompleteの設定読み込み
" if version >= 704 && has('lua')
"   source ~/.vim/vimrc.d/vim74.vimrc
" endif
" 
