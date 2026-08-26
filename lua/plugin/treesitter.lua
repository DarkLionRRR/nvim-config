vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
})

local treesitter = require("nvim-treesitter")

treesitter.setup({
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath("data") .. "/site",
})

treesitter.install({
    "php",
    "php_only",
    "phpdoc",
    "json",
    "bash",
    "xml",
    "yaml",
    "toml",
    "sql",
    "make",
    "markdown",
    "markdown_inline",
    "nginx",
    "dockerfile",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "php",
        "bash",
        "json",
        "xml",
        "yaml",
        "toml",
        "sql",
        "make",
        "markdown",
        "nginx",
        "dockerfile",
    },
    callback = function(args)
        vim.treesitter.start(args.buf)
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- configuration
require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
        selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
        },
        include_surrounding_whitespace = false,
    },
    move = {
        set_jumps = true,
    },
})

local keys = {
    select_textobject = {
        { "x", "o" },
        { ["am"] = "@function.outer", ["im"] = "@function.inner", ["ac"] = "@class.outer", ["ic"] = "@class.inner" },
    },
    goto_next_start = {
        { "n", "x", "o" },
        { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
    },
    goto_next_end = {
        { "n", "x", "o" },
        { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
    },
    goto_previous_start = {
        { "n", "x", "o" },
        { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
    },
    goto_previous_end = {
        { "n", "x", "o" },
        { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
    },
    swap_next = {
        { "n" },
        { ["<leader>a"] = "@parameter.inner" },
    },
    swap_previous = {
        { "n" },
        { ["<leader>A"] = "@parameter.inner" },
    },
}

for method, cfg in pairs(keys) do
    local module = string.gsub(method, "_.*", "")
    if module == "goto" then
        module = "move"
    end
    module = "nvim-treesitter-textobjects." .. module

    for key, query in pairs(cfg[2]) do
        vim.keymap.set(cfg[1], key, function()
            require(module)[method](query, "textobjects")
        end, { silent = true })
    end
end
