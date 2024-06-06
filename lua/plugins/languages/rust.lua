local utils = vim.g.utils
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "rust" },
  callback = function()
    utils.config_indent(4, "tab")
  end
})
require("lspconfig").rust_analyzer.setup({})

return {}
