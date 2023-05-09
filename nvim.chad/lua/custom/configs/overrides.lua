local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "markdown",
    "markdown_inline",
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
    "black",

    -- rust
    "rust-analyzer",
    "rustfmt",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = false,
      },
    },
  },
}

return M
