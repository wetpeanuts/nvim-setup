return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      sections = {
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
          },
          { 'lsp_status' }  -- Requires vim.lsp.status() or similar
        }
      }
    })
  end
}
