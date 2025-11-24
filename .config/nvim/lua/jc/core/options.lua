-- General Neovim settings and coonfiguration

local g = vim.g
local o = vim.o
local opt = vim.opt

-- General
o.mouse = 'a'
o.clipboard = 'unnamedplus'
o.cursorline = true
o.cursorlineopt = "number"
o.swapfile = false
o.completeopt = 'menuone,noinsert,noselect'

-- Neovim UI
o.number = true
o.relativenumber = true
o.showmatch = true
o.foldmethod = 'marker'
o.colorcolumn = '80'
o.splitright = true
o.splitbelow = true
o.ignorecase = true
o.smartcase = true
o.linebreak = true
o.termguicolors = true
o.laststatus = 3

-- Tabs, indent
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

-- Memory, CPU
o.hidden = true
o.history = 100
o.lazyredraw = true
o.synmaxcol = 240
o.updatetime = 250

-- Startup
opt.shortmess:append "sI"

-- Disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
   "tutor",
   "rplugin",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end
