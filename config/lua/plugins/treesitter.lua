return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ok, parser = pcall(vim.treesitter.get_parser, args.buf)

          if ok and parser then
            vim.treesitter.start(args.buf)
          end
        end,
      })
    end,
  },
}
