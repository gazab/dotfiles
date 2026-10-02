{
  description = "gazab's NixOS machines";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      mkHost = { hostname, modules, system ? "x86_64-linux" }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/nixos/common.nix
            { networking.hostName = hostname; }
          ] ++ modules;
        };
    in {
      nixosConfigurations = {
        helios = mkHost {
          hostname = "helios";
          modules = [
            ./hosts/helios
            inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
          ];
        };

        nixos = mkHost {
          hostname = "nixos";
          modules = [
            ./hosts/wsl
            inputs.nixos-wsl.nixosModules.default
          ];
        };
      };
    };
}
