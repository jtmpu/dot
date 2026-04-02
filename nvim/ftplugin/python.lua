local lspc = require("user.lsp")
local server = "python"

local root_dir = vim.fs.root(0, { ".git", ".lsp" }) or vim.fn.expand("%:p:h")

lspc.enable_fold(server)
lspc.attach(server, {
    name = server,
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = root_dir,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
            },
        },
    },
})
