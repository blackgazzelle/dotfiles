-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()
-- Holds actions
local act = wezterm.action

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- TODO
-- add n/p to go back and forth on tabs
-- set colorscheme
config.color_scheme = "Nord (base16)"

-- set font
config.font = wezterm.font("JetBrains Mono NF")

-- set leader for terminal
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }

local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

-- if you *ARE* lazy-loading smart-splits.nvim (not recommended)
-- you have to use this instead, but note that this will not work
-- in all cases (e.g. over an SSH connection). Also note that
-- `pane:get_foreground_process_name()` can have high and highly variable
-- latency, so the other implementation of `is_vim()` will be more
-- performant as well.
local function is_vim(pane)
	-- This gsub is equivalent to POSIX basename(3)
	-- Given "/foo/bar" returns "bar"
	-- Given "c:\\foo\\bar" returns "bar"
	local process_name = string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
	return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "SUPER" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

-- set keymappings to match tmux
config.keys = {
	-- splitting
	{ mods = "LEADER", key = "-", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "\\", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- zoom
	{ mods = "LEADER", key = "z", action = act.TogglePaneZoomState },
	-- rotate panes
	{ mods = "LEADER", key = "Space", action = act.RotatePanes("Clockwise") },
	-- show the pane selection mode, but have it swap the active and selected panes
	{ mods = "LEADER", key = "s", action = act.PaneSelect({
		mode = "SwapWithActive",
	}) },
	-- vim copy mode
	{ key = "Enter", mods = "LEADER", action = act.ActivateCopyMode },
	-- spawn tab
	{ mods = "LEADER", key = "c", action = act.SpawnTab("CurrentPaneDomain") },
	-- switch tab
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	-- kill tab
	{ key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
	-- search like tmux
	{ key = "/", mods = "LEADER", action = act.Search({ CaseInSensitiveString = "" }) },
	--
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
}

-- add in keys to switch tab with tab number
for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
	-- F1 through F8 to activate that tab
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

config.window_decorations = "RESIZE"
config.use_dead_keys = false
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.show_new_tab_button_in_tab_bar = false

config.window_frame = {
	-- The font used in the tab bar.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "JetBrainsMono NF" }),

	-- The size of the font in the tab bar.
	font_size = 12.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#2e3440",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#2e3440",
}

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#888888",
	},
}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#2e3440"
	local background = "#888888"
	local foreground = "#ffffff"

	if tab.is_active then
		background = "#81a1c1"
		foreground = "#ffffff"
	elseif hover then
		background = "#81a1c1"
		foreground = "#ffffff"
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- and finally, return the configuration to wezterm
return config
