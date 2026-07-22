vim.uv = vim.uv or vim.loop

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

require("config.option")
require("config.keymap")
require("config.autocmd")
