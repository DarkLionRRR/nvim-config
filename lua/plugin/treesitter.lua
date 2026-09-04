vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
})

local treesitter = require("nvim-treesitter")

treesitter.setup({
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
    "go",
    "gomod",
    "gosum",
    "python",
    "rust",
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
        "go",
        "gomod",
        "gosum",
        "python",
        "rust",
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
        { ["]f"] = "@function.outer", ["]a"] = "@parameter.inner" },
    },
    goto_next_end = {
        { "n", "x", "o" },
        { ["]F"] = "@function.outer", ["]A"] = "@parameter.inner" },
    },
    goto_previous_start = {
        { "n", "x", "o" },
        { ["[f"] = "@function.outer", ["[a"] = "@parameter.inner" },
    },
    goto_previous_end = {
        { "n", "x", "o" },
        { ["[F"] = "@function.outer", ["[A"] = "@parameter.inner" },
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

require("treesitter-context").setup({
    enable = true,
    multiwindow = false,
    max_lines = 1,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = "outer",
    mode = "cursor",
    separator = nil,
    zindex = 20,
    on_attach = nil,
})

vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
