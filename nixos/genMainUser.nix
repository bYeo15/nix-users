username: { config, pkgs, lib, ... }:

{
    users.users."${username}" = {
        isNormalUser = true;

        extraGroups = [
            "wheel"
            "audio"
            "video"
            "light"
            "networkmanager"
            "powermanagement"
            "docker"
        ];

        shell = pkgs.bash;
    };
}
