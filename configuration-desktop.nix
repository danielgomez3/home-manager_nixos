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

  # This is for swalock
  programs.sway = {
    enable = true;
  };

users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    shellInit = 
      "
      neofetch --config /home/daniel/.config/home-manager/extraconfig/neofetch.conf --kitty --image_size none --source /home/daniel/.config/home-manager/images/csmaller.png --memory_percent on --memory_unit gib --os_arch off --packages tiny --shell_version off --color_blocks on 
      set -U fish_greeting
      ";
      #function Pdf() { zathura  ./*.pdf & disown; }
      #function pdf() { zathura  "$@" & disown; }
    shellAliases = {
      Pdferlang = " zathura ~/School/erlang/*.pdf ~/School/erlang/cse381/*.pdf ~/School/erlang/cse481/*.pdf ~/School/erlang/cse481/grading/*.pdf ~/School/erlang/cse381/grading/*.pdf & disown";
      Projects = "kitty --session /home/daniel/.config/home-manager/extraconfig/kitty-sessions/school.conf & disown";
      Hyprland = "Hyprland -c /home/daniel/.config/home-manager/extraconfig/hyprland/hyprland.conf";
      hyprpaper = "hyprpaper -c /home/daniel/home-manager/extraconfig/hyprpaper/hyprpaper.conf";
      n = "nnn -r -e -P p";
    };
  };

  programs.starship = {
    enable = true;
  };




}