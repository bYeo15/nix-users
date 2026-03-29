{ config, lib, pkgs, ... }:

{
    extscripts = {
        enable = true;
        scripts = [
            "devsh"
            "hsearch"
            "quicksearch"
            "volctl"
        ];
    };
}
