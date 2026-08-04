local map = vim.keymap.set

map("n", "<Esc>", vim.cmd.nohlsearch)
map("t", "<Esc>", "<C-\\><C-n>")

map("n", "<leader>e", vim.cmd.Ex)

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("i", "(", "()<Left>")
map("i", "[", "[]<Left>")
map("i", "{", "{}<Left>")
map("i", '"', '""<Left>')
map("i", "'", "''<Left>")

map("n", "<S-h>", vim.cmd.bprev)
map("n", "<S-l>", vim.cmd.bnext)
map("n", "<leader>bd", vim.cmd.bdelete)

map("x", ">", ">gv")
map("x", "<", "<gv")
