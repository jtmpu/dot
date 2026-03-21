local lspc = require("user.lsp")
local server = "rust"

local root_dir = vim.fs.root(0, { ".git", ".lsp", "Cargo.toml" })
if not root_dir then
    vim.notify("[rust:lsp] no root dir found, not spawning")
    return
end

local settings = lspc.load_settings(root_dir, server, {
    cmd = { "rust-analyzer" },
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
})

if not settings then
    vim.notify("[rust:lsp] no LSP settings found, aborting", vim.log.levels.ERROR)
    return
end

-- enable LSP
lspc.attach({
    name = server,
    ---@diagnostic disable-next-line
    cmd = settings["cmd"],
    -- lua-language-server looks for .luarc.json in the workspace
    root_dir = root_dir,
    settings = settings,
})
