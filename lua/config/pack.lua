local pm = require("core.plugin_manager")

pm:preload()
vim.pack.add(pm:pluck("url"))
pm:afterload()
