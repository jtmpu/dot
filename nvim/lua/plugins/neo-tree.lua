-- Used for tree and explorer like feature
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            default_component_configs = {
                diagnostics = {
                    symbols = {
                        hint = "󰌵",
                        info = " ",
                        warn = " ",
                        error = " ",
                    },
                    highlights = {
                        hint = "DiagnosticSignHint",
                        info = "DiagnosticSignInfo",
                        warn = "DiagnosticSignWarn",
                        error = "DiagnosticSignError",
                    },
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added     = "✚",
                        deleted   = "✖",
                        modified  = "",
                        renamed   = "󰁕",
                        -- Status type
                        untracked = "",
                        ignored   = "",
                        unstaged  = "󰄱",
                        staged    = "",
                        conflict  = "",
                    }
                },
            }
        })
    end,
}
