local build_dir = os.getenv("NVIM_CLANGD_BUILD_DIR") or vim.fn.getcwd() .. "/build"
local cpp_standard = os.getenv("NVIM_CLANGD_CPP_STANDARD") or "-std=c++23"

return {
  cmd = {
    "clangd",
    -- "/opt/homebrew/opt/llvm/bin/clangd",
    "--compile-commands-dir=" .. build_dir,
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    -- "--experimental-modules-support",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp", "cppm" },
  root_markers = { ".git", "compile_commands.json", "compile_flags.txt", },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  init_options = {
    fallbackFlags = { cpp_standard },
  },
}
