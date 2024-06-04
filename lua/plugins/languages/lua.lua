local utils = vim.g.utils
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "lua" },
  callback = function()
    utils.config_indent(2, "space")
  end
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed == nil then
        opts.ensure_installed = {}
      end
      vim.list_extend(opts.ensure_installed, { "lua", })
    end
  },
}
