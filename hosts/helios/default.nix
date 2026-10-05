{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/gaming.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  users.users.gazab.extraGroups = [ "networkmanager" ];

  allowedUnfreePackages = [ "vscode" ];
  environment.systemPackages = [ pkgs.vscode ];

  # Do not change after install; see `man configuration.nix`.
  system.stateVersion = "26.05";
}
