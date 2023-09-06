local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    -- text
    "markdown",
    "markdown_inline",
    "yaml",
    "toml",
    -- shell
    "bash",
    -- programming
    "lua",
    "python",
    "rust",
  },
  indent = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua
    "lua-language-server",
    "stylua",
    -- python
    "pyright",
    "ruff",
    "black",
    -- rust
    "rust-analyzer",
    -- bash
    "bash-language-server",
    "beautysh",
    -- etc
    "prettier",
  },
}

M.notify = {
  render = "compact",
  on_open = function(win)
    vim.api.nvim_win_set_config(win, { border = "none" })
  end,
}

M.noice = {
  cmdline = { view = "cmdline" },
  presets = {
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = true,          -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true,      -- add a border to hover docs and signature help
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = { enable = true },

  renderer = {
    highlight_git = true,
    icons = { show = { git = false } },
  },
}

return M
