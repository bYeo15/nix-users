{ config, lib, pkgs, ... }:

{
    imports = [
        ./desktop
        ./packages
    ];

    home = {
        username = "ben";
        homeDirectory = "/home/ben";
        stateVersion = "22.11";
    };

    programs.home-manager.enable = true;
}
