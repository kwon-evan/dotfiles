return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          -- vim
          "vim",
          "vimdoc",
          -- note
          "comment",
          "markdown",
          "markdown_inline",
          -- shell
          "bash",
          -- languages
          "lua",
          "c",
          "rust",
          "python",
        },
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      vim.cmd("hi TreesitterContextBottom gui=underdashed guisp=#585b70")
    end
  },
}
