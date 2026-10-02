{ pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "gazab";

  environment.systemPackages = [ pkgs.wsl-open ];
  environment.sessionVariables.BROWSER = "wsl-open";

  programs.nix-ld.enable = true;

  # Do not change after install; see `man configuration.nix`.
  system.stateVersion = "25.05";
}
