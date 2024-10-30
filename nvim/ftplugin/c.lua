local lspc = require("config.lsp")

lspc.start({
    name = 'clangd',
    cmd = {'clangd'},
    -- lua-language-server looks for .luarc.json in the workspace
    root_dir = vim.fs.root(0, {'.git'})
})
