return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  module = true,
  event = { "BufReadPost", "BufNewFile" },
  cmd = {
    "TSInstall",
    "TSInstallInfo",
    "TSUpdate",
    "TSBufEnable",
    "TSBufDisable",
    "TSEnable",
    "TSDisable",
    "TSModuleInfo",
  },
  config = function()
    local ts = require("nvim-treesitter.configs")
    local setup = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "gitcommit",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "proto",
        "python",
        "regex",
        "rust",
        "terraform",
        "toml",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
      },
      autopairs = {
        enable = true,
      },
      indent = {
        enable = false,
        disable = {}
      },

    }
    ts.setup(setup)
  end
}
