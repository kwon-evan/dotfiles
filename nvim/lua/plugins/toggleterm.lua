return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function()
      local toggleterm = require("toggleterm")
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

      -- lazygit
      local function _lazygit_toggle()
        lazygit:toggle()
      end

      -- select executer by filename
      local function _excute()
        local excuter = vim.fn.expand("%:e")
        if excuter == "py" then
          excuter = "python3 "
        elseif excuter == "sh" then
          excuter = "bash "
        elseif excuter == "rs" then
          excuter = "rustc "
        else
          excuter = ""
        end

        if excuter ~= "" then
          local cmd = '"' .. excuter .. vim.fn.expand("%:p") .. '"'
          toggleterm.exec_command("direction=vertical size=80 cmd=" .. cmd)
        else
          vim.notify("Not support file type", "warning")
        end
      end

      vim.keymap.set("n", "<leader>g", _lazygit_toggle, { desc = "Lazygit" })
      vim.keymap.set("n", "<leader>e", _excute, { desc = "Excute" })
      toggleterm.setup()
    end,
    keys = {
      { "<leader>t", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "ToggleTerm" },
    },
  },
}
