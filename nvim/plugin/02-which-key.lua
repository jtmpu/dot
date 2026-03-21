vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim", version = "main" },
})
require("which-key").setup({
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "󰉗 ",
    },
})
require("user.keymaps").which_key()
