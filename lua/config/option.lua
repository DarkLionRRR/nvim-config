-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation and tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.autoindent = true

-- split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- undo dir settings
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- break line settings
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "> "

-- appearance
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"
vim.opt.colorcolumn = "125"
vim.opt.showmode = false

-- fold setting
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = false
vim.opt.guicursor = "n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"

-- faster cursor hold
vim.opt.updatetime = 50

vim.opt.clipboard:append("unnamedplus")
