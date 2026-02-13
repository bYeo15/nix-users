{ config, lib, pkgs, ... }:

let
    # ---=[ Commands ]=---
    term = "${pkgs.foot}/bin/foot";
    cap = "'grim -g \"''$(slurp -d)\" - | wl-copy -t image/png'";
    copy-history = "cliphist list | rofi -dmenu -font \"${config.renix.activeTheme.fontMono} ${toString config.renix.activeTheme.fontSizeNormal}\" -p \"Select Clipboard Item\" | cliphist decode | wl-copy";
    copy-clear = "cliphist wipe";
    # ---=[ Workspaces ]=---
    ws1 = "1";
    ws2 = "2";
    ws3 = "3";
    ws4 = "4";
    ws5 = "5";
    ws6 = "6";
    ws7 = "7";
    ws8 = "8";
    ws9 = "9";
    wsHome = "0:⌂";
in {
    wayland.windowManager.sway.config = rec {
        modifier = "Mod4";
        terminal = term;
        menu = "${pkgs.rofi}/bin/rofi";

        keybindings = {
            # ---=[ Applications and Launcher ]=---
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+d" = "exec ${menu} -show drun";
            "${modifier}+s" = "exec rofi-quicksearch";
            "${modifier}+Tab" = "exec ${menu} -show window";

            # ---=[ Navigation ]=---
            "${modifier}+h" = "focus left";
            "${modifier}+l" = "focus right";
            "${modifier}+k" = "focus up";
            "${modifier}+j" = "focus down";
            "${modifier}+minus" = "scratchpad show";
            "${modifier}+Shift+h" = "workspace prev";
            "${modifier}+Shift+l" = "workspace next";
            "${modifier}+1" = "workspace ${ws1}";
            "${modifier}+2" = "workspace ${ws2}";
            "${modifier}+3" = "workspace ${ws3}";
            "${modifier}+4" = "workspace ${ws4}";
            "${modifier}+5" = "workspace ${ws5}";
            "${modifier}+6" = "workspace ${ws6}";
            "${modifier}+7" = "workspace ${ws7}";
            "${modifier}+8" = "workspace ${ws8}";
            "${modifier}+9" = "workspace ${ws9}";
            "${modifier}+0" = "workspace ${wsHome}";

            # ---=[ Container Management ]=---
            "${modifier}+Shift+1" = "move container to workspace ${ws1}";
            "${modifier}+Shift+2" = "move container to workspace ${ws2}";
            "${modifier}+Shift+3" = "move container to workspace ${ws3}";
            "${modifier}+Shift+4" = "move container to workspace ${ws4}";
            "${modifier}+Shift+5" = "move container to workspace ${ws5}";
            "${modifier}+Shift+6" = "move container to workspace ${ws6}";
            "${modifier}+Shift+7" = "move container to workspace ${ws7}";
            "${modifier}+Shift+8" = "move container to workspace ${ws8}";
            "${modifier}+Shift+9" = "move container to workspace ${ws9}";
            "${modifier}+Shift+0" = "move container to workspace ${wsHome}";
            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+space" = "focus mode_toggle";
            "${modifier}+f" = "fullscreen";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";
            "${modifier}+Shift+minus" = "move scratchpad";
            "${modifier}+Shift+q" = "kill";

            # ---=[ Modes ]=---
            "${modifier}+m" = "mode \"move\"";
            "${modifier}+r" = "mode \"resize\"";

            # ---=[ Audio/Media ]=---
            "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
            "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%-";
            "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%+";
            "--locked XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_SOURCE@ toggle";

            "${modifier}+slash" = "exec playerctl play-pause";
            "${modifier}+period" = "exec playerctl next";
            "${modifier}+comma" = "exec playerctl previous";

            # ---=[ Misc ]=---
            "--locked XF86MonBrightnessDown" = "exec light -U 5";
            "--locked XF86MonBrightnessUp" = "exec light -A 5";

            "Print" = "exec ${cap}";
            "${modifier}+Shift+v" = "exec ${copy-history}";
            "${modifier}+Shift+b" = "exec ${copy-clear}";
            "${modifier}+z" = "exec ${pkgs.swaylock}/bin/swaylock";
            "${modifier}+Shift+c" = "reload";
        };

        modes = {
            move = {
                Left = "move left";
                Right = "move right";
                Up = "move up";
                Down = "move down";
                "${modifier}+h" = "move left";
                "${modifier}+l" = "move right";
                "${modifier}+k" = "move up";
                "${modifier}+j" = "move down";
                a = "focus parent";
                s = "focus child";
                v = "split v";
                h = "split h";
                n = "split n";
                Return = "mode \"default\"";
                Escape = "mode \"default\"";
            };
            resize = {
                Left = "resize shrink width 10px";
                Right = "resize grow width 10px";
                Up = "resize grow height 10px";
                Down = "resize shrink height 10px";
                "${modifier}+h" = "resize shrink width 10px";
                "${modifier}+l" = "resize grow width 10px";
                "${modifier}+k" = "resize grow height 10px";
                "${modifier}+j" = "resize shrink height 10px";
                Return = "mode \"default\"";
                Escape = "mode \"default\"";
            };
        };
    };
}
