local lspc = require("user.lsp")
local server = "rust"

local root_dir = vim.fs.root(0, { ".git", ".lsp", "Cargo.toml" })
if not root_dir then
    lspc.error(server, "no root dir found, not spawning")
    return
end

lspc.enable_fold(server)
lspc.attach(server, {
    name = server,
    cmd = { "rust-analyzer" },
    root_dir = root_dir,
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            cargo = {
                allFeatures = true,
            },
            procMacro = {
                enable = true,
            },
        },
    }
})
