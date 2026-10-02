{ config, lib, ... }:

{
  options.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Names of unfree packages that may be installed.";
  };

  config = {
    allowedUnfreePackages = [ "claude-code" ];

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) config.allowedUnfreePackages;
  };
}
