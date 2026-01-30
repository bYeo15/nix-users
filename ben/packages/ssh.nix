{ config, lib, extlib, pkgs, ... }:

{
    programs.ssh = {
        enable = true;
        matchBlocks = extlib.filterTagged "block" [ "all" "git" "homelab" ] config.sshConn;
    };
}
