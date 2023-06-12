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
      ranger = pkgs.ranger.overrideAttrs (r: {
  preConfigure = r.preConfigure + ''
    # Specify path to Überzug
    substituteInPlace ranger/ext/img_display.py \
      --replace "Popen(['ueberzug'" \
                "Popen(['${pkgs.ueberzug}/bin/ueberzug'"

    # Use Überzug as the default method
    substituteInPlace ranger/config/rc.conf \
      --replace 'set preview_images_method w3m' \
                'set preview_images_method ueberzug'
  '';
});


    in
  [
    # Terminal Emulator:
    unstable.wezterm
    xorg.xcursorgen
    xorg.xcursorthemes
    # Coding:
    #eclipses.eclipse-jee
    #jetbrains.webstorm
    #sublime
    vscode-fhs
    tex
    python3
    R-with-my-packages
    nodejs
    nodePackages_latest.vscode-html-languageserver-bin
    nodePackages_latest.typescript-language-server
    # Neovim/Text editor deps.
    erlang-ls
    erlang
    ltex-ls
    texlab
    nodejs
    ripgrep-all
    ripgrep
    fd
    # Xournalpp & deps.
    xournalpp
    gtk3 
    # Kitty terminal deps.
    libxkbcommon
    # Rediff command
    patchutils
    # File traversal/Project management
    # For nnn:
    findutils
    poppler_utils 
    bat
    ffmpegthumbnailer
    glow
    jump
    autojump
    fzf
    mpv
    svox
    # Mime type stuff:
    xdg-utils
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
    imagemagick
    swaylock
    swayidle
    grim
    w3m
    imgcat
    vimb
    
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

  
  # Change Default apps:
  nixpkgs.config.allowUnfree = true;

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["zathura.desktop"];
    };
    defaultApplications = {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "text/plain" = ["Helix-wezterm.desktop"];
    };
  };
  
  # Xdg desktop entries
  xdg.desktopEntries = {
    Helix-wezterm = {
      name = "Helix-wezterm";
      genericName = "Daniel's App: helix-wezterm";
      exec = ''
      wezterm start -- hx \$\* \& disown -a
      '';
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" "text/plain" ];
    };
#        nnn = {
#      name = "nnn";
#      genericName = "Daniel's App: nnn";
#      exec = ''
#      wezterm start --always-new-process nnn -r -e -P p 
#      '';
#      terminal = false;
#      categories = [ "Network" "WebBrowser" ];
#    };

  };

  
      
        
  # Rofi:
  programs.rofi = {
        enable = true;
        theme = "sidebar";
      };  
  
  
  
    
  

  # Qutebrowser
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "https://google.com/search?hl=en&q={}";
    };
    extraConfig = 
    ''
    c.scrolling.smooth = True
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
  nixpkgs.overlays = [ 
  (self: super: {

    lf = super.lf.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            repo = "lf";
            owner = "horriblename";
            rev = "HEAD";
            sha256 = "sha256-cQf+OP1u6lf/7QgT/Rg9613Igx4YjqEUchmjsk31Z8c=";
            };
      });

  
    picom = super.picom.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            repo = "picom";
            owner = "jonaburg";
            rev = "HEAD";
            sha256 = "4voCAYd0fzJHQjJo4x3RoWz5l3JJbRvgIXn1Kg6nz6Y=";
            };
      });
  }) 
  
  
  
  ];


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
 
  

  # Helix editor:
  programs.helix = {
    enable = true;
    package = unstable.helix;
    languages = {
      language = [{
        name = "markdown";
        file-types = ["md"];
        scope = "source.markdown";
        roots = [];
        language-server = with pkgs; { 
          command = "ltex-ls"; 
        };
      }];
    };
    
    settings = {
        theme = "base16_transparent";
        editor.soft-wrap = {
            enable = true;
            max-wrap = 25;
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
            #display-inlay-hints = true;
            snippets = true;
          };
        };
      };
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
    package = unstable.wezterm;
    extraConfig = ''
      local wezterm = require("wezterm")
      local act = wezterm.action
      local config = {}




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
      		left = 10,
      		right = 10,
      		top = 10,
      		bottom = 5,
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
  { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock"; }
  { event = "lock"; command = "lock"; }
          ];

    timeouts = [
      {
        timeout = 550;
        command = "${pkgs.sway}/bin/swaymsg \"output * dpms off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * dpms on\"";
      }
      {
        timeout = 710;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
  };


  programs.swaylock = {
    enable = true;
#    settings = {
#        color = "808080";
#        font-size = 24;
#        indicator-idle-visible = false;
#        indicator-radius = 100;
#        line-color = "ffffff";
#        show-failed-attempts = true;
#    };
        settings = {
          show-failed-attempts = true;
          daemonize = true; # Detach from the controlling terminal after locking
          screenshots = true;
          ignore-empty-password = true;
          disable-caps-lock-text = true;

          font = "RobotoMono Nerd Font";
          font-size = 30;

          clock = true;
          indicator = true;
          indicator-idle-visible = true;
          indicator-radius = 120;
          indicator-caps-lock = true;
          line-uses-inside = true;

          effect-blur = "20x3";
          fade-in = 0.1;

#          ring-color = "#${colorScheme.surface0}";
#          inside-wrong-color = "#${colorScheme.red}";
#          ring-wrong-color = "#${colorScheme.red}";
#          key-hl-color = "#${colorScheme.green}";
#          bs-hl-color = "#${colorScheme.red}";
#          ring-ver-color = "#${colorScheme.peach}";
#          inside-ver-color = "#${colorScheme.peach}";
#          inside-color = "#${colorScheme.mantle}";
#          text-color = "#${colorScheme.lavender}";
#          text-clear-color = "#${colorScheme.mantle}";
#          text-ver-color = "#${colorScheme.mantle}";
#          text-wrong-color = "#${colorScheme.mantle}";
#          text-caps-lock-color = "#${colorScheme.lavender}";
#          inside-clear-color = "#${colorScheme.teal}";
#          ring-clear-color = "#${colorScheme.teal}";
#          inside-caps-lock-color = "#${colorScheme.peach}";
#          ring-caps-lock-color = "#${colorScheme.surface0}";
#          separator-color = "#${colorScheme.surface0}";
        };
  };

  programs.papis = {
    enable = true;
    libraries = {
      papers = {
        isDefault = true;
        settings = {
          dir = "~/Papers";
          opentool = "zathura";
          picktool = "fzf";
          editor = "hx";
          file-browser = "ranger";
          add-edit = true;
        };
      };
    };
  };



  home.sessionPath = [
    "$HOME/.config/home-manager/extraconfig/nnn/"
  ];

  home.sessionVariables = {
    READER = "zathura";
  };

  programs.nnn = {
    enable = true;
  };


  programs.zathura = {
  enable = true;
  extraConfig = 
  ''
      # Zathura configuration file
      # See man `man zathurarc'

      # Open document in fit-width mode by default
      set adjust-open "best-fit"

      # One page per row by default
      set pages-per-row 1

      #stop at page boundries
      set scroll-page-aware "true"
      set smooth-scroll "true"
      set scroll-full-overlap 0.01
      set scroll-step 100

      #zoom settings
      set zoom-min 10
      set guioptions ""

      # zathurarc-dark

      set font "inconsolata 12"
      set default-bg "#000000" #00
      set default-fg "#F7F7F6" #01

      set statusbar-fg "#B0B0B0" #04
      set statusbar-bg "#202020" #01

      set inputbar-bg "#151515" #00 currently not used
      set inputbar-fg "#FFFFFF" #02

      set notification-error-bg "#AC4142" #08
      set notification-error-fg "#151515" #00

      set notification-warning-bg "#AC4142" #08
      set notification-warning-fg "#151515" #00

      set highlight-color "#F4BF75" #0A
      set highlight-active-color "#6A9FB5" #0D

      set completion-highlight-fg "#151515" #02
      set completion-highlight-bg "#90A959" #0C

      set completion-bg "#303030" #02
      set completion-fg "#E0E0E0" #0C

      set notification-bg "#90A959" #0B
      set notification-fg "#151515" #00

      set recolor "true"
      set recolor-lightcolor "#000000" #00
      set recolor-darkcolor "#E0E0E0" #06
      set recolor-reverse-video "true"
      set recolor-keephue "true"

      set scroll-step 50

  '';
};


  #programs.eclipse = {
  #  enable = true;
  #  package = pkgs.eclipses.eclipse-jee;
  #};

 
    

  



}
