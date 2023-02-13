local colorscheme = "carbonfox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

require("nightfox").setup({
  transparent = true,
  styles = {
    comments = "italic",
    keywords = 'bold'
  }
})

-- setup must be called before loading
vim.cmd.colorscheme "carbonfox"
