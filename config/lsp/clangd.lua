local config = vim.g.cpp_config

return {
  cmd = { "clangd", "--compile-commands-dir=" .. config.CPP_BUILD_DIR, "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
  root_markers = { ".git", "compile_commands.json", "compile_flags.txt", },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  init_options = {
    fallbackFlags = { config.CPP_STANDARD },
  },
}
