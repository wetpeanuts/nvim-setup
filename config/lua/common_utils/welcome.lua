
local M = {}

local win = nil
local buf = nil
local is_open = false

local width = 64

function M.init_welcome_win(data)
  if win and vim.api.nvim_win_is_valid(win) then
    -- Already initialized and open; just return
    return
  end

  local height = 9 + #data.custom_bindings * 2 + #data.default_bindings
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2 - 1)

  buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'modifiable', true)

  local lines = {}
  local function center_text(text)
    local pad = math.floor((width - #text) / 2)
    return string.rep(' ', pad) .. text
  end

  -- table.insert(lines, center_text(data.project_name))
  -- table.insert(lines, center_text(data.project_type))
  table.insert(lines, 'PROJ: ' .. data.project_name .. string.rep(' ', width - #data.project_name - 6))
  table.insert(lines, 'DESC: ' .. data.project_desc .. string.rep(' ', width - #data.project_desc - 6))
  table.insert(lines, 'ROOT: ' .. data.project_root .. string.rep(' ', width - #data.project_root - 6))
  table.insert(lines, string.rep('_', width))
  table.insert(lines, string.rep(' ', width))
  
  for _, binding in ipairs(data.custom_bindings) do
    local desc = binding.description
    local bind = binding.binding
    local icon = binding.icon
    local gap = width - #desc - #bind - 2
    gap = gap > 0 and gap or 1
    local line = icon .. ' ' .. desc .. string.rep(' ', gap) .. bind
    table.insert(lines, line)
  end

  table.insert(lines, string.rep('_', width))
  table.insert(lines, string.rep(' ', width))

  for _, binding in ipairs(data.default_bindings) do
    local desc = binding.description
    local bind = binding.binding
    local icon = binding.icon
    local gap = width - #desc - #bind - 2
    gap = gap > 0 and gap or 1
    local line = icon .. ' ' .. desc .. string.rep(' ', gap) .. bind
    table.insert(lines, line)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'welcome')

  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = #lines,
    row = row,
    col = col,
    border = "rounded",
  }

  win = vim.api.nvim_open_win(buf, true, opts)
  is_open = true

  -- Keymap for toggle
end

function M.toggle_welcome()
  if not buf or not win then
    return
  end

  if is_open then
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    is_open = false
  else
    -- Reopen the floating window with the same buffer
    local height = vim.api.nvim_buf_line_count(buf)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2 - 1)
    local opts = {
      style = "minimal",
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      border = "rounded",
    }
    win = vim.api.nvim_open_win(buf, true, opts)
    is_open = true
  end
end

return M
