local autocmd_table = {
    {
        event = "TextYankPost",
        opts = {
            callback = function() vim.hl.on_yank() end,
        },
    },
    {
        event = "InsertEnter",
        opts = {
            callback = function() vim.schedule(vim.cmd.nohlsearch) end,
        },
    },
}
for _, cmd in ipairs(autocmd_table) do
    vim.api.nvim_create_autocmd(cmd.event, cmd.opts)
end
