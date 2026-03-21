# README

# LSP configuration override

Neovim will look for LSP-configuration overrides in the root
dir of any project files. This directory is: `.lsp/<filetype>.json`

As an example with python `.lsp/python.json`:

```json
{
    "cmd": ["pyright-langserver", "--stdio"],
    "pyright-langserver": {}
}
```
