{ config, lib, extlib, pkgs, ... }:

{
    programs.ssh = {
        enable = true;
        settings = (extlib.filterTagged "block" [ "all" "git" "homelab" ] config.sshConn) // {
            "*" = {
                ForwardAgent = false;
                AddKeysToAgent = false;
                Compression = false;
                ServerAliveInterval = 0;
                ServerAliveCountMax = 3;
                HashKnownHosts = false;
                UserKnownHostsFile = "~/.ssh/known_hosts";
                ControlPath = "~/.ssh/master-%r@%n:%p";
                ControlPersist = "no";
            };
        };
    };

    services.ssh-agent = {
        enable = true;
    };
}
