local M = {}

local telescope = require('telescope.builtin')

local function grep_word_and_store()
  local word = vim.fn.expand('<cword>')
  _G.grep_word_buf = word
  telescope.grep_string({ search = word })
end

local function live_grep()
  _G.grep_word_buf = nil
  telescope.live_grep()
end

function M.init()
  -- Hotkeys
  -- Directory tree view
  vim.keymap.set("n", "<leader>t", ":Neotree toggle source=filesystem<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>o", ":Neotree toggle source=buffers<CR>", { noremap = true, silent = true })

  -- Window navigation with <leader>w[direction]
  vim.keymap.set('n', '<leader>wj', '<C-w>j', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>wk', '<C-w>k', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>wh', '<C-w>h', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>wl', '<C-w>l', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>ww', '<C-w><C-w>', { noremap = true, silent = true })

  vim.keymap.set('n', '<A-j>', '<C-w>j', { noremap = true, silent = true })
  vim.keymap.set('n', '<A-k>', '<C-w>k', { noremap = true, silent = true })
  vim.keymap.set('n', '<A-h>', '<C-w>h', { noremap = true, silent = true })
  vim.keymap.set('n', '<A-l>', '<C-w>l', { noremap = true, silent = true })


  -- Window splits with <leader>s[direction]
  vim.keymap.set('n', '<leader>sh', '<C-w>s', { noremap = true, silent = true }) -- horizontal split
  vim.keymap.set('n', '<leader>sv', '<C-w>v', { noremap = true, silent = true }) -- vertical split

  vim.keymap.set('n', '<leader>nt', ':tabnew<CR>', { noremap = true, silent = true })

  vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

  -- LSP
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show full LSP error message" })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = "Show hover in floating window"})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol under cursor" })

  -- Make 'd' delete without saving (blackhole register)
  vim.keymap.set({'n', 'x'}, 'd', '"_d', { noremap = true, silent = true })

  -- load the session for the current directory
  vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)
  -- select a session to load
  vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)
  -- load the last session
  vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)
  -- stop Persistence => session won't be saved on exit
  vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)

  vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
  vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
  vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move block down" })
  vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move block up" })

  vim.keymap.set('n', '<leader>fg', live_grep, { desc = 'Live Grep' })
  vim.keymap.set('n', '<leader>fw', grep_word_and_store, { desc = 'Grep Word' })
  vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find Files' })

  vim.keymap.set('n', '<leader>rr', function()
    local old_str = vim.fn.input('Find: ')
    local new_str = vim.fn.input('Replace ' .. old_str .. ' with: ')
    if #new_str == 0 then
      print("Replace cancelled")
      return
    end
    vim.cmd('cfdo %s/' .. vim.fn.escape(old_str, '/') .. '/' .. vim.fn.escape(new_str, '/')
      .. '/g | update')
  end, { desc = 'Replace in Quickfix' })

  vim.keymap.set('n', '<leader>rt', function()
    if not _G.qf_search_term or _G.qf_search_term == "" then
      print("No search term found")
      return
    end
    local new_str = vim.fn.input('Replace ' .. _G.qf_search_term .. ' with: ')
    if #new_str == 0 then
      print("Replace cancelled")
      return
    end
    vim.cmd('cfdo %s/' .. vim.fn.escape(_G.qf_search_term, '/') .. '/' .. vim.fn.escape(new_str, '/')
      .. '/g | update')
    _G.qf_search_term = nil  -- Clear after use
  end, { desc = 'Replace Telescope grep in Quickfix' })

  vim.keymap.set('n', '<leader>ch', ':nohl<CR>', { silent = true, desc = 'Clear search highlights' })
end

return M
