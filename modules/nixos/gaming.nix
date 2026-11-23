{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # auto-bumps CPU governor/GPU perf while a game runs instead of forcing
  # performance mode system-wide (worse battery life otherwise).
  programs.gamemode.enable = true;

  # the gamemode package ships this rule under its own store path, but
  # polkit only reads /etc/polkit-1/rules.d — without this link cpugovctl
  # fails "Not authorized" and the governor never actually switches.
  environment.etc."polkit-1/rules.d/46-gamemode.rules".source =
    "${pkgs.gamemode}/share/polkit-1/rules.d/gamemode.rules";

  allowedUnfreePackages = [ "steam" "steam-unwrapped" ];
}
