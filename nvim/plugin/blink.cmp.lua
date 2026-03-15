vim.pack.add({
    { src = "https://github.com/rafamadriz/friendly-snippets", version = "main" },
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.0" },
})

require("blink.cmp").setup({
    keymap = { preset = "default" },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = {
        documentation = { auto_show = false }
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
})
