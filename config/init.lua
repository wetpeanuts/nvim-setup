-- Set space as leader key
vim.g.mapleader = ' '

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

vim.o.completeopt = "menu,menuone,noselect"

vim.opt.shortmess:append("I")     -- Disable the intro message
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all yank/paste/change

-- Initialize lazy.nvim plugin manager with plugins
require("lazy").setup("plugins")

-- Enable syntax highlighting and filetype
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- Init custom keymap
local default_bindings = require("common_utils.default_bindings")
default_bindings.init()

local env_utils = require("common_utils.env")
env_utils.init()

vim.lsp.enable({"lua_ls"})
vim.lsp.enable({"clangd", "cmake_ls"})
vim.lsp.enable({"rust_analyzer"})
