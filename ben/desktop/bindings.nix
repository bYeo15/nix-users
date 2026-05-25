{ config, lib, pkgs, ... }:

let
    term = lib.getExe pkgs.foot;
    menu = lib.getExe pkgs.rofi;
    modifier = "Super_L";
    cap = "'grim -g \"$(slurp -d)\" - | wl-copy -t image/png'";
    copy-history = "cliphist list | rofi -dmenu -p \"Select Clipboard Item\" -no-tokenize | cliphist decode | wl-copy";

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

    toplevelMode = "+";

    makeChain = name: binds: { name = "${name}"; chain = true; } // binds;
    makeTransition = name: binds: next: { inherit name; inherit next; } // binds;

    /*
        bindSet -> sway Home-Manager format bindings
        a bindSet looks like:

        {
            commonEscape [str]:
                the key that returns to the toplevel mode

            <key> -> command [str] | mode [attrs]:
                toplevel binding (active in the initial mode)
                either executes a command (from a string) or moves to the
                given mode, which should be structured like;
                    {
                        name [str]:
                            the name of the mode

                        chain [bool] optional:
                            if present and true, don't leave this mode after executing a command

                        next [str] optional:
                            mutually exclusive with chain (one must be set)
                            if present, switch to the mode w/ this name after executing a command

                        <key> -> command [str] | mode [attrs]:
                            as above, recursive
                    }
        }
    */
    makeBinds = bindSet: let
        bindSetNoEscape = lib.removeAttrs bindSet [ "commonEscape" ];
        makeMode = mode: let
            # All keybinds
            modeBinds = lib.removeAttrs mode [ "name" "chain" "next" ];
            # Keybinds that lead to other modes
            modeTransitions = lib.filterAttrs (n: v: lib.isAttrs v) modeBinds;
            # Keybinds within the given mode
            modeActions = lib.filterAttrs (n: v: lib.isString v) modeBinds;

            mkAction = if mode ? next
                then
                    # next - transition to some other mode
                    (command: "${command}; mode ${mode.next}")
                else
                    # chain - don't exit
                    (command: command);
        in assert (lib.assertMsg
            (
                (mode ? "chain" && mode.chain && (! mode ? "next")) ||
                (!(mode ? "chain" && mode.chain) && mode ? "next")
            )
            "Mode '${mode.name}' must set exactly one of chain or next"
        ); {
            # build the current mode
            "${mode.name}" = (lib.mapAttrs (n: v: mkAction v) modeActions) //
                             (lib.mapAttrs (n: v: "mode \"${v.name}\"") modeTransitions) //
                             {
                                "${bindSet.commonEscape}" = "mode \"default\"";
                             };
        } // (
            lib.mergeAttrsList (lib.map makeMode (lib.attrValues modeTransitions))
        );
    in {
        keybindings = {
            # switch to reserved toplevel mode
            "${modifier}" = "mode \"${toplevelMode}\"";
        };

        modes = makeMode ({ name = "${toplevelMode}"; next = "default"; } // bindSetNoEscape);
    };

    binds = let
        moveBinds = {
            h = "move left 30 px";
            "Shift+h" = "move left 60 px";
            l = "move right 30 px";
            "Shift+l" = "move right 60 px";
            k = "move up 30 px";
            "Shift+k" = "move up 60 px";
            j = "move down 30 px";
            "Shift+j" = "move down 60 px";

            "1" = "move container to workspace ${ws1}";
            "2" = "move container to workspace ${ws2}";
            "3" = "move container to workspace ${ws3}";
            "4" = "move container to workspace ${ws4}";
            "5" = "move container to workspace ${ws5}";
            "6" = "move container to workspace ${ws6}";
            "7" = "move container to workspace ${ws7}";
            "8" = "move container to workspace ${ws8}";
            "9" = "move container to workspace ${ws9}";
            "0" = "move container to workspace ${wsHome}";

            "minus" = "move scratchpad";

            "Space" = "floating toggle";
        };

        resizeBinds = {
            c = "resize set width 50 ppt";
            "Shift+c" = "resize set width 33 ppt";
            v = "resize set height 50 ppt";
            "Shift+v" = "resize set width 33 ppt";

            h = "resize shrink width 30 px";
            "Shift+h" = "resize shrink width 60 px";
            k = "resize grow height 30 px";
            "Shift+k" = "resize grow height 60 px";
            j = "resize shrink width 30 px";
            "Shift+j" = "resize shrink width 60 px";
            l = "resize grow width 30 px";
            "Shift+l" = "resize grow width 60 px";
        };
    in {
        commonEscape = "Escape";

        "Return" = "exec ${term}";
        d = "exec ${menu} -show drun";
        s = "exec quicksearch";
        a = "exec ${copy-history}";
        "Tab" = "exec ${menu} -show window";

        h = "focus left";
        "Shift+h" = "workspace prev";
        l = "focus right";
        "Shift+l" = "workspace next";
        k = "focus up";
        "Shift+k" = "focus parent";
        j = "focus down";
        "Shift+j" = "focus child";

        "Space" = "focus mode_toggle";

        "1" = "workspace ${ws1}";
        "2" = "workspace ${ws2}";
        "3" = "workspace ${ws3}";
        "4" = "workspace ${ws4}";
        "5" = "workspace ${ws5}";
        "6" = "workspace ${ws6}";
        "7" = "workspace ${ws7}";
        "8" = "workspace ${ws8}";
        "9" = "workspace ${ws9}";
        "0" = "workspace ${wsHome}";

        "minus" = "scratchpad show";

        f = "fullscreen toggle";
        e = "layout toggle split";
        w = "layout tabbed";
        v = "split vertical";
        c = "split horizontal";
        x = "split none";

        z = "exec ${lib.getExe pkgs.swaylock}";

        "Shift+q" = "kill";

        "slash" = "exec playerctl play-pause";
        "period" = "exec playerctl next";
        "comma" = "exec playerctl previous";

        m = makeTransition "m" moveBinds "default";
        "Shift+m" = makeChain "M" moveBinds;

        r = makeTransition "r" resizeBinds "default";
        "Shift+r" = makeChain "R" resizeBinds;
    };

    bindsRealised = makeBinds binds;
in {
    wayland.windowManager.sway.config = {
        terminal = term;

        # default-level binds include function keys
        keybindings = {
            "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
            "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%-";
            "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%+";
            "--locked XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_SOURCE@ toggle";

            "--locked XF86MonBrightnessDown" = "exec brightnessctl s 5%-";
            "--locked XF86MonBrightnessUp" = "exec brightnessctl s +5%";

            "Print" = "exec ${cap}";
        } // bindsRealised.keybindings;

        inherit (bindsRealised) modes;
    };
}
