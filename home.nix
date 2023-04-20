{pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
      dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
  });
in
{
  home.packages = with pkgs; [
    # Qutebrowser deps:
    #python39Packages.adblock
    # Coding:
    tex
    # Neovim/Text editor deps.
    erlang-ls
    ltex-ls
    texlab
    nodejs
    ripgrep-all
    ripgrep
    fd
    # Dwm deps.
    xmenu
    gnumake
    qutebrowser
    polybar
    # Etc.:
    zathura
    pavucontrol
    neofetch
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
  programs.zsh = {
    enable = true;
       initExtra = 
      "
      neofetch --config /home/daniel/.config/home-manager/extraconfig/neofetch.conf --kitty --image_size none --source /home/daniel/.config/home-manager/images/blossom.png --memory_percent on --memory_unit gib --os_arch off --packages tiny --shell_version off --color_blocks on
      ";
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git"];
      # Really Good, Minimal, Time, Git.
      theme = "dst"; 
    };
  };
  
  
  

  
      
        
  # Rofi:
  programs.rofi = {
        enable = true;
        theme = "sidebar";
      };  
  
  # Helix editor:
#  programs.helix.enable = false;
#  programs.helix = {
#    languages = [
#      {
#        name = "rust";
#        auto-format = false;
#      }
#      {
#        name = "markdown";
#        language-server = {command = "ltex-ls";};
#        file-types = ["md"];
#        scope = "source.markdown";
#        roots = [""];
#      }
#    ];
#    settings = {
#        theme = "catppuccin_frappe";
#        editor = {
#          line-number = "relative";
#          rulers = [80];
#        };
#    };
#  };
  
  
  # Kitty Terminal:
  programs.kitty = {
    enable = true;
    #theme = "DarkOneNuanced";
    font.size = 10.0;
    font.name = "Fira Code";
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
    };
    # This has to happen because kitty-theme derivation is broken:
    extraConfig = "
       map ctrl+shift+enter new_window_with_cwd 
       map ctrl+shift+t new_tab_with_cwd 
       map ctrl+shift+f next_tab 
       map ctrl+shift+b previous_tab 
       map ctrl+shift+n next_window 
       map ctrl+shift+p previous_window 
      # Dark One Nuanced by ariasuni, https://store.kde.org/p/1225908
      # Imported from KDE .colorscheme format by thematdev, https://thematdev.org
      # For migrating your schemes from Konsole format see 
      # https://git.thematdev.org/thematdev/konsole-scheme-migration

      cursor                  #928374
cursor_text_color       background

url_color               #458588

visual_bell_color       #689d6a
bell_border_color       #689d6a

active_border_color     #b16286
inactive_border_color   #1d2021

foreground              #3c3836
background              #fbf1c7
selection_foreground    #928374
selection_background    #3c3836

active_tab_foreground   #282828
active_tab_background   #928374
inactive_tab_foreground #7c6f64
inactive_tab_background #ebdbb2

# white (bg3/bg4)
color0                  #bdae93
color8                  #a89984

# red
color1                  #cc241d
color9                  #9d0006

# green
color2                  #98971a
color10                 #79740e

# yellow
color3                  #d79921
color11                 #b57614

# blue
color4                  #458588
color12                 #076678

# purple
color5                  #b16286
color13                 #8f3f71

# aqua
color6                  #689d6a
color14                 #427b58

# black (fg4/fg3)
color7                  #7c6f64
color15                 #665c54

        #      # importing Background
        #      background #282c34
        #      # importing BackgroundFaint
        #      # importing BackgroundIntense
        #      # importing Color0
        #      color0 #3f4451
        #      # importing Color0Faint
        #      color16 #282c34
        #      # importing Color0Intense
        #      color8 #4f5666
        #      # importing Color1
        #      color1 #e06c75
        #      # importing Color1Faint
        #      color17 #c25d66
        #      # importing Color1Intense
        #      color9 #ff7b86
        #      # importing Color2
        #      color2 #98c379
        #      # importing Color2Faint
        #      color18 #82a566
        #      # importing Color2Intense
        #      color10 #b1e18b
        #      # importing Color3
        #      color3 #d19a66
        #      # importing Color3Faint
        #      color19 #b38257
        #      # importing Color3Intense
        #      color11 #efb074
        #      # importing Color4
        #      color4 #61afef
        #      # importing Color4Faint
        #      color20 #5499d1
        #      # importing Color4Intense
        #      color12 #67cdff
        #      # importing Color5
        #      color5 #c678dd
        #      # importing Color5Faint
        #      color21 #a966bd
        #      # importing Color5Intense
        #      color13 #e48bff
        #      # importing Color6
        #      color6 #56b6c2
        #      # importing Color6Faint
        #      color22 #44919a
        #      # importing Color6Intense
        #      color14 #63d4e0
        #      # importing Color7
        #      color7 #e6e6e6
        #      # importing Color7Faint
        #      color23 #c8c8c8
        #      # importing Color7Intense
        #      color15 #ffffff
        #      # importing Foreground
        #      foreground #abb2bf
        #      # importing ForegroundFaint
        #      # importing ForegroundIntense
        #      # importing General";
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

  
  # Picom
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
    extraConfig = ''
	set number relativenumber
        nnoremap <SPACE> <Nop>
        let mapleader = " "
        set cursorline
        "set cursorcolumn 
        set colorcolumn=80 
        set scrollbind


	"TELESCOPE:
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>
	" Using Lua functions
	nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
	nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
	nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
	nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

        " VIEW FILE IN TWO COLLUMNS (leader+vs):
        noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

    '';
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
        plugin = pkgs.vimPlugins.vim-nix;
      }
      {
        plugin = pkgs.vimPlugins.coc-nvim;
      }
      {
        plugin = pkgs.vimPlugins.coc-git;
      }
      {
        plugin = pkgs.vimPlugins.coc-texlab;
      }
      {
        plugin = pkgs.vimPlugins.coc-pyright;
      }
     {
        plugin = pkgs.vimPlugins.telescope-nvim;
      }
     {
        plugin = pkgs.vimPlugins.nvim-treesitter;
      }
    
    ];
  };
  




  
  
  

}
