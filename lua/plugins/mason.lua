return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    vim.env.PATH = vim.fn.expand(vim.fn.stdpath('data') .. "/mason/bin") .. ":" .. vim.env.PATH
    local lsp_list = {
      "clangd", "lua_ls", "basedpyright", "rust_analyzer",
      "taplo", "jsonls",
    }
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = lsp_list,
      automatic_installation = true,
    })
    local cap = require("cmp_nvim_lsp").default_capabilities()
    for _, server in ipairs(lsp_list) do
      require("lspconfig")[server].setup({
        capabilities = cap
      })
    end
  end
}
