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
        };

        perDomainSettings = {
            # TODO : javescript whitelist
        };

        searchEngines = makeEngines config.browserData.searchEngines "DuckDuckGo";

        keyBindings = {
            # TODO
        };
        enableDefaultBindings = true;

        aliases = {
            # TODO
        };

        quickmarks = makeBookmarks config.browserData.bookmarks;
    };
}
