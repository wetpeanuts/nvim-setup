-- Set space as leader key
vim.g.mapleader = ' '

-- Try load project specific setup from .nvim/setup.lua
local load_project_setup = require('project_utils.load_setup')
local welcome_config = load_project_setup.try_load_project_setup()

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
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load friendly-snippets or your snippet collection
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-c>"] = cmp.mapping.complete(),
          ["<C-a>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = 'nvim_lua' },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        completion = {
          autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged }
        },
        experimental = {
          ghost_text = true,  -- Show preview of completion inline (optional)
        },
      })
    end,
  },
})

-- Enable syntax highlighting and filetype
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Init custom keymap
local default_bindings = require("common_utils.default_bindings")

default_bindings.init()
default_bindings.populate_config(welcome_config)

-- Init welcome floating window
local welcome = require("common_utils.welcome")
welcome.init_welcome_win(welcome_config)

local opened_files = require("project_utils.opened_files")
opened_files.init()

-- local lua_ls_config = require('lsp.lua_ls')  -- adjust path accordingly
-- 
-- vim.lsp.config('lua_ls', lua_ls_config)
vim.lsp.enable({'lua_ls'})
