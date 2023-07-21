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

M.Trouble = {
  n = {
    ["<leader>tr"] = { "<cmd>TroubleToggle<CR>", "check all the troubles your code is causing" }
  }
}

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

M.MarkdownPreview = {
  n = {
    ["<leader>mp"] = { "<cmd>MarkdownPreview<CR>", "toggle markdown preview" },
  },
}

M.NvimTmuxNavigation = {
  n = {
    ["<C-j>"] = { "<cmd>NvimTmuxNavigateDown<CR>", "tmux navigate down" },
    ["<C-k>"] = { "<cmd>NvimTmuxNavigateUp<CR>", "tmux navigate up" },
    ["<C-h>"] = { "<cmd>NvimTmuxNavigateLeft<CR>", "tmux navigate left" },
    ["<C-l>"] = { "<cmd>NvimTmuxNavigateRight<CR>", "tmux navigate right" },
    ["<C-\\>"] = { "<cmd>NvimTmuxNavigateLastActive<CR>", "tmux navigate previous" },
    ["<C-Space>"] = { "<cmd>NvimTmuxNavigateNext<CR>", "tmux navigate next" },
  },
}

return M
