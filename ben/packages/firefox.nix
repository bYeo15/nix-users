{ config, lib, pkgs, extpkgs, ... }:

let
    makeBookmarks = bookmarks: let
        groupedBookmarks = lib.foldlAttrs (acc: n: v:
            lib.attrsets.recursiveUpdate acc (
                lib.setAttrByPath
                    (if ! isNull v.group then [ v.group n ] else [ "__ungrouped" n ])
                    { inherit (v) url keyword tags; }
            )
        ) {} bookmarks;
        foldGroup = group: lib.foldlAttrs (acc: n: v:
            acc ++ [({
                name = n;
            } // v)]
        ) [] group;
    in {
        name = "Toolbar";
        toolbar = true;
        bookmarks = (foldGroup (if groupedBookmarks ? "__ungrouped" then groupedBookmarks.__ungrouped else { }))
        ++ lib.mapAttrsToList (n: v: {
            name = n;
            bookmarks = foldGroup v;
        }) (lib.removeAttrs groupedBookmarks [ "__ungrouped" ]);
    };

    makeEngines = engines: lib.mapAttrs (
        name: engine: {
            urls = [{ template = engine.template "{searchTerms}"; }];
            definedAliases = [ "@${engine.symbol}" ];
        }
    ) engines;

in {
    programs.firefox = {
        enable = true;
        policies = {
            DisableTelemetry = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
        };
        profiles = {
            default = {
                id = 0;
                name = "default";
                isDefault = true;
                settings = {
                    # ===[ Browser ]===
                    # -- Search --
                    "browser.search.defaultenginename" = "DuckDuckGo";
                    "browser.search.suggest.enabled" = false;
                    "browser.search.suggest.enabled.private" = false;
                    # -- Contile --
                    "browser.topsites.contile.enabled" = false;
                    # -- URL Bar --
                    "browser.urlbar.suggest.searches" = false;
                    "browser.urlbar.showSearchSuggestionsFirst" = false;
                    # -- New Tab Page --
                    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                    "browser.newtabpage.activity-stream.feeds.snippets" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
                    "browser.newtabpage.activity-stream.showSponsored" = false;
                    "browser.newtabpage.activity-stream.system.showSponsored" = false;
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                    # -- Download --
                    "browser.download.dir" = "/home/ben/downloads";
                    "browser.download.deletePrivate" = false;
                    # -- No AI --
                    "browser.ml.enable" = false;
                    "browser.ml.chat.enabled" = false;
                    "browser.ml.linkPreview.enabled" = false;
                    "browser.ml.pageAssist.enabled" = false;
                    "browser.ml.smartAssist.enabled" = false;

                    "extensions.ml.enabled" = false;

                    "browser.ai.control.default" = "blocked";
                    "browser.ai.control.linkPreviewKeyPoints" = "blocked";
                    "browser.ai.control.pdfjsAltText" = "blocked";
                    "browser.ai.control.sidebarChatbot" = "blocked";


                    "extensions.pocket.enabled" = false;
                };
                search = {
                    force = true;
                    default = "ddg";
                    privateDefault = "ddg";
                    engines = {
                        # Disable unwanted search engines
                        "google".metaData.hidden = true;
                        "perplexity".metaData.hidden = true;
                        "bing".metaData.hidden = true;
                        "ebay".metaData.hidden = true;
                    } // makeEngines config.browserData.searchEngines;
                };
                bookmarks = {
                    force = true;
                    settings = [
                        (makeBookmarks config.browserData.bookmarks)
                    ];
                };
                extensions = {
                    force = true;
                    packages = with extpkgs.nur.repos.rycee.firefox-addons; [
                        ublock-origin
                    ];
                };
            };
        };
    };
}
