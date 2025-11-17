" ~/.vimrc
" Jean Carlos
" https://github.com/jeancarlos-ing
" A customized .vimrc for vim (https://www.vim.org/)

set nocompatible
filetype off

" Managing Plugins
call plug#begin('~/.vim/plugged')
	
call plug#end()

filetype plugin indent on

" General Settings
set path+=**
set wildmenu
set incsearch
set hidden
set nobackup
set noswapfile
set t_Co=256
set number relativenumber
set clipboard=unnamedplus
syntax enable
let g:rehash256 = 1
set termguicolors
set cursorline
set colorcolumn=80
set signcolumn=yes
set backspace=indent,eol,start
set showmatch
set ruler
set showcmd
set laststatus=2

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan

set wrap
set linebreak
set scrolloff=5
set sidescrolloff=5
set mouse=a
set showtabline=2

set formatoptions-=cro
set foldlevel=99
set foldmethod=indent

set splitright
set splitbelow

