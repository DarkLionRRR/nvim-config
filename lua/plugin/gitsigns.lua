vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("gitsigns").setup({
    current_line_blame = true,
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local map = function(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation
        map("n", "<leader>hn", function()
            gitsigns.nav_hunk("next")
        end)
        map("n", "<leader>hp", function()
            gitsigns.nav_hunk("prev")
        end)

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)
        map("n", "<leader>hS", gitsigns.stage_buffer)
        map("n", "<leader>hR", gitsigns.reset_buffer)
        map("n", "<leader>hp", gitsigns.preview_hunk)
        map("n", "<leader>hi", gitsigns.preview_hunk_inline)

        map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end)
        map("n", "<leader>hB", gitsigns.blame)

        map("n", "<leader>hD", function()
            gitsigns.diffthis("~")
        end)
        map("n", "<leader>hd", gitsigns.diffthis)

        map("n", "<leader>hQ", function()
            gitsigns.setqflist("all")
        end)

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
    end,
})
