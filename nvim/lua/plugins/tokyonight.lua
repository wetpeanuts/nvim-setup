return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon", -- storm | moon | night | day
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        -- keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
      on_highlights = function(hl, c)
        hl["@type"]         = { fg = c.blue2 }
        hl["@type.builtin"] = { fg = c.blue2, italic = true }
        hl["@module"]       = { fg = c.blue2 }
        hl["@namespace"]    = { fg = c.blue2 } -- nvim < 0.9 compat

        hl["@lsp.typemod.type.defaultLibrary"]         = { fg = c.blue2 }
        hl["@lsp.typemod.class.defaultLibrary"]        = { fg = c.blue2 }
        hl["@lsp.type.typeParameter.cpp"]              = { fg = c.blue2 }
        hl["@lsp.typemod.function.defaultLibrary.cpp"] = { fg = c.blue }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },
}

