local M = {}

-- local function bind_term_cmd(binding, cmd)
--   -- vim.notify('Binding ' .. binding .. ' to "' .. cmd .. '"')
--   -- vim.keymap.set('n', binding, '', {
--   --   noremap = true,
--   --   silent = true,
--   --   callback = function()
--   --     vim.cmd('belowright 10split')
--   --     vim.cmd('terminal ' .. cmd)
--   --   end
--   -- })
-- 
--   vim.keymap.set('n', binding,
--     ':belowright 10split | terminal ' .. cmd .. '<CR>',
--     { noremap = true, silent = true }
--   )
-- end

local function bind_term_cmd(binding, cmd)
  vim.keymap.set('n', binding, function()
    -- Find existing terminal buffer
    local term_buf = nil
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'terminal' then
        term_buf = buf
        break
      end
    end

    if not term_buf then
      -- No terminal found, open split with terminal
      vim.cmd('belowright 10split')
      vim.cmd('terminal')
      term_buf = vim.api.nvim_get_current_buf()
    end

    if term_buf then
      -- Send command to existing terminal (use <C-\><C-n> to ensure normal mode)
      vim.api.nvim_set_option_value('modifiable', true, { buf = term_buf })
      vim.api.nvim_buf_set_lines(term_buf, -1, -1, false, {''})  -- Newline
      vim.api.nvim_set_option_value('modifiable', false, { buf = term_buf })
      vim.api.nvim_chan_send(vim.api.nvim_buf_get_var(term_buf, 'terminal_job_id'), cmd .. '\n')
      vim.notify('Sent "' .. cmd .. '" to existing terminal')
    else
      -- Open new terminal
      vim.cmd('belowright 10split | terminal ' .. cmd)
    end
  end, { noremap = true, silent = true })
end

function M.init(config)
  vim.g.cpp_config = config
  vim.lsp.enable({'clangd'})

  -- Init project specific keymap
  bind_term_cmd('<leader>cc', config.CPP_CONFIG_CMD)
  bind_term_cmd('<leader>cb', config.CPP_BUILD_CMD)
  bind_term_cmd('<leader>cr', config.CPP_RUN_CMD)
  bind_term_cmd('<leader>ct', config.CPP_TEST_CMD)

  return {
    project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
    project_desc = "Cpp project",
    custom_bindings = {
      { icon = "", description = "Configure CMake", binding = "_cc" },
      { icon = "󰣪", description = "Build project", binding = "_cb" },
      { icon = "", description = "Run executable", binding = "_cr" },
      { icon = "󰙨", description = "Run tests", binding = "_ct" },
    }
  }
end

return M
