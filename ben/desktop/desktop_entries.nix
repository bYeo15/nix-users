{ config, lib, pkgs, ... }:

{
    xdg.desktopEntries = {
        firefox-priv = {
            name = "Firefox [Private]";
            genericName = "Web Browser";
            exec = "firefox --private-window";
            terminal = false;
        };

        cmus = {
            name = "cmus";
            genericName = "Music Player";
            exec = "foot --app-id=cmus cmus";
            terminal = false;
        };
    };
}
