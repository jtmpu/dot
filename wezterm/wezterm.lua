local wezterm = require("wezterm")
-- local config = wezterm.config_builder()

-- Define appearance
local color_scheme = 'Tokyo Night'
local font = wezterm.font "JetBrains Mono"

-- Keybinds - tmux-esque
local leader = { key = "b", mods = "CTRL" }
local keybinds = {
    -- Tab management
    { key = '&', mods = "LEADER|SHIFT", action = wezterm.action.CloseCurrentTab { confirm = false } },
    { key = 'c', mods = "LEADER", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
    { key = "w", mods = "LEADER", action = wezterm.action.ShowTabNavigator },
    { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },

    -- Pane management
    { key = "%", mods = "LEADER|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = '"', mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = 'x', mods = "LEADER", action = wezterm.action.CloseCurrentPane { confirm = false } },
    { key = 'z', mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
    { key = "UpArrow", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "DownArrow", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "LeftArrow", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },

    -- Global
    { key = "P", mods = "LEADER|SHIFT", action = wezterm.action.ActivateCommandPalette },
    { key = "F11", action = wezterm.action.ToggleFullScreen },
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo "Clipboard" },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom "Clipboard" },
    { key = "R", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },
    { key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) },
    { key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) },
}

-- Define supported domains
local wsl_domains = {
    {
        name = "WSL:Dev",
        distribution = "Ubuntu",
        username = "user",
        default_cwd = "~",
        default_prog = { "/bin/bash" },
    },
}

-- Define launch menu

-- config.wsl_domains = wsl_domains
-- config.default_domain = "WSL:Dev"
-- config.leader = leader
-- config.keys = keybinds
-- config.launch_menu = launch_menu
-- return config
return {
    wsl_domains = wsl_domains,
    default_domain = "WSL:Dev",
    audible_bell = "Disabled",
    window_decorations = "TITLE|RESIZE",
    enable_tab_bar = false,
    color_scheme = color_scheme,
    font = font,
    disable_default_key_bindings = true,
    leader = leader,
    keys = keybinds,
}
