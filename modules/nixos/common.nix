{ pkgs, ... }:

{
  imports = [
    ./unfree.nix
    ./home-manager.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Stockholm";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  programs.fish.enable = true;

  users.users.gazab = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "gazab";
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    git
    htop
    curl
    wget
    vim
    kubectl
    kubeswitch
    dnsutils
  ];
}
