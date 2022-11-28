-- Setup nvim-cmp.
local status_ok, symbols_outline = pcall(require, "symbols-outline")
if not status_ok then
	return
end

symbols_outline.setup({
  width = 15
})
