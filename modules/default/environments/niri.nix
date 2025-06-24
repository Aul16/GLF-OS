{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.glf.environment.enable && config.glf.environment.type == "niri") {
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Activation de Niri
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    services = {
      displayManager = {
        defaultSession = "niri";
        sddm = {
          enable = true;
          theme = "breeze";
        };
      };
      desktopManager.plasma6.enable = true;
    };
    hardware.bluetooth.enable = true;

    # Workaround for intel according to https://nixos.wiki/wiki/Intel_Graphics and https://github.com/YaLTeR/niri/wiki/Getting-Started
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt          # for newer GPUs on NixOS >24.05 or unstable
      ];
    };

    programs.niri.enable = true;
    documentation.nixos.enable = false;
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Packages système
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    environment = {
      systemPackages = with pkgs; [
        # Packages Niri
        alacritty
        swaylock
        fuzzel
	      xwayland-satellite
        waybar
        mako
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        gnome-keyring
        
        # Configuration SDDM
        (writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
          [General]
          background=/etc/wallpapers/glf/white.jpg
        '')
      ];
    };
  };
}
