{ config, lib, pkgs, ... }:

{
    users.users."staging" = {
        isNormalUser = true;

        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFeAU1OroNsVqlIO2G0GxK2nKl01i3j6ah5yUbjiJDH1"
        ];

        shell = lib.getExe' pkgs.git "git-shell";
    };
}
