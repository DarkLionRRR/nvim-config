vim.pack.add({
    { src = "https://github.com/Saghen/blink.cmp", version = "v1" },
})

require("blink.cmp").setup({
    keymap = { preset = "super-tab" },
    completion = { documentation = { auto_show = true } },
    appearance = {
        nerd_font_variant = "normal",
    },
})
