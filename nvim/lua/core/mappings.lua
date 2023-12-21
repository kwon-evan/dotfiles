local function map(mode, lhs, rhs, opts)
  -- set default value if not specify
  if opts.noremap == nil then
    opts.noremap = true
  end
  if opts.silent == nil then
    opts.silent = true
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- use ";" as ";"
map("n", ";", ":", {})

-- better up/down
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

map("n", "<C-u>", "<C-u>zz", {})
map("n", "<C-d>", "<C-d>zz", {})
map("n", "<C-b>", "<C-b>zz", {})
map("n", "<C-f>", "<C-f>zz", {})

-- leader movements
map("n", "<Leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<Leader>s", "<cmd>source %<CR>", { desc = "Reload file" })

-- window movements
map("n", "<C-k>", "<C-w>k", {})
map("n", "<C-j>", "<C-w>j", {})
map("n", "<C-h>", "<C-w>h", {})
map("n", "<C-l>", "<C-w>l", {})
map("n", "<C-c>", "<C-w>c", {})

-- buffer
map("n", "<Tab>", "<cmd>bnext<CR>", {})
map("n", "<S-Tab>", "<cmd>bprev<CR>", {})
map("n", "<Leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })

-- escape terminal mode with esc
map("t", "<Esc>", "<C-\\><C-n>", {})
-- clear highlight with esc
map("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true })

-- select all
map("n", "<C-a>", "ggVG", {})

-- search selected text
map("v", "<C-f>", "y/<C-r>0<CR>", { desc = "Search selected text", noremap = true, silent = true })
