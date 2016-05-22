" dein

if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.dein/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('scrooloose/nerdtree')

call dein#end()

filetype plugin indent on


" Settings

if has("syntax")
    syntax on
endif

set showmatch
set mouse=a
set number
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set autoindent
set whichwrap=b,s,[,],<,>
set clipboard=unnamed,autoselect
set backspace=indent,eol,start

let g:sh_indent_case_labels=1

nnoremap <silent><C-e> :NERDTreeToggle<CR>

