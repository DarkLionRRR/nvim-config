-- vim.pack.add({
--   -- Fuzzy picker
--   'https://github.com/ibhagwan/fzf-lua',
--   -- Autocompletion
--   'https://github.com/nvim-mini/mini.completion',
--   -- Enhanced quickfix/loclist
--   'https://github.com/stevearc/quicker.nvim',
-- })

-- require('fzf-lua').setup { fzf_colors = true }
-- require('mini.completion').setup {}
-- require('quicker').setup {}

return {
    { "catppuccin/nvim", name = "catppuccin" },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lualine/lualine.nvim" },
    { "lewis6991/gitsigns.nvim" },
}
