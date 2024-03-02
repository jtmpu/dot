return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "󰉗 ",
        },
        window = {
            border = "single",
            position = "bottom",
            margin = { 1, 0, 1, 0 },
            padding = { 1, 2, 1, 2 },
            winblend = 0,
            zindex = 1000,
        },
    }
}
