{ config, lib, pkgs, ... }:

{
    config.browserData = {
        searchEngines = {
            "DuckDuckGo" = {
                template = searchToken: "https://noai.duckduckgo.com/?q=${searchToken}";
                symbol = "ddg";
                tags = [ "primary" ];
            };

            "Nixpkgs" = {
                template = searchToken: "https://search.nixos.org/packages/?channel=unstable&query=${searchToken}";
                symbol = "np";
                tags = [ "nix" ];
            };

            "Nixopts" = {
                template = searchToken: "https://search.nixos.org/options/?channel=unstable&query=${searchToken}";
                symbol = "no";
                tags = [ "nix" ];
            };

            "HomeManagerOpts" = {
                template = searchToken: "https://home-manager-options.extranix.com/?query=${searchToken}&release=master";
                symbol = "hm";
                tags = [ "nix" ];
            };

            "NixWiki" = {
                template = searchToken: "https://wiki.nixos.org/w/index.php?search=${searchToken}";
                symbol = "nw";
                tags = [ "nix" ];
            };

            "Noogle" = {
                template = searchToken: "https://noogle.dev/q?term=${searchToken}";
                symbol = "ng";
                tags = [ "nix" ];
            };

            "Subreddit" = {
                template = searchToken: "https://reddit.com/r/${searchToken}/hot";
                symbol = "rd";
                tags = [ "social" ];
            };
        };

        bookmarks = {
            "Gmail" = {
                url = "https://mail.google.com/";
                keyword = "gmail";
                tags = [ "mail" ];
                group = "Google";
            };

            "Drive" = {
                url = "https://drive.google.com/drive/my-drive";
                keyword = "gdrive";
                tags = [ "files" ];
                group = "Google";
            };

            "USYD Portal" = {
                url = "https://sydneystudent.sydney.edu.au/";
                tags = [ "usyd" ];
                group = "USYD";
            };

            "Canvas" = {
                url = "https://canvas.sydney.edu.au/";
                keyword = "canvas";
                tags = [ "usyd" ];
                group = "USYD";
            };

            "EdStem" = {
                url = "https://edstem.org/au/dashboard";
                keyword = "edstem";
                tags = [ "usyd" ];
                group = "USYD";
            };

            "USYD Timetable" = {
                url = "https://timetable.sydney.edu.au/even/student";
                tags = [ "usyd" ];
                group = "USYD";
            };

            "USYD GitHub" = {
                url = "https://github.sydney.edu.au/";
                tags = [ "usyd" ];
                group = "USYD";
            };

            "UTS Apps" = {
                url = "https://login.uts.edu.au/app/UserHome";
                keyword = "uts";
                tags = [ "uts" ];
                group = "UTS";
            };

            "Outlook" = {
                url = "https://outlook.office.com/mail/";
                tags = [ "usyd" "uts" "mail" ];
                keyword = "outlook";
            };

            "Wolfram" = {
                url = "https://www.wolframalpha.com/";
                tags = [ "util" ];
                keyword = "wolfram";
            };

            "Fistful of Vinyl" = {
                url = "https://spinitron.com/KXLU/show/190219/A-Fistful-of-Vinyl";
                tags = [ "music" ];
                keyword = "fistful";
            };

            "Bandcamp" = {
                url = "https://bandcamp.com/";
                tags = [ "music" ];
                keyword = "bandcamp";
            };

            "GitHub" = {
                url = "https://github.com/";
                tags = [ "tech" ];
                keyword = "git";
            };

            "lobste.rs" = {
                url = "https://lobste.rs";
                tags = [ "tech" "news" ];
                keyword = "lobsters";
            };
        };
    };
}
