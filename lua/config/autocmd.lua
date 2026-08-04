local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})

autocmd("InsertEnter", {
    callback = function()
        vim.schedule(vim.cmd.nohlsearch)
    end,
})
