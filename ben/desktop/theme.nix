{ config, lib, pkgs, ... }:

{
    config.renix = {
        enable = true;
        activeTheme = config.renix.themes."singularity";
    };
}
