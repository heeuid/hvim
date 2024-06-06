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
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {
  -- cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", },
  root_dir = function(fname)
    return lspconfig.util.root_pattern(
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'compile_commands.json',
          'compile_flgas.txt',
          'configure.ac',
          '.git')(fname) or
        lspconfig.util.path.dirname(fname)
  end,
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParamterNames = true,
        DeducedTypes = true,
      },
      fallbackFlags = { "-std=c++20" }
    }
  }
}

return {}
