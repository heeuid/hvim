local utils = vim.g.utils
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "c", "cpp" },
  callback = function()
    local root_dir = utils.get_root()
    if utils.is_file(root_dir .. "/.linux") then
      utils.config_indent(8, "tab")
    else
      utils.config_indent(4, "tab")
    end
  end
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed == nil then
        opts.ensure_installed = {}
      end
      vim.list_extend(opts.ensure_installed, { "c", "cpp", })
    end
  },
}
