{ config, lib, pkgs, ... }:

{
    programs.helix = {
        enable = true;
        defaultEditor = true;

        settings = {
            theme = "active";
            editor = {
                default-yank-register = "+";
                shell = [ "bash" "-c" ];
                line-number = "relative";
                cursorline = true;
                continue-comments = true;
                auto-completion = false;
                path-completion = true;
                auto-pairs = false;
                auto-format = false;
                bufferline = "multiple";
                trim-trailing-whitespace = true;
                popup-border = "all";
                clipboard-provider = "wayland";

                statusline = {
                    left = [
                        "mode"
                        "spinner"
                        "read-only-indicator"
                        "file-modification-indicator"
                    ];

                    center = [
                        "file-name"
                    ];

                    right = [
                        "position-percentage"
                        "spacer"
                        "position"
                        "spacer"
                        "total-line-numbers"
                    ];

                    mode.normal = "(N)";
                    mode.insert = "[I]";
                    mode.select = "<S>";
                };

                lsp = {
                    enable = true;
                    display-messages = true;
                };

                cursor-shape = {
                    normal = "block";
                    insert = "bar";
                    select = "underline";
                };

                soft-wrap = {
                    enable = true;
                    max-wrap = 25;
                };

                smart-tab = {
                    enable = false;
                };
            };

            keys = {
                normal = {
                    left = "no_op";
                    down = "no_op";
                    right = "no_op";
                    up = "no_op";

                    d = "delete_selection_noyank";
                    c = "change_selection_noyank";
                    m = "match_brackets";

                    # <X : capital> : "larger" version of <x>
                    X = "copy_selection_on_next_line";
                    L = "move_next_word_start";
                    H = "move_prev_word_start";
                    K = "page_up";
                    J = "page_down";
                    D = "delete_selection";
                    C = "change_selection";
                    V = [ "extend_to_line_bounds" "select_mode" ];


                    # Tab : lsp
                    tab = {
                        d = "goto_definition";
                        s = "goto_reference";
                        r = "rename_symbol";
                        e = "goto_implementation";
                        f = "hover";
                        w = "symbol_picker";
                    };

                    # g : global/long navigation
                    g = {
                        h = "goto_line_start";
                        k = "goto_file_start";
                        j = "goto_file_end";
                        l = "goto_line_end";
                    };

                    # b : buffer/window control
                    b = {
                        n = "goto_next_buffer";
                        m = "goto_previous_buffer";

                        h = "jump_view_left";
                        j = "jump_view_down";
                        k = "jump_view_up";
                        l = "jump_view_right";

                        v = "vsplit";
                        V = [ "vsplit" "file_explorer_in_current_directory" ];
                        x = "hsplit";
                        X = [ "hsplit" "file_explorer_in_current_directory" ];
                        c = "wclose";
                        C = ":buffer-close";
                        space = "file_explorer_in_current_directory";
                    };
                };

                insert = {
                    C-backspace = "delete_word_backward";
                    C-del = "delete_word_forward";
                    C-left = "move_prev_word_start";
                    C-right = "move_next_word_start";
                    C-tab = "completion";
                };

                select = {
                    v = [ "extend_to_line_bounds" "normal_mode" ];
                    d = "delete_selection_noyank";
                    c = "change_selection_noyank";
                    D = "delete_selection";
                    C = "change_selection";
                };
            };
        };

        languages = {
            language-server.texlab = {
                config = {
                    texlab.build = {
                        onSave = true;
                        forwardSearchAfter = true;
                        auxDirectory = "latex_build";
                        logDirectory = "latex_build";
                        pdfDirectory = "latex_build";
                        executable = "${pkgs.texliveFull}/bin/latexmk";
                        args = [
                            "--pdf" "%f"
                            "--verbose" "--file-line-error"
                            "--auxdir=latex_build" "--emulate-aux-dir"
                            "--outdir=latex_build"
                            "--synctex=1" "--interaction=nonstopmode"
                        ];
                    };

                    texlab.forwardSearch = {
                        executable = "${pkgs.zathura}/bin/zathura";
                        args = [ "--synctex-forward" "%l:%c:%f" "%p" ];
                    };

                    texlab.chktex = {
                        onOpenAndSave = true;
                        onEdit = true;
                    };
                };
            };

            language = [
                {
                    name = "c";
                    file-types = [ "c" "h" ];
                    indent.tab-width = 4;
                    indent.unit = "    ";
                }

                {
                    name = "markdown";
                    file-types = [ "md" ];
                    indent.tab-width = 4;
                    indent.unit = "    ";
                }

                {
                    name = "nix";
                    file-types = [ "nix" ];
                    indent.tab-width = 4;
                    indent.unit = "    ";
                }
            ];
        };
    };
}
