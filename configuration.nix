# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,pkgs,lib, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    st chromium rofi dmenu source-code-pro 

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
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };
  users.users.daniel.openssh.authorizedKeys.keys = [
"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   " 
];

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
  programs.zsh.enable = true;
  users.users.daniel.shell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ]; # For errors.

  
  # Dwm:
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  hardware.opengl.enable = true;
  services.xserver.enable = true;
  nixpkgs.overlays = [ (self: super: {
    dwm = super.dwm.overrideAttrs (old: {
      pname = "dwm";
      version = "6.2";
      src = super.fetchurl {
        url = "https://dl.suckless.org/dwm/dwm-6.2.tar.gz";
        sha256 = "l5AuLgB6rqo8bjvtH4F4W4F7dBOUfx2x07YrjaTNEQ4=";
      };
      patches = [
        (super.fetchpatch {
          url = "https://raw.githubusercontent.com/danielgomez3/dwmpatch/main/danielgomez3_dwm.diff";
          sha256 = "1a5bxl3ww0iyfskv8v67lsjwm9r778d20lijwmvf25iqdnbh005i";
        })
      ];
    });
}) ];

#  nixpkgs.overlays = [ (self: super: {
#    dwm = super.dwm.overrideAttrs (old: {
#      pname = "dwm";
#      version = "6.2";
#      src = super.fetchurl {
#        url = "https://dl.suckless.org/dwm/dwm-6.2.tar.gz";
#        sha256 = "l5AuLgB6rqo8bjvtH4F4W4F7dBOUfx2x07YrjaTNEQ4=";
#      };
#    });
#    })];



  
  


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
        configDir = "/home/daniel/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
};



fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "SourceCodePro" "liberation_ttf"]; })
];




}
