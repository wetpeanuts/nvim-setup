return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  settings = {
    ["rust-analyzer"] = {
      procMacro = { enable = true },
      cargo = { allFeatures = true },
      checkOnSave = true,
    },
  },
}
