local M = {}

-- TODO: migrate to sqlite db ?
local config = {}
config.opened_files = {}

function M.init()
  local nvim_proj_dir = vim.fn.getcwd() .. "/.nvim"
  if vim.fn.isdirectory(nvim_proj_dir) == 0 then
    return
  end

  local config_path = nvim_proj_dir .. "/opened_files.json"

  local function dump_config()
    local config_file = io.open(config_path, "w")
    if config_file then
      config_file:write(vim.fn.json_encode(config))
      config_file:close()
    end
  end

  local function load_config()
    local config_file = io.open(config_path, "r")
    if config_file then
      local config_data = config_file:read("*all")
      -- vim.notify("Read config: " .. config_data)
      config = vim.fn.json_decode(config_data)
    end
  end

  -- Init json file if it does not exist, or load content
  if vim.fn.filereadable(config_path) == 0 then
    dump_config()
  else
    load_config()
  end

  vim.api.nvim_create_autocmd("BufRead", {
    callback = function(args)
      local filepath = vim.api.nvim_buf_get_name(args.buf)
      config.opened_files[filepath] = true
      dump_config()
    end,
  })
end

return M
