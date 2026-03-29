{ config, lib, pkgs, ... }:

{
    imports = [
        ./bash.nix
        ./browserData.nix
        ./cmus.nix
        ./firefox.nix
        ./fonts.nix
        ./foot.nix
        ./helix.nix
        ./homepkg.nix
        ./qutebrowser.nix
        ./scripts.nix
        ./ssh.nix
    ];
}
