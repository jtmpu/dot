-- So I more easily remember keybinds, marks and stuff
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
    }
}
