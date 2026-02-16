username: { config, pkgs, lib, ... }:

{
    users.users."${username}" = {
        isNormalUser = true;

        extraGroups = [
            "wheel"
            "audio"
            "video"
            "realtime"
            "light"
            "networkmanager"
            "powermanagement"
            "docker"
        ];

        shell = pkgs.bash;
    };
}
