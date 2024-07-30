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
          "html",
          "css",
          "javascript",
          "typescript",
          "svelte",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
