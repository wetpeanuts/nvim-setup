return {
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
}

