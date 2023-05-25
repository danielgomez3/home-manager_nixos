local wezterm = require "wezterm"
local mux = wezterm.mux
--    ^ multiplexer
 
wezterm.on('gui-startup', function()
  local project_dir = wezterm.home_dir .. '/School/'
 
  local tab, main_pane, window = mux.spawn_window {
    cwd = project_dir,
  }
  local typecheck_pane = main_pane:split {
    direction = 'Right',
    cwd = project_dir,
  }
  typecheck_pane:send_text 'echo "henlo"\n'
  -- NOTE: '\n' will execute the command, otherwise it will be only pasted
 
  local nextjs_pane = typecheck_pane:split {
    direction = 'Bottom',
    cwd = project_dir,
  }
  nextjs_pane:send_text 'erl\n'
end)
 












return {
    -- Terminal configuration options (fonts, color scheme...)






  font_size = 10.0,

	-- OpenGL for GPU acceleration, Software for CPU
	front_end = "OpenGL",

	color_scheme = 'Catppuccin Mocha',

	-- Cursor style
	default_cursor_style = "BlinkingUnderline",

	-- X11
	enable_wayland = true,

	-- Aesthetic Night Colorscheme
	bold_brightens_ansi_colors = true,
	-- Padding
	window_padding = {
		left = 15,
		right = 15,
		top = 10,
		bottom = 10,
	},

	-- Tab Bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = true,

	-- General
	automatically_reload_config = true,
	inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
	window_background_opacity = 0.4,
	window_close_confirmation = "NeverPrompt",




















  
}


