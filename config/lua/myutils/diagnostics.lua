local M = {}

local diagnostic_float_open = false

function M.toggle_diagnostic()
  if diagnostic_float_open then
    vim.diagnostic.close()
    diagnostic_float_open = false
  else
    vim.diagnostic.open_float()
    diagnostic_float_open = true
  end
end

return M

