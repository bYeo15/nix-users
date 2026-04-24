{ config, lib, pkgs, ... }:

let
    makeBookmarks = bookmarks: lib.mapAttrs' (
        name: bookmark: (lib.nameValuePair
            (if isNull bookmark.keyword then name else bookmark.keyword)
            bookmark.url
        )
    ) bookmarks;

    makeEngines = engines: default: (lib.mapAttrs' (
        name: engine: (lib.nameValuePair
            engine.symbol
            (engine.template "{}")
        )
    ) engines) // {
        "DEFAULT" = engines."${default}".template "{}";
    };

    makeBlocklist = contents: pkgs.writeTextFile {
        name = "qutebrowserBlocklist";
        text = contents;
    };

    blocklistURI = blocklist: "file://${blocklist}";

    bandcampNoCookies = makeBlocklist ''
        bandcamp.com##+js(trusted-set-cookie, cookie_preferences, '{"allow":[]}')
    '';
in {
    programs.qutebrowser = {
        enable = true;

        settings = {
            content = {
                autoplay = false;

                blocking = {
                    adblock.lists = [
                        "https://easylist.to/easylist/easylist.txt"
                        "https://easylist.to/easylist/easyprivacy.txt"
                        "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
                        (blocklistURI bandcampNoCookies)
                    ];
                };

                cookies = {
                    store = false;
                };

                javascript = {
                    enabled = true;
                    can_close_tabs = false;
                    can_open_tabs_automatically = false;
                    clipboard = "none";
                };

                pdfjs = true;

                private_browsing = true;
            };

            # Webpage darkmode hint, application colours are handled thru renix
            colors.webpage.preferred_color_scheme = "dark";

            downloads = {
                location = {
                    directory = "~/downloads";
                    prompt = false;
                };
            };

            editor.command = [ "hx" "{file}:{line}:{column}" ];

            tabs = {
                last_close = "close";
            };

            url = {
                default_page = lib.mkDefault "about:blank";
                start_pages = lib.mkDefault "about:blank";
            };
        };

        searchEngines = makeEngines config.browserData.searchEngines "DuckDuckGo";

        keyBindings = {
            normal = let
                # Map base key + a set of subkeys to common command
                makeCommandSet = base: sub: template: lib.genAttrs' sub (k: lib.nameValuePair (base + k) (template k));
                markSet = [ "h" "j" "k" "l" "s" "d" "f" ];
            in {
                "h" = "tab-prev";
                "l" = "tab-next";

                "H" = "back --quiet";
                "L" = "forward --quiet";

                "k" = "scroll up";
                "j" = "scroll down";

                "K" = "search-prev";
                "J" = "search-next";

                "gk" = "scroll-to-perc 0";
                "gj" = "scroll-to-perc 100";

                "f" = "hint";
                "F" = "hint all tab-fg";

                "b" = "hint all tab-bg";
                "B" = "hint all tab-bg --rapid";

                "d" = "tab-close";
                "D" = "undo";

                "s" = "cmd-set-text --space :open --window";
                "S" = "tab-give --keep";

                "t" = "cmd-set-text --space :open --tab";
                "T" = "cmd-set-text --space :open --bg";

                "1" = "tab-focus 1";
                "2" = "tab-focus 2";
                "3" = "tab-focus 3";
                "4" = "tab-focus 4";
                "5" = "tab-focus 5";
                "6" = "tab-focus 6";
                "7" = "tab-focus 7";
                "8" = "tab-focus 8";
                "9" = "tab-focus 9";

                "/" = "cmd-set-text /";
                ":" = "cmd-set-text :";

                "<Escape>" = "clear-keychain ;; search";
            } // (makeCommandSet "A" markSet (k: "set-mark ${k}"))
              // (makeCommandSet "a" markSet (k: "jump-mark ${k}"));
            # a sets a mark, A jumps to a mark
        };
        # TODO : Complete personal binds and disable base
        enableDefaultBindings = true;

        aliases = {
        };

        quickmarks = makeBookmarks config.browserData.bookmarks;
    };
}
