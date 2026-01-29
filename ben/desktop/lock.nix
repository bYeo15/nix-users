{ config, lib, pkgs, ... }:

{
    programs.swaylock = {
        enable = true;

        settings = {
            ignore-empty-password = true;
            daemonize = true;
            indicator-idle-visible = false;
        };
    };
}
