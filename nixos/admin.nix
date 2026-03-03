groups: { config, lib, pkgs, ... }:

{
    users.users."admin" = {
        isNormalUser = true;

        extraGroups = [
            "wheel"
            "networkmanager"
            "podman"
        ] ++ groups;

        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJG3Gqer9XNCl6Gn2slRX8pS70g/hVIgLl4HSRuZBI5d"
        ];

        shell = pkgs.bash;
    };
}
