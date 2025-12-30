local M = {}

function M.init()
  local env_file = vim.fn.getcwd() .. '/.nvim/.env'
  if vim.fn.filereadable(env_file) == 1 then
    for line in io.lines(env_file) do
      line = line:gsub('#.*', ''):gsub('%s+', '')
      if line ~= '' and line:match('=') then
        local key, val = line:match('([^=]+)=(.*)')
        if key and val then vim.env[key] = val end
      end
    end
  end
end

return M
