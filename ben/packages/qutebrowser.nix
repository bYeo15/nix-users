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
in {
    programs.qutebrowser = {
        enable = true;

        settings = {
            # TODO : Complete settings
            content = {
                autoplay = false;

                cookies = {
                    accept = "never";
                    store = false;
                };

                desktop_capture = false;
                geolocation = false;

                javascript = {
                    enabled = false;
                    can_close_tabs = false;
                    can_open_tabs_automatically = false;
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
                default_page = "about:blank";
                start_pages = "about:blank";
            };
        };

        perDomainSettings = {
            "bandcamp.com" = {
                content.javascript.enabled = true;
                content.cookies = {
                    accept = "no-3rdparty";
                };
            };

            "*.bandcamp.com" = {
                content.javascript.enabled = true;
                content.cookies = {
                    accept = "no-3rdparty";
                };
            };

            "home-manager-options.extranix.com" = {
                content.javascript.enabled = true;
            };

            "noogle.dev" = {
                content.javascript.enabled = true;
            };

            "search.nixos.org" = {
                content.javascript.enabled = true;
            };
        };

        searchEngines = makeEngines config.browserData.searchEngines "DuckDuckGo";

        keyBindings = {
            normal = {
                "h" = "tab-prev";
                "l" = "tab-next";

                "H" = "back --quiet";
                "L" = "forward --quiet";

                "k" = "scroll up";
                "j" = "scroll down";

                "K" = "search-prev";
                "J" = "search-next";

                "f" = "hint";
                "F" = "hint all tab-fg";

                "d" = "tab-close";
                "D" = "undo";

                "s" = "open --window";
                "S" = "tab-give --keep";

                "a" = "set-mark A";
                "A" = "jump-mark A";

                "t" = "open --tab";
                "T" = "cmd-set-text :open --tab ";

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
            };
        };
        # TODO : Complete personal binds and disable base
        enableDefaultBindings = true;

        aliases = {
        };

        quickmarks = makeBookmarks config.browserData.bookmarks;
    };
}
