local utils = {}

-- Check windows or not
utils.is_windows = function()
  return package.config:sub(1,1) == '\\'
end

-- Find root directory
-- 1. lsp root
-- 2. .git/
-- 3. cwd
utils.get_root = function()
  local clients = vim.lsp.get_clients()
  for _, client in pairs(clients) do
    if client.config.root_dir then
      return client.config.root_dir
    end
  end

  local path = vim.fn.expand('%:p:h')
  while path ~= '/' do
    if vim.fn.isdirectory(path .. '/.git') == 1 then
      return path
    end
    path = vim.fn.fnamemodify(path, ':h')
  end
  return vim.fn.getcwd()
end

utils.get_root_by_pattern = function(pats)
  if type(pats) ~= type({}) then
    pats = { pats }
  end

  local path = vim.fn.expand('%:p:h')
  while path ~= '/' do
    for _, pat in pairs(pats) do
      local item_path = path .. '/' .. pat
      if vim.fn.filereadable(item_path) or
        vim.fn.isdirectory(item_path) then
        return path
      end
    end
    path = vim.fn.fnamemodify(path, ':h')
  end
  return nil
end

-- Configure indentation
-- set tabsize and select to expand or not
-- spaces: number of tab size by space cnt
-- select: tab or space
utils.config_indent = function(spaces, select)
  if not spaces or
      not select or
      type(spaces) ~= type(0) then
    return
  end

  local expand
  if type(select) == type("") then
    if select == "tab" then
      expand = false
    elseif select == "space" then
      expand = true
    else
      return
    end
  else
    return
  end

  vim.opt.shiftwidth = spaces
  vim.opt.tabstop = spaces
  vim.opt.expandtab = expand
end

utils.path_exists = function(path)
  local command
  if utils.is_windows() then
    command = 'if exist "' .. path .. '" (echo exists)'
  else
    command = 'test -e "' .. path .. '" && echo exists'
  end
  local file = io.popen(command)
  if not file then
    return false
  end
  local result = file:read("*a")
  file:close()
  return result:match("exists") ~= nil
end
-- File?
utils.is_file = function(path)
  local command
  if utils.is_windows() then
    command = 'if exist "' .. path .. '" (echo file)'
  else
    command = 'test -f "' .. path .. '" && echo file'
  end
  local file = io.popen(command)
  if not file then
    return false
  end
  local result = file:read("*a")
  file:close()
  return result:match("file") ~= nil
end

-- Direcotry?
utils.is_directory = function(path)
  local command
  if utils.is_windows() then
    command = 'if exist "' .. path .. '\\NUL" (echo directory)'
  else
    command = 'test -d "' .. path .. '" && echo directory'
  end
  local file = io.popen(command)
  if not file then
    return false
  end
  local result = file:read("*a")
  file:close()
  return result:match("directory") ~= nil
end

-- Add surrond strings (selected lines)
utils.add_chars = function(dir)
  local mode = vim.api.nvim_get_mode().mode
  if mode ~= 'v' and mode ~= 'V' and mode ~= '\x16' then
    vim.print("Only for visual mode; now is ...", mode)
    return
  end

  -- input surrond strings
  local prepend_text
  local append_text
  if not dir or dir == 'left' or dir == 'both' or dir == 'one-line' then
    prepend_text = vim.fn.input('First string: ')
  else
    prepend_text = ''
  end
  if not dir or dir == 'right' or dir == 'both' or dir == 'one-line' then
    append_text = vim.fn.input('Last string: ')
  else
    append_text = ''
  end

  -- get selected area information
  vim.cmd([[execute "normal! \<ESC>"]])
  local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
  local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))

  -- get selected text
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  if dir == 'one-line' then
    if #lines == 1 then -- one line is selected
      local temp = lines[1]:sub(end_col + 1)
      lines[1] = lines[1]:sub(1, start_col - 1) .. prepend_text .. lines[1]:sub(start_col, end_col) .. append_text
      if end_col ~= vim.v.maxcol then
        lines[1] = lines[1] .. temp
      end
    else
      -- more than one lines are selected, and add string to only first, last lines
      lines[1] = lines[1]:sub(1, start_col - 1) .. prepend_text .. lines[1]:sub(start_col)
      local temp = lines[#lines]:sub(end_col + 1)
      lines[#lines] = lines[#lines]:sub(1, end_col) .. append_text
      if end_col ~= vim.v.maxcol then
        lines[#lines] = lines[#lines] .. temp
      end
    end
  else
    for i, line in ipairs(lines) do
      if #line > 0 then -- non-empty line
        local temp = line:sub(end_col + 1)
        local new_line = line:sub(1, start_col - 1) ..
            prepend_text .. line:sub(start_col, end_col) .. append_text
        if end_col ~= vim.v.maxcol then
          lines[i] = new_line .. temp
        else
          lines[i] = new_line
        end
      end
    end
  end

  -- update text
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end

-- Register interface of utils
vim.g.utils = utils
