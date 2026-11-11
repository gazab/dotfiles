{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nixflix.nix
    ./nixflix-dns.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/tailscale.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  networking.networkmanager.enable = true;
  users.users.gazab.extraGroups = [ "networkmanager" ];

  allowedUnfreePackages = [ "vscode" "nvidia-x11" "nvidia-settings" "unrar" ];
  environment.systemPackages = [ pkgs.vscode ];

  # bolt manages Thunderbolt device authorization; without it the eGPU's
  # PCIe link stays unauthorized and never shows up after hotplug.
  services.hardware.bolt.enable = true;
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="thunderbolt", ATTR{authorized}=="0", ATTR{authorized}="1"
  '';

  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # No disk swap is configured; zram gives Steam/games headroom before the
  # OOM killer steps in, since 14G RAM alone gets exhausted by modern games.
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Do not change after install; see `man configuration.nix`.
  system.stateVersion = "26.05";
}
