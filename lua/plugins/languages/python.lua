local utils = vim.g.utils
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "python" },
  callback = function()
    utils.config_indent(4, "tab")
  end
})
require("lspconfig").basedpyright.setup({})

return {}
