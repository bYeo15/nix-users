{ config, lib, pkgs, ... }:

{
    gtk = {
        enable = true;

        colorScheme = "dark";

        theme = {
            name = "Adwaita";
            package = pkgs.gnome-themes-extra;
        };
        iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
        };

        gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;

        gtk4.theme = config.gtk.theme;
    };
}
