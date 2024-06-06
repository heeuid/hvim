-- Copy path
vim.api.nvim_create_user_command('CopyAbsPath', function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  -- require("notify").dismiss({ silent = true, pending = true })
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command('CopyRelPath', function()
  local path = vim.fn.expand("%:t")
  vim.fn.setreg("+", path)
  -- require("notify").dismiss({ silent = true, pending = true })
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command('CopyPath', function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  -- require("notify").dismiss({ silent = true, pending = true })
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Dropbar pick
local ok, db = pcall(require, "dropbar")
if ok then
  vim.api.nvim_create_user_command('DropbarPick', function()
    db.api.pick()
  end, {})
end
