{ config, lib, pkgs, ... }:

{
    imports = [
       ./appearance.nix
       ./bar.nix
       ./bindings.nix
       ./desktop_entries.nix
       ./lock.nix
       ./rofi.nix
       ./sway.nix
       ./theme.nix
    ];
}
