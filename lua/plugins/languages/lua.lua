local utils = vim.g.utils
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "lua" },
  callback = function()
    utils.config_indent(2, "space")
  end
})
require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';')
      },
      diagnostics = { globals = 'vim' },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      hint = {
        enable = true
      }
    },
  }
})

return {}
