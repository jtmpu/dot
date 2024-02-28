local fn = vim.fn
local opt = vim.opt
local wo = vim.wo

-- Clipboard
opt.clipboard = "unnamedplus"

-- NVim UI
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.guicursor = ""

opt.ignorecase = true -- ignore case letters in search
opt.smartcase = true  -- ignore lowercase for whole pattern

wo.number = true
vim.o.mouse = false

-- Tabs, indents
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.autoindent = true

-- Other
opt.updatetime = 300
opt.timeoutlen = 500
opt.undodir = fn.expand("$HOME") .. "/.vimdid"
opt.undofile = true
opt.termguicolors = true
opt.wrap = false
opt.scrolloff = 8

-- Searching
opt.hlsearch = false
opt.incsearch = true

-- Color configs
vim.opt.termguicolors = true

-- Disable netrw (from nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
