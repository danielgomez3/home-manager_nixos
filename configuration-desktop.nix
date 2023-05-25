# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,pkgs,lib, ... }: 
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports =

    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # FOR OBS-STUDIO:
  boot.kernelModules = [ "kvm-intel" "hid-nintendo" "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Boise";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.daniel = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      description = "the one and only";
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget curl iwd dhcpcd neovim
    git cachix 
    st chromium rofi dmenu source-code-pro neofetch
    sshfs fuse 
    kitty gtk3 alacritty
    unstable.hyprland unstable.wofi unstable.hyprpaper wl-clipboard wlr-randr wlr-protocols wlroots wlrctl 
    eww-wayland
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    #passwordAuthentication = false;
    #kbdInteractiveAuthentication = false;
  };
  #users.users.daniel.openssh.authorizedKeys.keys = [];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  ## DANIEL'S ADDED OPTIONS:



  # Networking:
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
	

  # Shell (needs to be done here and home.nix):
  #users.users.daniel.shell = pkgs.zsh;
  #environment.shells = with pkgs; [ zsh ]; # For errors.
  #programs.zsh = {
  #enable = true;
  #histSize = 2000;
  #histFile = "$HOME/.zsh_history";
  #shellAliases = {
  #    ll = "ls -l";
  #    update = "sudo nixos-rebuild switch";
  #    vi = "nvim";
  #};
  #};



  
#  # Dwm:
#  services.xserver.displayManager.lightdm.enable = false;
#  services.xserver.displayManager.startx.enable = true;
#  services.xserver.windowManager.dwm.enable = true;
#  hardware.opengl.enable = true;
#  services.xserver.enable = true;
#
#
#  # Dwm:
#  nixpkgs.overlays = [ (self: super: {
#    dwm = super.dwm.overrideAttrs (old: {
#      pname = "dwm";
#      version = "6.2";
#      src = super.fetchurl {
#        url = "https://dl.suckless.org/dwm/dwm-6.2.tar.gz";
#        sha256 = "l5AuLgB6rqo8bjvtH4F4W4F7dBOUfx2x07YrjaTNEQ4=";
#      };
#      patches = [
#        (super.fetchpatch {
#          url = "https://raw.githubusercontent.com/danielgomez3/dwmpatch/main/new.diff";
#          sha256 = "0bzr1mz9kdhkvh85qi9f5g4bw6amv77qzgffl090829jlcb3vimy";
#        })
#      ];
#    });
#}) ];
#

  # I3WM:
  #environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  #services.xserver = {
  #  enable = true;

  #  desktopManager = {
  #    xterm.enable = false;
  #  };
  # 
  #  displayManager = {
  #      defaultSession = "none+i3";
  #  };

  #  windowManager.i3 = {
  #    package = pkgs.i3-gaps;
  #    enable = true;
  #    configFile = /home/daniel/.config/home-manager/extraconfig/i3/i3config;
  #    extraPackages = with pkgs; [
  #      dmenu #application launcher most people use
  #      i3status # gives you the default i3 status bar
  #      i3lock #default i3 screen locker
  #      i3blocks #if you are planning on using i3blocks over i3status
  #   ];
  #  };
  #};










  
  


  # Don't ask users of group 'wheel' for a password:
  security.sudo.wheelNeedsPassword = false; 
  

  # Enable flakes and experimental features
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    
  };
  
  services.udev.packages = with pkgs; [ zsa-udev-rules ];


  # Bluetooth
  hardware.bluetooth.enable = true;
  

  programs.ssh.askPassword = "";




  services = {
    syncthing = {
        enable = true;
        user = "daniel";
        dataDir = "/home/daniel/School/";    # Default folder for new synced folders
        configDir = "/home/daniel/.config/home-manager/extraconfig/syncthing";   # Folder for Syncthing's settings and keys
    };
};



fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "SourceCodePro"]; })
];





#systemd.mounts = [
#  {
#  what = "jodango@45.63.36.141:/home/jodango/School/";
#  where = "/home/daniel/School";
#  type = "fuse.sshfs";
#  options = "identityfile=/home/daniel/.ssh/desktop_key,allow_other,user,reconnect,ServerAliveInterval=5,delay_connect,ConnectTimeout=5";
#  wantedBy = [ "multi-user.target" ];
#  }
#];


#users.defaultUserShell = pkgs.zsh;
#programs.zsh = {
#  enable = true;
#  shellAliases = {
#    vi = "nvim";
#    hx = "hx --config /home/daniel/.config/home-manager/extraconfig/helix/config.toml";
#    ll = "ls -l";
#    update = "sudo nixos-rebuild switch";
#    };
#  };
users.defaultUserShell = pkgs.bash;
programs.bash = {
  enableCompletion = true;
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
    vi = "nvim";
    #hx = "hx --config /home/daniel/.config/home-manager/extraconfig/helix/config.toml";
  };
  promptInit =  ''
    # PS1="\n\[\033[01;32m\]\u@\h $\[\033[00m\]\[\033[01;36m\] \w λ\[\033[00m\]\n"
    PS1="\n\[\033[01;32m\]\u@\h λ\[\033[00m\]\[\033[01;36m\] \w \[\033[00m\]\n"
    echo -e -n "\x1b[\x33 q" # changes to blinking underline
    stty -ixon # Turn off ctrl-s to pause terminal

    '';
}; 


  # Steam:
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};
 nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
    "steam-run"
  ];


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  # Waybar Overlay
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  programs.sway = {
    enable = true;
  };


}
