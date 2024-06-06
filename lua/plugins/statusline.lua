return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      -- {
      --   "nvim-lua/lsp-status.nvim",
      --   config = function()
      --     require("lsp-status").config({ })
      --   end
      -- },
    },
    config = function()
      require'lualine'.setup {
        sections = {
          lualine_c = {
            -- "os.date('%')", "data", "require'lsp-status'.status()"
          }
        }
      }
    end
}
