{ ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  allowedUnfreePackages = [ "steam" "steam-unwrapped" ];
}
