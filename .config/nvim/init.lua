vim.g.mapleader = ' '
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.foldmethod = 'expr'
vim.opt.colorcolumn = '80'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.foldlevel = 99
vim.opt.conceallevel = 0
vim.opt.termguicolors = true
vim.o.cursorline = true
vim.o.number = true
vim.o.termguicolors = true
vim.opt.hidden = true
vim.opt.history = 1000
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 1000
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

-- don't auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
  end,
  group = vim.api.nvim_create_augroup("yank_highlight", {}),
})

