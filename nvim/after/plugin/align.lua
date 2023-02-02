local status_ok, align = pcall(require, "align")
if not status_ok then
  return
end

local NS = { noremap = true, silent = true }
vim.keymap.set('x', 'aa', function() align.align_to_char(1, true)             end, NS) -- Aligns to 1 character, looking left
vim.keymap.set('x', 'as', function() align.align_to_char(2, true, true)       end, NS) -- Aligns to 2 characters, looking left and with previews
vim.keymap.set('x', 'aw', function() align.align_to_string(false, true, true) end, NS) -- Aligns to a string, looking left and with previews
vim.keymap.set('x', 'ar', function() align.align_to_string(true, true, true)  end, NS) -- Aligns to a Lua pattern, looking left and with previews
