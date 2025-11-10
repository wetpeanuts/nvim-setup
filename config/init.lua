local project_setup = require('utils.project_setup')

-- Try load project specific setup from .nvim/setup.lua
project_setup.try_load_project_setup()

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
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

vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all yank/paste/change

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

vim.keymap.set('n', '<leader>nt', ':tabnew<CR>', { noremap = true, silent = true })

-- Show LSP error
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show full LSP error message" })

-- Go to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })

-- Make 'd' delete without saving (blackhole register)
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })

