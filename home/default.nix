{ ... }:

{
  imports = [ ./cli.nix ];

  home.username = "gazab";
  home.homeDirectory = "/home/gazab";

  # Do not change after install; check the Home Manager release notes first.
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
