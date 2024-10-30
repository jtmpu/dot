local lspc = require("config.lsp")

lspc.start({
  name = 'gopls',
  cmd = { 'gopls', 'serve' },
  root_dir = vim.fs.root(0, {'go.mod'}),
  settings = {
    gopls = {
      analyses = {
        useany = true,
      },
      completeUnimported = true,
      completionDocumentation = true,
      diagnosticsTrigger = 'Save',
      directoryFilters = {
        '-**/node_modules',
        '-bazel-bin',
        '-bazel-out',
        '-bazel-src',
        '-bazel-testlogs',
      },
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      semanticTokens = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
})
