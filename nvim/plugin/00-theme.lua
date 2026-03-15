-- Colortheme setup
vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim", version = "main" },
})
local theme = require("tokyonight")
theme.setup({
    style = "storm",
})
vim.cmd.colorscheme("tokyonight")
