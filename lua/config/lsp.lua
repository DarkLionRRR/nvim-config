local caps = require("blink.cmp").get_lsp_capabilities({
    textDocument = {
        semanticTokens = {
            multilineTokenSupport = true,
        },
    },
})
vim.lsp.config("*", {
    root_markers = { ".git" },
    capabilities = caps,
})

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local buf = ev.buf
        local map = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf })
        end

        map("n", "K", vim.lsp.buf.hover)
        map("n", "gI", vim.lsp.buf.implementation)
        map("n", "gd", vim.lsp.buf.definition)
        map("n", "gD", vim.lsp.buf.declaration)
        map("n", "go", vim.lsp.buf.type_definition)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "gs", vim.lsp.buf.signature_help)
        map("n", "<leader>ca", vim.lsp.buf.code_action)
        map("n", "<leader>cd", vim.diagnostic.open_float)
        map("n", "<leader>cr", vim.lsp.buf.rename)
        map({ "n", "x" }, "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
        end)

        if client:supports_method("textDocument/documentHighlight") then
            local highlight_augroup = vim.api.nvim_create_augroup("my.lsp.highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

for _, cfg in ipairs(vim.lsp.get_configs()) do
    vim.lsp.enable(cfg.name)
end
