{ config, lib, pkgs, ... }:

let
    skipFontDir = font: font.overrideAttrs (finalAttrs: prevAttrs: {
        installPhase = lib.strings.replaceString "mkfontdir" "true" prevAttrs.installPhase;
    });
in {
    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        adwaita-fonts
        font-awesome
        nerd-fonts.symbols-only

        # For themes
        (skipFontDir gohufont)
        (skipFontDir tamzen)
        departure-mono
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
