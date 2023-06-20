---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },

  t = {
    ["<Esc>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "escape terminal mode" },
  },
}

-- more keybinds!
M.SymbolsOutline = {
  n = {
    ["<F2>"] = { "<cmd>SymbolsOutline<CR>", "toggle symbols outline" },
  },
}

M.GotoPreview = {
  n = {
    ["gpd"] = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "goto definition" },
    ["gpt"] = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "goto type definition" },
    ["gpi"] = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "goto implementation" },
    ["gP"] = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "all preview windows close" },
    ["gpr"] = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "goto references" },
  },
}

M.SnipRun = {
  n = {
    -- run current file
    ["<C-t>"] = { "<cmd>SnipRun<CR>j", "run current file" },
  },
  s = {
    -- run current selection
    ["<C-t>"] = { "<cmd>SnipRun<CR>j", "run current selection" },
  },
  v = {
    -- run current visual selection
    ["<C-t>"] = { "<cmd>SnipRun<CR>j", "run current visual selection" },
  },
}

return M
