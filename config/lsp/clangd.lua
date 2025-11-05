return {
  cmd = { "clangd", "--compile-commands-dir=build", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
  root_markers = { ".git", "compile_commands.json", "compile_flags.txt", },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  init_options = {
    fallbackFlags = { "-std=c++23" },
  },
}
