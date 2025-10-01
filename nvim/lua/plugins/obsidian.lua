return {
  -- note taking
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/vaults/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/vaults/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "valut",
          path = "~/vaults/",
        },
      },

      log_level = vim.log.levels.INFO,

      mappings = {
        -- goto note
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        }
      },
    },
  },
  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    opts = {
      sessions = {
        pomodoro = {
          { name = "Work",        duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work",        duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work",        duration = "25m" },
          { name = "Long Break",  duration = "15m" },
        },
      },
    },
  }
}
