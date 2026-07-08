vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.o.scrolloff = 8

vim.opt.clipboard:append("unnamedplus")

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
map("i", "\"", "\"\"<Left>")
map("i", "'", "''<Left>")

map("n", "<S-h>", vim.cmd.bprev)
map("n", "<S-l>", vim.cmd.bnext)
map("n", "<leader>bd", vim.cmd.bdelete)

map("x", ">", ">gv")
map("x", "<", "<gv")

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    callback = function() vim.hl.on_yank() end,
})
autocmd("InsertEnter", {
    callback = function() vim.schedule(vim.cmd.nohlsearch) end,
})

vim.pack.add({
    "https://github.com/RRethy/base16-nvim",
})
require("noctalia.matugen").setup()

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })

-- vim.pack.add({
--   -- Quickstart configs for LSP
--   'https://github.com/neovim/nvim-lspconfig',
--   -- Fuzzy picker
--   'https://github.com/ibhagwan/fzf-lua',
--   -- Autocompletion
--   'https://github.com/nvim-mini/mini.completion',
--   -- Enhanced quickfix/loclist
--   'https://github.com/stevearc/quicker.nvim',
--   -- Git integration
--   'https://github.com/lewis6991/gitsigns.nvim',
-- })

-- require('fzf-lua').setup { fzf_colors = true }
-- require('mini.completion').setup {}
-- require('quicker').setup {}
-- require('gitsigns').setup {}
