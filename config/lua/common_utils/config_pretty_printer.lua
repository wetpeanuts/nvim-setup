local M = {}

function M.print_config(config)
  -- Find max key length for alignment
  local max_key_len = 0
  for key in pairs(config) do
    
    if #key > max_key_len and key ~= "PROJECT_TYPE" then
      max_key_len = #key
    end
  end
  
  -- Build and show formatted lines
  for key, value in pairs(config) do
    if key ~= "PROJECT_TYPE" then
      local padded_key = string.rep(" ", max_key_len - #key) .. key 
      vim.notify(padded_key .. " : " .. value)
    end
  end
end

return M
