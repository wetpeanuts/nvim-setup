local config = vim.g.cpp_config

return {
  cmd = { "cmake-language-server" },
  filetypes = { "cmake" },
  root_markers = { ".git" },
  single_file_support = true,
  init_options = {
    buildDirectory = config.CPP_STANDARD,
  },
}
