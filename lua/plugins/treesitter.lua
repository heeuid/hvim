return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/site')
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        --"lua",
        "c", "python", "rust",
        "vim", "vimdoc", "query",
        "markdown", "toml", "json", "yaml",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = { "javascript" },
      parser_install_dir = vim.fn.stdpath('data') .. '/site',
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
    })
  end
}
