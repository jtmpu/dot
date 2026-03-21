local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Bind leader to tmux ctrl-b
config.leader =  { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
--
-- Binds for tmux
config.keys = {
    -- Fullscreen
    {
        key = 'F11',
        action = wezterm.action.ToggleFullScreen,
    },
    -- Split panes (like tmux " and %)
    {
        mods = 'LEADER|SHIFT',
        key = '"',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        mods = 'LEADER|SHIFT',
        key = '%',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    -- Navigate panes (like tmux Ctrl-b + arrow)
    {
        mods = 'LEADER',
        key = 'h',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        mods = 'LEADER',
        key = 'l',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
        mods = 'LEADER',
        key = 'k',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        mods = 'LEADER',
        key = 'j',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    -- Create/Close Tabs (Windows in tmux lingo)
    {
        mods = 'LEADER',
        key = 'c',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        mods = 'LEADER',
        key = '&',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    {
        mods = 'LEADER',
        key = 'n',
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        mods = 'LEADER',
        key = 'p',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    -- Show a searchable list of tabs/panes
    {
        mods = 'LEADER',
        key = 'w',
        action = wezterm.action.ShowTabNavigator,
    },
    {
        mods = 'LEADER',
        key = 'z',
        action = wezterm.action.TogglePaneZoomState,
    },

    -- Search
    {
        key = '/',
        mods = 'LEADER',
        action = wezterm.action.Search { CaseInSensitiveString = "" },
    },

    -- Copy/scroll mode
    {
        key = 's',
        mods = 'LEADER',
        action = wezterm.action.ActivateCopyMode,
    },
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_tab_bar = false

config.color_scheme = "Neutron"
config.hyperlink_rules = {}

return config
