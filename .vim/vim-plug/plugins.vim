call plug#begin('~/.vim/plugged')
    " Comment code
    Plug 'tpope/vim-commentary'
    " Syntax support
    Plug 'sheerun/vim-polyglot'
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Autopairs
    Plug 'jiangmiao/auto-pairs'
    " File explorer
    Plug 'scrooloose/NERDTree'    
    " Icons
    Plug 'ryanoasis/vim-devicons'
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
   " Git integration
    Plug 'mhinz/vim-signify'
    " Autoclose tags
    Plug 'alvan/vim-closetag'
    " Fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    " Prettier
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    " Themes
    Plug 'morhetz/gruvbox'
call plug#end()
