return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local dropdown_theme = require('telescope.themes').get_dropdown({
        prompt_prefix = ' > ',
        previewer = false,
        borderchars = { "-", "|", "-", "|", "+", "+", "+", "+" },
      })
      require("telescope").setup({
        defaults = dropdown_theme,
      })
    end,
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep <cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers   <cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags <cr>", desc = "Help Tags" },
      { "<leader>v", "<cmd>cd ~/.config/nvim/<CR>:Telescope find_files<CR>", desc = "Find Neovim Config" },
    },
  },
}
