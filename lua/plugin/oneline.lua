local plugins = {
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim", name = "lualine" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/j-hui/fidget.nvim", name = "fidget" },
}

vim.pack.add(plugins)

for _, plg in ipairs(plugins) do
    if type(plg.name) == "string" then
        require(plg.name).setup()
    end
end
