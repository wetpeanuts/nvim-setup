return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },

    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      telescope.setup({
        defaults = {
          path_display = {
            "truncate",
          },

          file_ignore_patterns = {
            "%.git/",
          },

          preview = {
            treesitter = false,
          },

          layout_strategy = "flex",

          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,

              ["<C-q>"] = function(prompt_bufnr)
                local picker = action_state.get_current_picker(prompt_bufnr)

                local prompt

                if _G.grep_word_buf then
                  prompt = _G.grep_word_buf
                elseif picker and picker._get_prompt then
                  prompt = picker:_get_prompt()
                end

                if prompt then
                  _G.qf_search_term = prompt
                end

                actions.send_to_qflist(prompt_bufnr)
                actions.open_qflist()
              end,
            },
          },
        },

        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })

      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, {
        desc = "Find files",
      })

      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
        desc = "Live grep",
      })

      vim.keymap.set("n", "<leader>fb", builtin.buffers, {
        desc = "Buffers",
      })

      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {
        desc = "Help tags",
      })
    end,
  },
}
