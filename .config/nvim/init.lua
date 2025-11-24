--============================
-- PERSONAL SETTINGS NEOVIM
-- ===========================

-- Import lua modules
require('jc/core/lazy')
require('jc/core/autocmds')
require('jc/core/keymaps')
require('jc/core/colors')
require('jc/core/statusline')
require('jc/core/options')
require('jc/plugins/nvim-tree')
require('jc/plugins/indent-blankline')
require('jc/plugins/nvim-cmp')
require('jc/plugins/nvim-treesitter')
require('jc/plugins/alpha-nvim')

-- Enable LSP
vim.lsp.enable({
  'bashls',
  'pyright',
  'clangd',
  'html',
  'cssls',
  'ts_ls'
})
