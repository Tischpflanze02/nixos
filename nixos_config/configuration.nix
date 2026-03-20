# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./poweroptimizaion.nix
       # <home-manager/modules/services/lieer.nix> 
    ];

  #nix.settings.experimental-features = ["nix-command" "flakes"];


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      # Shows battery charge of connected devices on supported
      # Bluetooth adapters. Defaults to 'false'.
      Experimental = true;
      # When enabled other devices can connect faster to us, however
      # the tradeoff is increased power consumption. Defaults to
      # 'false'.
      FastConnectable = true;
    };
    Policy = {
      # Enable all controllers when they are found. This includes
      # adapters present on start as well as adapters that are plugged
      # in later on. Defaults to 'true'.
      AutoEnable = true;
    };

  };
};


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
   networking.networkmanager.enable = true;

  # Enable network manager applet
  # programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the LXQT Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.lxqt.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

services = {
  desktopManager.plasma6.enable = true;
  displayManager.sddm.enable = true;
  displayManager.sddm.wayland.enable = true;
};



  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.niklas = {
    isNormalUser = true;
    description = "niklas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
	kdePackages.wallpaper-engine-plugin
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.dolphin
      kdePackages.kate
      ntfs3g
      pkgs.cifs-utils   # disk support
      vesktop
      vscode
      fastfetch
      kitty
      git
      obsidian
      jdk
      texliveFull
      localsend
      wofi
      kitty
      #Libreoffice
      libreoffice-qt
      hunspell
      hunspellDicts.uk_UA
      hunspellDicts.th_TH
      hunspellDicts.de_DE
      ######
      xournalpp      
      powertop
      vlc
      kdePackages.kcalc # Calculator
      kdePackages.kcharselect # Character map
      kdePackages.kclock # Clock app
      kdePackages.ksystemlog # System log viewer
      kdePackages.sddm-kcm # SDDM configuration module
      kdiff3 # File/directory comparison tool
  
      # Hardware/System Utilities (Optional)
      kdePackages.isoimagewriter # Write hybrid ISOs to USB
      hardinfo2 # System benchmarks and hardware info
      wayland-utils # Wayland diagnostic tools
      wl-clipboard # Wayland copy/paste support
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      # pkgs.tor-browser
      # amiberry
  ];

programs.steam = {
  enable = true;
 # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
 # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
 # localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

#services.tor = {
#  enable = true;
#  openFirewall = true;
#  relay = {
#    enable = true;
#    role = "relay";
#  };
#  settings = {
#    ContactInfo = "toradmin@example.org";
#    Nickname = "toradmin";
#    ORPort = 9001;
#    ControlPort = 9051;
#    BandWidthRate = "1 MBytes";
#  };
#};


  services.fprintd.enable = true;



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
