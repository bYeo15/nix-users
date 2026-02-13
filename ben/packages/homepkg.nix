{ config, lib, pkgs, extpkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
        playerctl

        # --[ Terminal Utilities ]--
        glow
        libsixel
        slides
        bc

        # --[ LSP ]--
        nil
        bash-language-server
        texlab

        # --[ Authorship ]--
        libreoffice-fresh
        krita
        inkscape
        aseprite

        discord

        adwaita-icon-theme
        adwaita-icon-theme-legacy

        texliveFull

        # --[ Sway Tools ]--
        swayidle
        swaylock
        waybar
        wl-clipboard
        cliphist
        grim
        slurp

        extpkgs.glbg
    ];

    # --[ Programs ]--
    programs = {
        zathura.enable = true;
        freetube.enable = true;

        direnv = {
            enable = true;
            config = {
                global.hide_env_diff = true;
            };
            nix-direnv.enable = true;
        };
    };

    # --[ Services ]--
    services = {
        mpris-proxy.enable = true;
        mako.enable = true;
    };
}
