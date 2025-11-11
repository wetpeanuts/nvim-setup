local M = {}

function M.init(config)
  vim.notify("Initializing cpp porject")

  local config_pretty_printer = require("common_utils.config_pretty_printer")
  config_pretty_printer.print_config(config)

  vim.lsp.enable({'clangd'})
end

return M
