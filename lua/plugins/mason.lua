return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd", "lua_ls", "basedpyright", "rust_analyzer",
        "taplo", "jsonls",
      },
      automatic_installation = true,
    })
  end
}
