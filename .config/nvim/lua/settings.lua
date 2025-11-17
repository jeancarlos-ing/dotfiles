-- ==============================
-- Neovim settings
-- ==============================

-- Neovim API aliases
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local api = vim.api
local ag = api.nvim_create_augroup
local au = api.nvim_create_autocmd

-- General
g.mapleader = ' '
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = false

-- Neovim UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showmatch = true
opt.foldmethod = 'expr'
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true
opt.foldlevel = 99
opt.conceallevel = 0
opt.termguicolors = true
opt.guifont = "JetBrainsMono Nerd Font"

-- Folding
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Memory, CPU
opt.hidden = true
opt.history = 100
opt.synmaxcol = 1000

-- Tabs, indent
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0]]

-- highlight yanked text
au(
    "TextYankPost",
    {
        pattern = '*',
        callback = function()
            vim.highlight.on_yank { higroup = 'IncSearch', timeout = 700 }
        end,
        group = ag('yank_highlight', {}),
    }
)
