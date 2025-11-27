-- ============================================================
-- Minimalist Neovim Configuration
-- Focus: Efficient programming with essential tools
-- Stack: mini.nvim + LSP + Mason + Treesitter + Conform
-- ============================================================

-- ============================================================
-- BOOTSTRAP: mini.deps
-- ============================================================
local function bootstrap_deps()
    local path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.deps"
    if not vim.loop.fs_stat(path) then
        vim.fn.system({
            "git", "clone", "--filter=blob:none",
            "https://github.com/echasnovski/mini.deps",
            path,
        })
        vim.cmd("packadd mini.deps")
    end
end

bootstrap_deps()

local MiniDeps = require("mini.deps")
MiniDeps.setup()
local add = MiniDeps.add

-- ============================================================
-- UTILITY: Safe module loading
-- ============================================================
local function safe_require(module)
    local ok, mod = pcall(require, module)
    return ok and mod or nil
end

-- ============================================================
-- BASIC OPTIONS
-- ============================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Behavior
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 8

-- ============================================================
-- THEME: One Dark
-- ============================================================
add("navarasu/onedark.nvim")
add("nvim-tree/nvim-web-devicons")

local onedark = safe_require("onedark")
if onedark then
    onedark.setup({ style = "dark" })
    onedark.load()
end

-- ============================================================
-- MINI.NVIM: Essential modules
-- ============================================================

-- Snippets: Manage Snippets
add("echasnovski/mini.snippets")
local snippets = safe_require("mini.snippets")
if snippets then
    snippets.setup({})
end

-- Pick: Fuzzy finder
add("echasnovski/mini.pick")
local pick = safe_require("mini.pick")
if pick then
    pick.setup()
    vim.keymap.set("n", "<leader>ff", "<Cmd>Pick files<CR>", { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", "<Cmd>Pick grep_live<CR>", { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", "<Cmd>Pick buffers<CR>", { desc = "List buffers" })
    vim.keymap.set("n", "<leader>fh", "<Cmd>Pick help<CR>", { desc = "Search help" })
    vim.keymap.set("n", "<leader>fr", "<Cmd>Pick oldfiles<CR>", { desc = "Recent files" })
end

-- Files: File explorer
add("echasnovski/mini.files")
local files = safe_require("mini.files")
if files then
    files.setup({ windows = { preview = true, width_preview = 50 } })
    vim.keymap.set("n", "<leader>e", function()
        files.open(vim.api.nvim_buf_get_name(0))
    end, { desc = "File explorer" })
end

-- Statusline: Minimalist status line
add("echasnovski/mini.statusline")
local statusline = safe_require("mini.statusline")
if statusline then
    statusline.setup({ use_icons = true })
end

-- Completion: Auto-completion with LSP
add("echasnovski/mini.completion")
local completion = safe_require("mini.completion")
if completion then
    completion.setup({
        lsp_completion = {
            source_func = "omnifunc",
            auto_setup = true,
        },
        window = {
            info = { border = "rounded" },
            signature = { border = "rounded" },
        },
    })
end

-- Comment: Toggle comments
add("echasnovski/mini.comment")
local comment = safe_require("mini.comment")
if comment then
    comment.setup()
end

-- Cursorword: Highlight word under cursor
add("echasnovski/mini.cursorword")
local cursorword = safe_require("mini.cursorword")
if cursorword then
    cursorword.setup({ delay = 100 })
end

-- Bufremove: Close buffers without losing layout
add("echasnovski/mini.bufremove")
vim.keymap.set("n", "<leader>bd", function()
    local ok, bufremove = pcall(require, "mini.bufremove")
    if ok then bufremove.delete() end
end, { desc = "Close buffer" })

-- Pairs: Auto-close brackets, quotes, etc.
add("echasnovski/mini.pairs")
local pairs = safe_require("mini.pairs")
if pairs then
    pairs.setup()
end

-- Surround: Manipulate surrounding pairs
add("echasnovski/mini.surround")
local surround = safe_require("mini.surround")
if surround then
    surround.setup()
end

-- ============================================================
-- TREESITTER: Parsing and syntax highlighting
-- ============================================================
add("nvim-treesitter/nvim-treesitter")

local ts = safe_require("nvim-treesitter.configs")
if ts then
    ts.setup({
        ensure_installed = {
            "lua", "vim", "vimdoc",
            "c", "cpp",
            "python",
            "javascript", "typescript", "tsx",
            "html", "css",
            "json", "yaml",
            "markdown", "markdown_inline",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
    })
end

-- ============================================================
-- LSP: Language Server Protocol configuration
-- ============================================================
add("williamboman/mason.nvim")
add("williamboman/mason-lspconfig.nvim")
add("neovim/nvim-lspconfig")

-- Initialize Mason
local mason = safe_require("mason")
if mason then
    mason.setup({
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })
end

-- LSP automatic installation
local mason_lsp = safe_require("mason-lspconfig")
if mason_lsp then
    mason_lsp.setup({
        ensure_installed = {
            "clangd",  -- C/C++
            "pyright", -- Python
            "ts_ls",   -- TypeScript/JavaScript
        },
        automatic_installation = true,
    })
end

-- LSP Configuration
-- Check if vim.lsp.config is available (Nvim 0.11+)
if vim.lsp.config then
    -- Keymaps on LSP attach
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                vim.tbl_extend("force", opts, { desc = "Go to definition" }))
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
                vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
            vim.keymap.set("n", "gr", vim.lsp.buf.references,
                vim.tbl_extend("force", opts, { desc = "References" }))
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                vim.tbl_extend("force", opts, { desc = "Implementation" }))
            vim.keymap.set("n", "K", vim.lsp.buf.hover,
                vim.tbl_extend("force", opts, { desc = "Documentation" }))
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
                vim.tbl_extend("force", opts, { desc = "Rename" }))
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
                vim.tbl_extend("force", opts, { desc = "Code action" }))
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float,
                vim.tbl_extend("force", opts, { desc = "Floating diagnostic" }))
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
                vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
                vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        end,
    })

    -- Server configuration
    local servers = { "clangd", "pyright", "ts_ls" }
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    for _, server in ipairs(servers) do
        vim.lsp.config(server, {
            capabilities = capabilities,
        })
    end
