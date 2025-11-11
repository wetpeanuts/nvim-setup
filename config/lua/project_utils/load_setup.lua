local M = {}

function M.try_load_project_setup()
  -- Load custom project setup if present
  local uv = vim.loop
  local project_nvim_config = vim.fn.getcwd() .. "/.nvim/setup.lua"
  
  if uv.fs_stat(project_nvim_config) then
    vim.notify("Project setup found")
    local config = dofile(project_nvim_config)
    if not config.PROJECT_TYPE then
      vim.notify("Project type not specified")
      return
    end
    local project_setup = require("project_utils." .. config.PROJECT_TYPE)
    project_setup.init(config)
  end
end

return M

