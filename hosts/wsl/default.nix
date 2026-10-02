{ ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "gazab";

  programs.nix-ld.enable = true;

  # Do not change after install; see `man configuration.nix`.
  system.stateVersion = "25.05";
}
