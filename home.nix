{pkgs, lib,... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full
      dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
  });
in
{
  home.packages = with pkgs;
    let
      R-with-my-packages = rWrapper.override{ packages = with rPackages; [ ggplot2 dplyr xts tidyverse ggthemes]; };
    in
  [
    # Qutebrowser deps:
    #python39Packages.adblock
    # Coding:
    #tex
    python3
    R-with-my-packages
    # Neovim/Text editor deps.
    erlang-ls
    erlang
    ltex-ls
    texlab
    nodejs
    ripgrep-all
    ripgrep
    fd
    fzf
    # Dwm/i3wm deps.
    #xmenu
    #gnumake
    #qutebrowser
    #polybar
    #autotiling
    # Xournalpp
    xournalpp
    gtk3 
    # Kitty terminal dep.
    libxkbcommon
    # Rediff command
    patchutils

    # Etc.:
    zathura
    pavucontrol
    picom
    rofi
    xclip
    flameshot
    brightnessctl
    xbanish
    kitty
    flashfocus
    feh
    wally-cli
    spotify
    vlc
    ffmpeg
    whatsapp-for-linux
    sshfs
    autossh
    hackgen-nf-font
    terminus-nerdfont
    pandoc
    tmux
    xfce.ristretto
    poppler_utils # Used for pdf and png conversion
    unzip
    gnome3.adwaita-icon-theme
    marksman
    libsForQt5.kdenlive # Video editing
    obs-studio-plugins.input-overlay
    zoom-us
    libreoffice
    cmatrix
    onefetch
    killall # killall command
    imgcat
    imagemagick
    swaylock
    swayidle
    
  ];


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "daniel";
  home.homeDirectory = "/home/daniel";


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  
  # Set default editor (for sudoedit, etc.):
  #environment.variables.EDITOR = "nvim";
  
  # Here's what's happening: I'm combining themes in a hacky way. Sourcing
  # One, declaring another. This will break. Looks great rn tho.

  

  
      
        
  # Rofi:
  programs.rofi = {
        enable = true;
        theme = "sidebar";
      };  
  
  
  
  # Kitty Terminal:
  programs.kitty = {
    enable = true;
    font.size = 10;
    #font.name = "SauceCodePro Nerd Font";
    font.name = "Fira Code";
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
    };
    # This has to happen because kitty-theme derivation is broken:
    extraConfig = "
    background_opacity 0.8
    #foreground              #C6D0F5
    #background              #303446
    #selection_foreground    #303446
    #selection_background    #F2D5CF
    #startup_session $HOME/.config/home-manager/extraconfig/kitty-sessions/school.conf
      # WINDOW PADDING:
      window_padding_width 2
      # BUG FIX:
      #symbol_map U+f101-U+f21d nonicons
      # NAVIGATION
      map ctrl+shift+enter new_window_with_cwd 
      map ctrl+shift+l next_window 
      map ctrl+shift+h previous_window 
      map ctrl+shift+q close_window 
      map ctrl+shift+; next_layout
      #THEME:




## name:     Catppuccin Kitty Latte
## author:   Catppuccin Org
## license:  MIT
## upstream: https://github.com/catppuccin/kitty/blob/main/latte.conf
## blurb:    Soothing pastel theme for the high-spirited!



#   # The basic colors
#   foreground              #4C4F69
#   background              #EFF1F5
#   selection_foreground    #EFF1F5
#   selection_background    #DC8A78
#   
#   # Cursor colors
#   cursor                  #DC8A78
#   cursor_text_color       #EFF1F5
#   
#   # URL underline color when hovering with mouse
#   url_color               #DC8A78
#   
#   # Kitty window border colors
#   active_border_color     #7287FD
#   inactive_border_color   #9CA0B0
#   bell_border_color       #DF8E1D
#   
#   # OS Window titlebar colors
#   wayland_titlebar_color system
#   macos_titlebar_color system
#   
#   # Tab bar colors
#   active_tab_foreground   #EFF1F5
#   active_tab_background   #353240
#   inactive_tab_foreground #4C4F69
#   inactive_tab_background #9CA0B0
#   tab_bar_background      #BCC0CC
#   
#   # Colors for marks (marked text in the terminal)
#   mark1_foreground #EFF1F5
#   mark1_background #7287fD
#   mark2_foreground #EFF1F5
#   mark2_background #8839EF
#   mark3_foreground #EFF1F5
#   mark3_background #209FB5
#   
#   # The 16 terminal colors
#   
#   # black
#   color0 #5C5F77
#   color8 #6C6F85
#   
#   # red
#   color1 #D20F39
#   color9 #D20F39
#   
#   # green
#   color2  #40A02B
#   color10 #40A02B
#   
#   # yellow
#   color3  #DF8E1D
#   color11 #DF8E1D
#   
#   # blue
#   color4  #1E66F5
#   color12 #1E66F5
#   
#   # magenta
#   color5  #EA76CB
#   color13 #EA76CB
#   
#   # cyan
#   color6  #179299
#   color14 #179299
#   
#   # white
#   color7  #ACB0BE
#   color15 #BCC0CC
#   
#   
#   
#   
#   #foreground #979eab
#   #background #282c34
#   #cursor #cccccc
#   #color0 #282c34
#   #color1 #e06c75
#   #color2 #98c379
#   #color3 #e5c07b
#   #color4 #61afef
#   #color5 #be5046
#   #color6 #56b6c2
#   #color7 #979eab
#   #color8 #393e48
#   #color9 #d19a66
#   #color10 #56b6c2
#   #color11 #e5c07b
#   #color12 #61afef
#   #color13 #be5046
#   #color14 #56b6c2
#   #color15 #abb2bf
#   #selection_foreground #282c34
#   #selection_background #979eab














";




  };
  

    
  

  # Qutebrowser
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "https://google.com/search?hl=en&q={}";
    };
    extraConfig = 
    ''
    c.url.start_pages = ['google.com']

    import os
    from urllib.request import urlopen

    # load your autoconfig, use this, if the rest of your config is empty!
    config.load_autoconfig()

    if not os.path.exists(config.configdir / "theme.py"):
        theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
        with urlopen(theme) as themehtml:
            with open(config.configdir / "theme.py", "a") as file:
                file.writelines(themehtml.read().decode("utf-8"))

    if os.path.exists(config.configdir / "theme.py"):
        import theme
        theme.setup(c, 'frappe', True)
    
    '';
    
  };

  
  # Overlays
  nixpkgs.overlays = [ (self: super: {
    picom = super.picom.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            repo = "picom";
            owner = "jonaburg";
            rev = "HEAD";
            sha256 = "4voCAYd0fzJHQjJo4x3RoWz5l3JJbRvgIXn1Kg6nz6Y=";
            };
      });
  }) ];


  services.picom = {
    extraArgs = 
    ["--config /home/danie/.config/home-manager/picom.conf"
    "--experimental-backends"];
  };  
  
  
  # Git
  programs.git = {
    enable = true;
    userName = "danielgomez3";
    userEmail = "danielgomez3@verizon.net";
  };  
 
  
  nixpkgs.config.allowUnfree = true;

  
  # Neovim

   programs.neovim = {
    enable = true;
    extraConfig = lib.fileContents "/home/daniel/.config/home-manager/extraconfig/nvim/vimrc.vim";
    plugins = [
      pkgs.vimPlugins.nvim-tree-lua
      {
        plugin = pkgs.vimPlugins.gruvbox-nvim;
        config = ''
        set background=light " or light if you want light mode
        colorscheme gruvbox
        '';
      }
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
        config = ''
        lua require'lspconfig'.erlangls.setup{}
        lua require'lspconfig'.texlab.setup{}
        lua require'lspconfig'.ltex.setup{"markdown", "org", "tex"}
        '';
      }
      {
        plugin = pkgs.vimPlugins.packer-nvim;
      }

      {
        plugin = pkgs.vimPlugins.vim-nix;
      }
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
      }
     {
        plugin = pkgs.vimPlugins.nvim-treesitter;
      }
     {
        plugin = pkgs.vimPlugins.vim-startify;
      }
     {
        plugin = pkgs.vimPlugins.lualine-nvim;
      }
     {
        plugin = pkgs.vimPlugins.nvim-web-devicons;
      }
     {
        plugin = pkgs.vimPlugins.telescope-file-browser-nvim;
      }
     {
        plugin = pkgs.vimPlugins.vim-easymotion;
      }
     {
        plugin = pkgs.vimPlugins.vim-surround;
      }
     {
        plugin = pkgs.vimPlugins.markdown-preview-nvim;
      }
     {
        plugin = pkgs.vimPlugins.vim-fugitive;
      }
    
    ];
  };
  



  # Helix editor:
  programs.helix = {
  enable = true;
  package = unstable.helix;
    languages = [{
    name = "markdown";
    file-types = ["md"];
    scope = "source.markdown";
    roots = [];
    }];
  settings = {
      theme = "base16_transparent";
      editor.soft-wrap = {
          enable = true;
          max-wrap = 25;
        };
      keys = {
        insert = {
          j = {
            j = "normal_mode";
          };
        };
      };
      editor = {
        auto-save = true;
        completion-trigger-len = 1;
        line-number = "relative";
        rulers = [80];
        whitespace = {
          render = {
            space = "all";
            tab = "all";
            newline = "all";
          };
          characters = {
            nbsp = "⍽";
            tab = "→";
            newline = "⏎";
            tabpad = "·"; 
          };
        };
        file-picker = {
          hidden = false;
        };
        cursor-shape = {
          insert = "bar";
          normal = "underline";
          select = "underline";
        };
        lsp = {
          display-inlay-hints = true;
          snippets = true;
        };
      };
    };
  };
