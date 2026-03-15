-- enables faster loadtimes sometimes
vim.loader.enable()

-- Setup globals
require("user.settings")
require("user.lsp").init()
require("user.keymaps").init()
require("user.autocmds").init()
