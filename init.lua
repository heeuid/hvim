local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('configs/utils')

require('configs/pre-settings')
require('lazy').setup({
  defaults = {
    -- lazy = false,
    version = false,
  },
  -- checker = { enabled = true },
  spec = {
    { import = "plugins" },
    { import = "plugins/languages" },
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
require('configs/post-settings')

require('configs/commands')
require('configs/keymaps')
require('configs/autocmds')
