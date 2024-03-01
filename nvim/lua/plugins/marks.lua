-- for marks in sign column and some keybinds
-- like dm<mark>
return {
    "chentoast/marks.nvim",
    config = function()
        require("marks").setup({
            default_mappings = true,
            sign = true,
        })
    end
}
