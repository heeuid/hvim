local utils = vim.g.utils
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "python" },
  callback = function()
    utils.config_indent(4, "tab")
  end
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed == nil then
        opts.ensure_installed = {}
      end
      vim.list_extend(opts.ensure_installed, { "python", })
    end
  },
}
