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
  U = { '<C-R>', 'Redo' },
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
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
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
    k = { telescope_builtin.keymaps, "Find Keymap" },
    l = { telescope_builtin.registers, "Find Registers" },
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

local lsp_mappings_leader = {
  l = {
    name = "lsp",
    f = { vim.lsp.buf.format, "format" },
    h = { vim.lsp.buf.hover, "hover" },
    i = { "<cmd>LspInfo<cr>", "info" },
    n = { function() vim.diagnostic.goto_next() end, "next diagnostic" },
    p = { function() vim.diagnostic.goto_prev() end, "prev diagnostic" },
    w = {
      name = "workspace",
      a = { vim.lsp.buf.add_workspace_folder, "add workspace" },
      r = { vim.lsp.buf.remove_workspace_folder, "remobe workspace" },
      l = { function() vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "list workspace" },
    },
    r = { vim.lsp.buf.rename, "rename symbol" },
  },
  M = { "<cmd>Mason<cr>", "mason" },
}
local lsp_mappings = {
  ["gd"] = { vim.lsp.buf.definition, "goto definition" },
  ["gD"] = { vim.lsp.buf.declaration, "goto declaration" },
  ["gi"] = { vim.lsp.buf.implementation, "goto implementation" },
  ["gr"] = { vim.lsp.buf.references, "goto references" },
}

wk.register(common_mappings, { mode = "n", prefix = "" })
wk.register(buffer_mappings, { mode = "n", prefix = "" })
wk.register(lsp_mappings, { mode = "n", prefix = "" })

wk.register({ y = { "\"+y", "system yank" } }, { mode = "n", prefix = "<leader>" })
wk.register({ p = { "\"+p", "system paste" } }, { mode = "n", prefix = "<leader>" })
wk.register(neo_tree_mappings_leader, { mode = "n", prefix = "<leader>" })
wk.register(code_minimap_mappings_leader, { mode = "n", prefix = "<leader>" })
wk.register(buffer_mappings_leader, { mode = "n", prefix = "<leader>" })
wk.register(file_or_find_mappings_leader, { mode = "n", prefix = "<leader>" })
wk.register(lsp_mappings_leader, { mode = "n", prefix = "<leader>" })

wk.register(neo_tree_mappings_leader, { mode = "n", prefix = "<localleader>" })

local xmode_common_mappings = {
  ["<Space>"] = { '<cmd>lua require("which-key").show(" ", {mode = "v", auto = true})<cr>', "" },
  ["<lt>"] = { "<gv", "keep indenting <" },
  [">"] = { ">gv", "keep indenting >" },
}

local xmode_add_chars_mappings_leader = {
  a = {
    name = "add surrounded text",
    a = {
      function() utils.add_chars() end,
      "Add text to both ends"
    },
    h = {
      function() utils.add_chars('left') end,
      "Add text to left end"
    },
    l = {
      function() utils.add_chars('right') end,
      "Add text to right end"
    },
    c = {
      function() utils.add_chars('one-line') end,
      "Add text to a left end, a right end"
    }
  }
}

wk.register(xmode_common_mappings, { mode = "x", prefix = "" })

wk.register({ y = { "\"+y", "system yank" } }, { mode = "x", prefix = "<leader>" })
wk.register({ p = { "\"+p", "system paste" } }, { mode = "x", prefix = "<leader>" })
wk.register(xmode_add_chars_mappings_leader, { mode = "x", prefix = "<leader>" })
