" Jean Carlos (JC)
" Vim settings (https://www.vim.org)

" Plugins
" Install vim-plug
" Install plugins: Command PlugInstall
call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
call plug#end()

" General settings
set nocompatible
syntax on
set termguicolors
colorscheme gruvbox
set background=dark
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set mouse=a
set encoding=utf-8
filetype plugin indent on
set lazyredraw
set ttyfast
set cursorline
set colorcolumn=80
set signcolumn=yes

" Keymaps
" Files & search
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
" Buffer navigation
nnoremap <leader>h :bprev<CR>
nnoremap <leader>l :bnext<CR>