#




  # ZSH:
#  programs.zsh = {
#  enable = true;
# initExtra = 
#    "
#    neofetch --config /home/daniel/.config/home-manager/extraconfig/neofetch.conf --kitty --image_size none --source /home/daniel/.config/home-manager/images/blossomsmall.png --memory_percent on --memory_unit gib --os_arch off --packages tiny --shell_version off --color_blocks on
#    ";
#  };



  programs.bash = {
    enable = true;
    shellAliases = {
      Pdferlang = " zathura ~/School/erlang/*.pdf ~/School/erlang/cse381/*.pdf ~/School/erlang/cse481/*.pdf ~/School/erlang/cse481/grading/*.pdf ~/School/erlang/cse381/grading/*.pdf & disown";
      Projects = "kitty --session /home/daniel/.config/home-manager/extraconfig/kitty-sessions/school.conf & disown";
      Hyprland = "Hyprland -c /home/daniel/.config/home-manager/extraconfig/hyprland/hyprland.conf";
      hyprpaper = "hyprpaper -c /home/daniel/home-manager/extraconfig/hyprpaper/hyprpaper.conf";
      #pdferlang = " zathura ~/School/erlang/*.pdf ~/School/erlang/cse381/*.pdf ~/School/erlang/cse481/*.pdf & disown";
    };
    bashrcExtra = ''
      neofetch --config /home/daniel/.config/home-manager/extraconfig/neofetch.conf --kitty --image_size none --source /home/daniel/.config/home-manager/images/commonlisp.png --memory_percent on --memory_unit gib --os_arch off --packages tiny --shell_version off --color_blocks on 
      #function pdf() { zathura  "$@" & disown; }
      function Pdf() { zathura  ./*.pdf & disown; }

    ''; 

};


programs.zathura = {
  enable = true;
  extraConfig = ''
  set selection-clipboard clipboard

  set default-fg                "#C6D0F5"
  set default-bg 			          "#303446"

  set completion-bg		          "#414559"
  set completion-fg		          "#C6D0F5"
  set completion-highlight-bg	  "#575268"
  set completion-highlight-fg	  "#C6D0F5"
  set completion-group-bg		    "#414559"
  set completion-group-fg		    "#8CAAEE"

  set statusbar-fg		          "#C6D0F5"
  set statusbar-bg		          "#414559"

  set notification-bg		        "#414559"
  set notification-fg		        "#C6D0F5"
  set notification-error-bg	    "#414559"
  set notification-error-fg	    "#E78284"
  set notification-warning-bg	  "#414559"
  set notification-warning-fg	  "#FAE3B0"

  set inputbar-fg			          "#C6D0F5"
  set inputbar-bg 		          "#414559"

  set recolor-lightcolor		    "#303446"
  set recolor-darkcolor		      "#C6D0F5"

  set index-fg			            "#C6D0F5"
  set index-bg			            "#303446"
  set index-active-fg		        "#C6D0F5"
  set index-active-bg		        "#414559"

  set render-loading-bg		      "#303446"
  set render-loading-fg		      "#C6D0F5"

  set highlight-color		        "#575268"
  set highlight-fg              "#F4B8E4"
  set highlight-active-color	  "#F4B8E4"
  '';
};


  programs.obs-studio = {
    package = unstable.obs-studio;
    enable = true;
    
  };
  

  programs.waybar.settings = {
    enable = true;
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = [
        "eDP-1"
        "HDMI-A-1"
      ];
      modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
      modules-center = [ "sway/window" "custom/hello-from-waybar" ];
      modules-right = [ "mpd" "custom/mymodule#with-css-id" "temperature" ];

      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };
      "custom/hello-from-waybar" = {
        format = "hello {}";
        max-length = 40;
        interval = "once";
        exec = pkgs.writeShellScript "hello-from-waybar" ''
          echo "from within waybar"
        '';
      };
    };
  };


  programs.waybar.systemd = {
    enable = true;
  };

  
  programs.wezterm = {
    enable = true;
    extraConfig = ''
    local wezterm = require("wezterm")



return {
  -- Font
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
	window_background_opacity = 0.7,
	window_close_confirmation = "NeverPrompt",
}
    '';
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
    ];

    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.sway}/bin/swaymsg \"output * dpms off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * dpms on\"";
      }
      {
        timeout = 310;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
  };


  programs.swaylock = {
    enable = true;
    settings = {
        color = "808080";
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 100;
        line-color = "ffffff";
        show-failed-attempts = true;
    };
  }; 




}
