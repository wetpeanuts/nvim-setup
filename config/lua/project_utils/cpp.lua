local M = {}

local function bind_term_cmd(binding, cmd)
  vim.notify('Binding ' .. binding .. ' to "' .. cmd .. '"')
  -- vim.keymap.set('n', binding, '', {
  --   noremap = true,
  --   silent = true,
  --   callback = function()
  --     vim.cmd('belowright 10split')
  --     vim.cmd('terminal ' .. cmd)
  --   end
  -- })
  
  vim.keymap.set('n', binding,
    ':belowright 10split | terminal ' .. cmd .. '<CR>',
    { noremap = true, silent = true }
  )
end

function M.init(config)
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
