{ config, lib, pkgs, ... }:

{
    programs.foot = with config.renix.activeTheme; {
        enable = true;
        settings = {
            main = {
                font = "${fontMono}:size=${toString fontSizeNormal}";
            };
            colors = {
                foreground = colour.mainFg;
                background = colour.mainBg;
                cursor = "${colour.accentFg} ${colour.accentBg}";
                "${termColour.mainBg}" = colour.mainBg;
                "${termColour.accentBg}" = colour.accentBg;
                "${termColour.mainFg}" = colour.mainFg;
                "${termColour.accentFg}" = colour.accentFg;
            };
            key-bindings = {
                search-start = "Control+slash";
            };
        };
    };
}
