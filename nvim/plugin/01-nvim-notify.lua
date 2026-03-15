vim.pack.add({
    { src = "https://github.com/rcarriga/nvim-notify", version = "master" },
    { src = "https://github.com/j-hui/fidget.nvim", version = "main" },
})

-- override global notification system
vim.notify = require("notify")
require("fidget").setup({
    progress = {
        display = {
          group_items = true,     -- Group multiple items from the same LSP
          collapse = true,        -- Collapse them into a single line if they are similar
        },
    },
})

