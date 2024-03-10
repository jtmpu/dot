-- Used for better navigation and searching
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
    },
    config = function()
        local telescope = require("telescope")

        -- Enable opening telescope searches in trouble
        local actions = require("telescope.actions")
        local trouble = require("trouble.providers.telescope")
        telescope.setup({
            defaults = {
                mappings = {
                    i = { ["<c-x>"] = trouble.open_with_trouble },
                    n = { ["<C-x>"] = trouble.open_with_trouble },
                }
            },
        })
    end,
}
