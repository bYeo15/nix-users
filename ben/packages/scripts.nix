# TODO : port this to a common home module (infer programs)

{ config, lib, pkgs, ... }:

let
    rofi-quicksearch = pkgs.writeShellScriptBin "rofi-quicksearch" ''
        BROWSER=firefox
        ARGS="--private-window --new-window"
        ENGINE="https://noai.duckduckgo.com/?q="

        REGEX_SITE="[^\ ]+\.[^\ ]+"

        SEARCH=''$(echo | rofi -dmenu -p "Search Term:" -theme-str 'window{height:32;}')

        if [[ -z ''$SEARCH ]]; then exit 1; fi

        if [[ ''$SEARCH =~ ''$REGEX_SITE ]]; then
            exec ''${BROWSER} ''${ARGS} "''${SEARCH}"
        else
            exec ''${BROWSER} ''${ARGS} "''${ENGINE}''${SEARCH}"
        fi
    '';

    devshell-manager = pkgs.writeShellScriptBin "devsh" ''
        TARGET_DEVSHELL=${config.devshells.default.template}
        INIT_HOOK='${config.devshells.default.hook}'

        case $1 in
            "help" | "--help")
                echo "Usage: <shell>"
                echo -e "${lib.attrsets.foldlAttrs (acc: n: v: acc + "\n\t${n}") "Available Shells:" config.devshells}"
                exit 0
            ;;
            ${lib.attrsets.foldlAttrs (acc: n: v: acc + "${n})\nTARGET_DEVSHELL=${v.template}\nINIT_HOOK=\'${v.hook}\'\n;;\n") "" config.devshells}
            "")
            ;;
            *)
                echo "[ ERROR ] : ''$1 is not a known devshell"
                exit 1
            ;;
        esac

        cp "''$TARGET_DEVSHELL" ./shell.nix
        chmod u+w ./shell.nix
        npins init
        npins freeze nixpkgs
        eval "$INIT_HOOK"
        echo "use nix" > ./.envrc
    '';

    volume-wrapper = pkgs.writeShellScriptBin "volctl" ''
        if [[ "$1" = "" || "$1" = "help" || "$1" = "--help" ]]; then
            echo "Usage: (<target> [<vol %>]) | list"
            echo "<target> : the process to target (no case)"
            echo "           special targets OUT and IN target current audio output/input"
            echo "<vol %> : the volume to assign to the target"
            echo "          if not provided, toggles mute/unmute"
            echo "list : list available targets"
            exit 0
        fi

        if [[ "''$1" = "list" ]]; then
            wpctl status | \
                awk '/Streams/ { flag=1; next } /Video/ { flag = 0; exit } flag' | \
                grep -e "\[active\]" -e "\[paused\]" -B 1 | grep -v -e "\[active\]" -e "\[paused\]" | \
                sed 's/.*[0-9]*\. //'
            exit 0
        elif [[ "''$1" = "OUT" ]]; then
            TARGET="@DEFAULT_SINK@"
        elif [[ "''$1" = "IN" ]]; then
            TARGET="@DEFAULT_SOURCE@"
        else
            TARGET="''$(wpctl status | \
                awk '/Streams/ { flag=1; next } /Video/ { flag = 0; exit } flag' | \
                grep -e "\[active\]" -e "\[paused\]" -B 1 | grep -v -e "\[active\]" -e "\[paused\]" | \
                grep -i "''$1" | grep -o "[0-9]*")"
            if [[ "''$?" -ne 0 ]]; then
                echo "Could not find target ''$1"
                exit 1
            fi
        fi

        if [[ "''$2" = "" ]]; then
            wpctl set-mute "''${TARGET}" toggle
        else
            if [ "''$2" -eq "''$2" ] 2>/dev/null; then
                wpctl set-volume "''${TARGET}" "''$2%"
            else
                echo "Volume (''$2) is not a number"
                exit 1
            fi
        fi
    '';

    hsearch = pkgs.writeShellScriptBin "hsearch" ''
        # TODO : Infer from config
        HISTORY_FILE="''$HOME/.bash_history"

        HIST="''$(cat "''$HISTORY_FILE")"

        if [[ ''$# -ge 1 ]]; then
            HIST="''$(grep ''$@ <<< "''$HIST")"
        fi

        rofi -dmenu -no-tokenize -p "Select History Entry:" <<< "''$HIST" | wl-copy
    '';
in {
    home.packages = [
        rofi-quicksearch
        hsearch
        devshell-manager
        volume-wrapper
    ];
}
