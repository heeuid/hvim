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
-- x(all visuals; 'v', 'V', 'ctrl+v')
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

local neo_tree_mappings_leader = {
  e = {
    function()
      require('neo-tree.command').execute({ toggle = true, dir = vim.g.utils.get_root() })
    end, "explorer: neo-tree (Root)"
  },
  E = {
    function()
      require('neo-tree.command').execute({ toggle = true, dir = vim.fn.getcwd() })
    end, "explorer: neo-tree (CWD)"
  }
}

local code_minimap_mappings_leader = {
  m = {
    name = "code minimap",
    -- other keys are mapped by plugin
  }
}

local buffer_mappings_leader = {
  b = {
    name = "buffer",
    p = { "<cmd>BufferLineTogglePin<cr>", "Toggle Pin" },
    P = { "<cmd>BufferLineGroupClose ungrouped<cr>", "Delete Non-Pinned Buffers" },
    o = { "<cmd>BufferLineCloseOthers<cr>", "Delete Other Buffers" },
    r = { "<cmd>BufferLineCloseRight<cr>", "Delete Buffers to the Right" },
    l = { "<cmd>BufferLineCloseLeft<cr>", "Delete Buffers to the Left" },
    e = { "<cmd>Neotree buffers<cr>", "Explore buffers" },
  },
}

local buffer_mappings = {
  ["[b"] = { "<cmd>BufferLineCyclePrev<cr>", "Prev Buffer" },
  ["]b"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
  ["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", "Prev Buffer" },
  ["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
}

local telescope_builtin = require'telescope.builtin'
local utils = vim.g.utils
local file_or_find_mappings_leader = {
  f = {
    name = "file/find",
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    f = {
      function()
        telescope_builtin.find_files({ cwd = utils.get_root() }) 
      end,
      "Find Files (root)"
    },
    F = {
      function()
        telescope_builtin.find_files({ cwd = vim.fn.getcwd() }) 
      end,
      "Find Files (cwd)"
    },
    g = {
      function()
       telescope_builtin.live_grep({ cwd = utils.get_root() })
      end,
      "Grep Text (root)"
    },
    G = {
      function()
       telescope_builtin.live_grep({ cwd = vim.fn.getcwd() })
      end,
      "Grep Text (cwd)"
    },
  },
  ["<leader>"] = {
    function()
      telescope_builtin.find_files({ cwd = utils.get_root() }) 
    end,
    "Find Files (root)"
  },
  ["/"] = {
    function()
     telescope_builtin.live_grep({ cwd = utils.get_root() })
    end,
    "Grep (root)"
  },
}

wk.register(common_mappings, { mode = "n", prefix = "" })
wk.register(buffer_mappings, { mode = "n", prefix = "" })
wk.register(neo_tree_mappings_leader, { mode = "n", prefix = "<leader>" })
wk.register(code_minimap_mappings_leader, { mode = "n", prefix = "<leader>" })
wk.register(buffer_mappings_leader, { mode = "n", prefix = "<leader>" })
wk.register(file_or_find_mappings_leader, { mode = "n", prefix = "<leader>" })
wk.register(neo_tree_mappings_leader, { mode = "n", prefix = "<localleader>" })

local xmode_common_mappings = {
  ["<"] = { "<gv", "keep indenting" },
  [">"] = { ">gv", "keep indenting" },
}

wk.register(xmode_common_mappings, { mode = "x", prefix = "" })
