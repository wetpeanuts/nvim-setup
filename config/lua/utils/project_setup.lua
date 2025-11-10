local M = {}

function M.try_load_project_setup()
  -- Load custom project setup if present
  local uv = vim.loop
  local project_nvim_config = vim.fn.getcwd() .. "/.nvim/setup.lua"
  
  if uv.fs_stat(project_nvim_config) then
    vim.notify("Project setup found")
    dofile(project_nvim_config)
  end
end

return M

