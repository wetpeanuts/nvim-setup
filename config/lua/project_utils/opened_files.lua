local M = {}

local current_file = ""

local config = {}
config.opened_files = {}
config.opened_files_count = 0

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
      config = vim.fn.json_decode(config_data)

      if config.opened_files_count > 0 then
        -- local empty_buf = vim.api.nvim_get_current_buf()
        for file, opened in pairs(config.opened_files) do
          vim.cmd('edit ' .. file)
          if opened then
            local bufs = vim.api.nvim_list_bufs()
            local last_buf = bufs[#bufs]
            vim.api.nvim_set_current_buf(last_buf)
          end
        end
        -- vim.api.nvim_buf_delete(empty_buf, {force = true})
      end
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
      if #filepath > 0 then
        if config.opened_files[current_file] ~= nil then
          config.opened_files[current_file] = false
        end
        config.opened_files[filepath] = true
        config.opened_files_count = config.opened_files_count + 1
        current_file = filepath
        dump_config()
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
      local filepath = vim.api.nvim_buf_get_name(args.buf)
      if config.opened_files[filepath] ~= nil then
        if config.opened_files[current_file] ~= nil then
          config.opened_files[current_file] = false
        end
        config.opened_files[filepath] = true
        current_file = filepath
        dump_config()
      end
    end
  })

  vim.api.nvim_create_autocmd("BufDelete", {
    callback = function(args)
      local filepath = vim.api.nvim_buf_get_name(args.buf)
      if config.opened_files[filepath] ~= nil then
        config.opened_files[filepath] = nil
        config.opened_files_count = config.opened_files_count - 1
        dump_config()
      end
    end,
  })
end

return M
