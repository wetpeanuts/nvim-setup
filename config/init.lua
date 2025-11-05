-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.o.number = true             -- Show line numbers
vim.o.relativenumber = true     -- Relative line numbers
vim.o.tabstop = 4               -- Number of spaces per tab
vim.o.shiftwidth = 4            -- Size of an indent
vim.o.expandtab = true          -- Use spaces instead of tabs
vim.o.smartindent = true        -- Auto-indent new lines
vim.o.wrap = false              -- Disable line wrap
vim.o.cursorline = true         -- Highlight current line
vim.o.termguicolors = true      -- Enable true color support

-- Leader key
vim.g.mapleader = ' '           -- Space as leader key

-- Initialize lazy.nvim plugin manager with plugins
require("lazy").setup({
  -- Utility plugins
  "nvim-lua/plenary.nvim",

  -- Catppuccin theme plugin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Available: latte, frappe, macchiato, mocha
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
  },
--   {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--       "williamboman/mason.nvim",
--       "williamboman/mason-lspconfig.nvim",
--     },
--     event = { "BufReadPre", "BufNewFile" },  -- Load when opening a file
--     config = function()
--       require("mason").setup()
--       require("mason-lspconfig").setup({
--         ensure_installed = { "clangd" },
--       })
-- 
--       local lspconfig = require("lspconfig")
--       lspconfig.clangd.setup({
--         cmd = { 'clangd', '--background-index', '--clang-tidy', '--header-insertion=iwyu' },
--         filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
--         root_dir = lspconfig.util.root_pattern('compile_commands.json', 'compile_flags.txt', '.git'),
--         capabilities = vim.lsp.protocol.make_client_capabilities(),
--         init_options = {
--           fallbackFlags = { '-std=c++20' },  -- or your desired standard
--         }, 
--       })
--     end,
--   },
})

vim.lsp.enable({'clangd'})

-- Enable syntax highlighting and filetype
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Hotkeys
-- Directory tree view
vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>", { noremap = true, silent = true })

-- Window navigation with <leader>w[direction]
vim.keymap.set('n', '<leader>wj', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ww', '<C-w><C-w>', { noremap = true, silent = true })

-- Window splits with <leader>s[direction]
vim.keymap.set('n', '<leader>sh', '<C-w>s', { noremap = true, silent = true }) -- horizontal split
vim.keymap.set('n', '<leader>sv', '<C-w>v', { noremap = true, silent = true }) -- vertical split

-- Show/hide LSP error
-- local diag = require("myutils.diagnostics")
-- vim.keymap.set('n', '<leader>e', diag.toggle_diagnostic, { desc = "Toggle LSP diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show full LSP error message" })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })

-- Load custom project setup if present
local uv = vim.loop
local project_nvim_config = vim.fn.getcwd() .. "/.nvim/setup.lua"

if uv.fs_stat(project_nvim_config) then
  vim.notify("Project setup found")
  dofile(project_nvim_config)
end
