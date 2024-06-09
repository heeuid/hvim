return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/site')
    require("nvim-treesitter.configs").setup({
      build = ":TSUpdate",
      version = false,
      ensure_installed = {
        "lua", "luadoc", "luap",
        "c", "python", "rust",
        "bash", "vim", "vimdoc",
        "query", "diff", "printf", "regex",
        "html", "javascript",
        "markdown", "markdown_inline",
        "toml", "json", "jsonc", "jsdoc", "yaml", "xml",
      },
      sync_install = false,
      auto_install = true,
      parser_install_dir = vim.fn.stdpath('data') .. '/site',
      indent = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
      keys = {
        { "<c-space>", desc = "Increment Selection" },
        { "<bs>", desc = "Decrement Selection", mode = "x" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        }
      }
    })
  end
}
