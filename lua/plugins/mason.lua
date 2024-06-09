return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    vim.env.PATH = vim.fn.expand(vim.fn.stdpath('data') .. "/mason/bin") .. ":" .. vim.env.PATH
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
