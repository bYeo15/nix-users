{
    admin = import ./admin.nix;
    staging = import ./staging.nix;

    namedMainUser = import ./genMainUser.nix;
    namedNodeUser = import ./genNodeUser.nix;
}
