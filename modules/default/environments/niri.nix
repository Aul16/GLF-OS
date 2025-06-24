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
    programs.niri.enable = true;
    documentation.nixos.enable = false;
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Packages système
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    environment = {
      systemPackages = with pkgs; [
        # Packages Niri
        
        
        # Configuration SDDM
        (writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
          [General]
          background=/etc/wallpapers/glf/white.jpg
        '')
      ];
    };
  };
}
