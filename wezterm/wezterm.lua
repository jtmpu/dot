local wezterm = require("wezterm")
local act = wezterm.action

return {
    color_scheme = "Neutron",
    -- window_decorations = "NONE",
    enable_tab_bar = false,
    leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
    -- Disable hyperlinks
    hyperlink_rules = {},
    keys = {
        -- standard
        { key = "F11", action = wezterm.action.ToggleFullScreen },

        -- copy & paste
        { key = "C", mods = "CTRL|SHIFT", action = act.CopyTo "ClipboardAndPrimarySelection" },
        { key = "V", mods = "CTRL|SHIFT", action = act.PasteFrom "Clipboard" },

        -- tmux
        -- split
        { key = '"', mods = "LEADER|SHIFT", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
        { key = "%", mods = "LEADER|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        -- manage
        { key = "x", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },
        { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
        -- movement
        { key = "LeftArrow",  mods = "LEADER", action = act.ActivatePaneDirection("Left") },
        { key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
        { key = "UpArrow",    mods = "LEADER", action = act.ActivatePaneDirection("Up") },
        { key = "DownArrow",  mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    },
}
