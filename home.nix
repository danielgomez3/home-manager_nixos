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
    tex
    python
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
    # Dwm deps.
    xmenu
    gnumake
    qutebrowser
    polybar
    # Xournalpp
    xournalpp
    llvmPackages_rocm.clangNoCompilerRt
    gtk3 
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
    losslesscut-bin
    ffmpeg
    whatsapp-for-linux
    libreoffice
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
    font.size = 10.0;
    font.name = "SauceCodePro Nerd Font";
    #font.name = "Fira Code Nerd Font";
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
    };
    # This has to happen because kitty-theme derivation is broken:
    extraConfig = "
    startup_session $HOME/.config/home-manager/extraconfig/kitty-sessions/school.conf
      # BUG FIX:
      symbol_map U+f101-U+f21d nonicons
      # NAVIGATION
      map ctrl+shift+enter new_window_with_cwd 
      map ctrl+shift+f next_tab 
      map ctrl+shift+b previous_tab 
      map ctrl+shift+l next_window 
      map ctrl+shift+h previous_window 
      map ctrl+shift+c close_window 
      map map ctrl+shift+1 goto_tab 1
      map map ctrl+shift+2 goto_tab 2
      map map ctrl+shift+3 goto_tab 3
      map map ctrl+shift+4 goto_tab 4
      map map ctrl+shift+5 goto_tab 5
      map map ctrl+shift+6 goto_tab 6
      map map ctrl+shift+7 goto_tab 7
      map map ctrl+shift+8 goto_tab 8
      map map ctrl+shift+9 goto_tab 9
      #THEME:







# vim:ft=kitty

## name:     Catppuccin Kitty Latte
## author:   Catppuccin Org
## license:  MIT
## upstream: https://github.com/catppuccin/kitty/blob/main/latte.conf
## blurb:    Soothing pastel theme for the high-spirited!



# The basic colors
foreground              #4C4F69
background              #EFF1F5
selection_foreground    #EFF1F5
selection_background    #DC8A78

# Cursor colors
cursor                  #DC8A78
cursor_text_color       #EFF1F5

# URL underline color when hovering with mouse
url_color               #DC8A78

# Kitty window border colors
active_border_color     #7287FD
inactive_border_color   #9CA0B0
bell_border_color       #DF8E1D

# OS Window titlebar colors
wayland_titlebar_color system
macos_titlebar_color system

# Tab bar colors
#active_tab_foreground   #EFF1F5
#active_tab_background   #edc96d
#inactive_tab_foreground #4C4F69
inactive_tab_background #9CA0B0
tab_bar_background      #BCC0CC

# Colors for marks (marked text in the terminal)
mark1_foreground #EFF1F5
mark1_background #7287fD
mark2_foreground #EFF1F5
mark2_background #8839EF
mark3_foreground #EFF1F5
mark3_background #209FB5

# The 16 terminal colors

# black
color0 #5C5F77
color8 #6C6F85

# red
color1 #D20F39
color9 #D20F39

# green
color2  #40A02B
color10 #40A02B

# yellow
color3  #DF8E1D
color11 #DF8E1D

# blue
color4  #1E66F5
color12 #1E66F5

# magenta
color5  #EA76CB
color13 #EA76CB

# cyan
color6  #179299
color14 #179299

# white
color7  #ACB0BE
color15 #BCC0CC


     
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
    defaultEditor = true;
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
  languages = [
      {
        name = "rust";
        auto-format = false;
      }
      {
        name = "markdown";
        language-server = {command = "ltex-ls";};
        file-types = ["md"];
        scope = "source.markdown";
        roots = [""];
      }
    ];
    settings = {
      theme = "flatwhite";
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
    bashrcExtra = "
      neofetch --config /home/daniel/.config/home-manager/extraconfig/neofetch.conf --kitty --image_size none --source /home/daniel/.config/home-manager/images/blossomsmall.png --memory_percent on --memory_unit gib --os_arch off --packages tiny --shell_version off --color_blocks on
      ";

};













}
