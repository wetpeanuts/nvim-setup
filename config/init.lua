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

-- vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal"

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
      buffers = {
        show_unloaded = true,  -- key fix for session-restored buffers
        follow_current_file = { enabled = true },
        bind_to_cwd = false,
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
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- post_restore_cmds = {
      --   function()
      --     local manager = require("neo-tree.sources.manager")
      --     local state = manager.get_state("buffers")
      --     require("neo-tree.sources.buffers.commands").refresh(state)
      --   end
      -- }
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          layout_strategy = "flex",
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })

      -- Load fzf extension for better performance
      telescope.load_extension("fzf")

      -- Keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/persistence.nvim" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local persistence = require("persistence")

      -- Header (customize as needed)
      dashboard.section.header.val = {
        " ███╗   ██╗ ███████╗ ██████╗ ██╗   ██╗ ██╗ ███╗   ███╗ ",
        " ████╗  ██║ ██╔════╝██╔═══██╗██║   ██║ ██║ ████╗ ████║ ",
        " ██╔██╗ ██║ █████╗  ██║   ██║██║   ██║ ██║ ██╔████╔██║ ",
        " ██║╚██╗██║ ██╔══╝  ██║   ██║╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ",
        " ██║ ╚████║ ███████╗╚██████╔╝ ╚████╔╝  ██║ ██║ ╚═╝ ██║ ",
        " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ",
      }

      -- Buttons
      dashboard.section.buttons.val = {
        dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "󰈗  Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("s", "  Restore session", function()
          persistence.load()
        end),
        dashboard.button("p", "  Find session", function ()
          persistence.select()
        end),
        dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }

      dashboard.section.footer.val = function()
        local cwd = vim.fn.getcwd()
        local truncated = vim.fn.fnamemodify(cwd, ":~")  -- Show relative to home (~)
        return "CWD: " .. truncated .. " | Loaded " .. vim.fn.len(vim.fn.globpath(vim.fn.stdpath("data") .. "/lazy", "*", 0, 1)) .. " plugins"
      end

      dashboard.section.footer.opts.hl = "Type"

      -- Styling
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"
      dashboard.section.buttons.opts.hl_shortcut = "Comment"

      dashboard.opts.opts.noautocmd = true
      dashboard.opts.opts.margin = 5
      dashboard.opts.opts.padding = 1

      -- Auto-restore session on startup (but show alpha first)
      persistence.setup({
        dir = vim.fn.stdpath("state") .. "/sessions/",
        autosave_silent = true,
      })

      -- Disable alpha when session is restored
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceSavedSession",
        callback = function()
          require("alpha").close()
        end,
      })

      alpha.setup(dashboard.opts)

      -- Disable folding in alpha buffer
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          vim.b.current_foldlevel = 999
          vim.opt_local.foldenable = false
        end,
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

vim.lsp.enable({'lua_ls'})
vim.lsp.enable({'clangd', 'cmake_ls'})
