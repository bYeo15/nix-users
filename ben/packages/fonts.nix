{ config, lib, pkgs, ... }:

{
    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        adwaita-fonts
        font-awesome
        departure-mono
        nerd-fonts.symbols-only

        # ---=[ Misc Fonts ]=---
        julia-mono
        gohufont
    ];

    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            monospace = [ config.renix.activeTheme.fontMono ];
            serif = [ config.renix.activeTheme.fontSerif ];
            sansSerif = [ config.renix.activeTheme.fontSans ];
        };
    };
}
