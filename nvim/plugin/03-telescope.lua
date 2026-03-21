vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim", version = "v0.1.4" },
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = "v0.2.1" },
    { src = "https://github.com/folke/trouble.nvim", version = "main" },
})
local telescope = require("telescope")
local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open
telescope.setup({
    defaults = {
        mappings = {
            i = { ["<c-t>"] = open_with_trouble },
            n = { ["<c-t>"] = open_with_trouble },
        },
    },
})
require("user.keymaps").telescope()
