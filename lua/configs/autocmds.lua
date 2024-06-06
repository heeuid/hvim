local function restore_cursor()
  local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
  if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
    vim.api.nvim_win_set_cursor(0, {row, col})
  end
end

-- Restore cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = restore_cursor
})
