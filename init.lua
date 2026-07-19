vim.uv = vim.uv or vim.loop

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("module.autoload")
require("config.option")
require("config.keymap")
require("config.autocmd")
