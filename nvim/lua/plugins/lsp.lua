-- Use for language server integrations, autocomplete, generating diagnostics
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        -- setup completion
        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
        })
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- setup language server installation and config
        require("mason").setup()
        local handlers = {
            function(server_name)
                -- default handler (optional)
                -- Use default setup for server
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            ["lua_ls"] = function()
                local lspconfig = require('lspconfig')
                lspconfig.lua_ls.setup({
                    capabilities = capabilities,
                    on_init = function(client)
                        local path = client.workspace_folders[1].name
                        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                                Lua = {
                                    runtime = {
                                        -- Neovim so I use LuaJIT
                                        version = 'LuaJIT'
                                    },
                                    -- Make the server aware of Neovim runtime files
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            -- Depending on usage, add additional paths here
                                            -- e.g.
                                            -- "${3rd}/something/library"
                                            vim.env.VIMRUNTIME,
                                            vim.env.VIMRUNTIME .. '/lua',
                                        },
                                        -- library = vim.api.nvim_get_runtime_file("", true)
                                    },
                                }
                            })
                        end
                        return true
                    end
                })
            end
        }

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "tsserver",
                "pyright",
            },
            handlers = handlers,
        })

    end,
}
