local ok, wk = pcall(require, 'which-key')
if not ok then
  return
end

-- Modes: {symbol}(name; '{entry-key}')
-- n(normal; 'ESC'),
-- i(insert; 'n'),
-- niI(insert normal; 'ctrl+o')
-- v(visual; 'v'),
-- V(visual line; 'V'),
-- T(visual block; 'ctrl+v')
-- x(visual block + '\n')
-- s(select; 'gh' 'gH'),
-- c(command; ':')
-- R(replace; 'R'),
-- Rv(virtual replace; 'gR')
-- o(operator pending; 'd', 'y', etc)
-- t(terminal; ':terminal')

local common_mappings = {
	j = { 'gj', 'move cursor down by display line' },
	k = { 'gk', 'move cursor up by display line' },
  ['<C-l>'] = { '<C-w>l', 'move to right window' },
  ['<C-h>'] = { '<C-w>h', 'move to left window' },
  ['<C-j>'] = { '<C-w>j', 'move to below window' },
  ['<C-k>'] = { '<C-w>k', 'move to above window' },
  ['<C-q>'] = { '<cmd>:q<cr>', 'quit window' },
  ['<C-x>'] = { '<cmd>:q<cr>', 'quit window' },
  ['<C-s>'] = { '<cmd>:w<cr>', 'save' },
}

local neo_tree_mappings = {
  e = {
    function()
      require('neo-tree.command').execute({ toggle = true, dir = vim.g.utils.getroot() })
    end, "explorer: neo-tree (Root)"
  },
  E = {
    function()
      require('neo-tree.command').execute({ toggle = true, dir = vim.fn.getcwd() })
    end, "explorer: neo-tree (CWD)"
  }
}

wk.register(common_mappings, { mode = "n", prefix = "" })
wk.register(neo_tree_mappings, { mode = "n", prefix = "<leader>" })
wk.register(neo_tree_mappings, { mode = "n", prefix = "<localleader>" })
