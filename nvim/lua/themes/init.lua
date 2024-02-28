local theme = "tokyonight"
local fallback_theme = "habamax"

-- check if there is a configuration for the theme
local status_ok = pcall(require, "themes." .. theme)
if not status_ok then
  local msg = "Failed to load configuration for'" .. theme .. "'. Falling back to '" .. fallback_theme .. "'"
  vim.notify(msg, vim.log.levels.ERROR)
  vim.cmd.colorscheme(fallback_theme)
  return
end

local theme_ok = pcall(vim.cmd.colorscheme, theme)
if not theme_ok then
  vim.notify("Failed to load theme '" .. theme .. "'. Falling back to '" .. fallback_theme "'", vim.log.levels.ERROR)
  vim.cmd.colorscheme(fallback_theme)
else
  vim.cmd.colorscheme(theme)
end
