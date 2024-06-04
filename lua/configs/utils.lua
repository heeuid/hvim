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

-- Register interface of utils
vim.g.utils = utils
