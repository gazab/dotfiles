{ pkgs, ... }:

{
  programs.niri.enable = true;

  # The niri keybinds (home/niri.nix) spawn these exact binaries.
  environment.systemPackages = [
    pkgs.alacritty
    pkgs.fuzzel
    pkgs.swaylock
    pkgs.playerctl
    pkgs.brightnessctl
  ];
}