end

-- ============================================================
-- FORMATTING: Conform.nvim
-- ============================================================
add("stevearc/conform.nvim")

local conform = safe_require("conform")
if conform then
    conform.setup({
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            c = { "clang-format" },
            cpp = { "clang-format" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    })

    vim.keymap.set("n", "<leader>fm", function()
        conform.format({ async = false, lsp_fallback = true })
    end, { desc = "Format file" })
end

-- ============================================================
-- GIT: Integration with gitsigns
-- ============================================================
add("lewis6991/gitsigns.nvim")

local gitsigns = safe_require("gitsigns")
if gitsigns then
    gitsigns.setup({
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
    })
end

-- ============================================================
-- TERMINAL: Toggleterm
-- ============================================================
add("akinsho/toggleterm.nvim")

local toggleterm = safe_require("toggleterm")
if toggleterm then
    toggleterm.setup({
        size = 20,
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = { border = "curved" },
    })
end

-- ============================================================
-- INDENT GUIDES
-- ============================================================
add("lukas-reineke/indent-blankline.nvim")

local indent = safe_require("ibl")
if indent then
    indent.setup({
        indent = { char = "│" },
        scope = { enabled = true },
    })
end

-- ============================================================
-- DASHBOARD: Start screen
-- ============================================================
add("goolord/alpha-nvim")

local alpha = safe_require("alpha")
local dashboard = safe_require("alpha.themes.dashboard")
if alpha and dashboard then
    dashboard.section.header.val = {
        "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██║   ██║██║████╗ ████║",
        "██╔██╗ ██║██║   ██║██║██╔████╔██║",
        "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    }

    dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "  Find file", ":lua require('mini.pick').builtin.files()<CR>"),
        dashboard.button("r", "  Recent files", ":lua require('mini.pick').builtin.oldfiles()<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    alpha.setup(dashboard.config)
end

-- ============================================================
-- GENERAL KEYMAPS
-- ============================================================

-- Save and quit
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":qa<CR>", { desc = "Quit all" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Buffer navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Better indentation in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Clear search
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear search" })

-- Keep cursor centered when navigating
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search" })

-- ============================================================
-- AUTOCOMMANDS
-- ============================================================

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- ============================================================
-- END OF CONFIGURATION
-- ============================================================
