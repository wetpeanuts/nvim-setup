local M = {}

function M.init()
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
  
  vim.keymap.set('n', '<leader>h', "<cmd>lua require('common_utils.welcome').toggle_welcome()<CR>", { noremap = true, silent = true })
end

function M.populate_config(config)
  config.default_bindings = {
    { icon = "", description = "Show/hide directory explorer", binding = "_t" },
    { icon = "󰋖", description = "Show/hide this help message", binding = "_h" },
  }
end

return M
