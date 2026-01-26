{ config, lib, pkgs, ... }:

{
    users.users."node" = {
        isNormalUser = true;

        extraGroups = [
        ];

        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAuhigSbK+Ftd99A4OWm8L2bT4wbxbe01zcW9lkxUVYw"
        ];

        shell = pkgs.bash;
    };
}
