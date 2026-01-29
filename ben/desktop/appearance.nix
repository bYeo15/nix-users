{ config, lib, pkgs, ... }:

{
    gtk = {
        enable = true;

        theme = {
            name = "Adwaita";
            package = pkgs.gnome-themes-extra;
        };
        iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
        };

        gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    };
}
