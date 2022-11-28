local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
