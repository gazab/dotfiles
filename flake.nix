{
  description = "Base flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, nixos-wsl, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        helios = lib.nixosSystem {
          inherit system;
          modules = [ 
                ./configuration.nix 
		
		# Framework fixes
                nixos-hardware.nixosModules.framework-amd-ai-300-series

		# make home-manager as a module of nixos
          	# so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          	home-manager.nixosModules.home-manager
          	{
            	  home-manager.useGlobalPkgs = true;
            	  home-manager.useUserPackages = true;
                  home-manager.users.gazab = import ./home.nix;
          	}
	 ];
	};

	nixos = lib.nixosSystem {
          inherit system;
          modules = [
                nixos-wsl.nixosModules.default
	        {
	          system.stateVersion = "25.05";
            	  wsl.enable = true;
		  wsl.defaultUser = "gazab";
          	}

                # make home-manager as a module of nixos
                # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.gazab = import ./home.nix;
                }
         ];
      };
      homeConfigurations = {
        gazab = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
  };
}
