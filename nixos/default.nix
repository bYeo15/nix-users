{
    admin = (import ./admin.nix) [];
    adminWithGroups = import ./admin.nix;
    staging = import ./staging.nix;

    namedMainUser = import ./genMainUser.nix;
    namedNodeUser = (import ./genNodeUser.nix) [];
    namedNodeUserWithGroups = import ./genNodeUser.nix;
}
