-- Setup which-key.
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

which_key.setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
})
