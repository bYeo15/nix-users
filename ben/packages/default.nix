{ config, lib, pkgs, ... }:

{
    imports = [
        ./bash.nix
        ./cmus.nix
        ./firefox.nix
        ./fonts.nix
        ./foot.nix
        ./helix.nix
        ./homepkg.nix
        ./scripts.nix
        ./ssh.nix
    ];
}
