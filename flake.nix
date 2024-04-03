{
  description = "sitolam's nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "unstable";

    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "unstable";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "unstable";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    crafts.url = "github:jnsgruk/crafts-flake"; # url = "path:/home/jon/crafts-flake";
    crafts.inputs.unstable.follows = "unstable";
    libations.url = "github:jnsgruk/libations";
    libations.inputs.nixpkgs.follows = "unstable";
  };

  outputs =
    { self
    , nixpkgs
    , unstable
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      stateVersion = "23.11";
      username = "sitolam";

      libx = import ./lib { inherit self inputs outputs stateVersion username; };
    in
    {
      # nix build .#homeConfigurations."jon@freyja".activationPackage
      homeConfigurations = {
        # Desktop machines
        "${username}@nixotic" = libx.mkHome { hostname = "nixotic"; desktop = "hyprland"; };
        # Headless machines
      };

      # nix build .#nixosConfigurations.freyja.config.system.build.toplevel
      nixosConfigurations = {
        # Desktop machines
        nixotic = libx.mkHost { hostname = "nixotic"; desktop = "hyprland"; };
        # Headless machines
      };

      # Custom packages; acessible via 'nix build', 'nix shell', etc
      packages = libx.forAllSystems (system:
        let pkgs = unstable.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      # Custom overlays
      overlays = import ./overlays { inherit inputs; };

      # Devshell for bootstrapping
      # Accessible via 'nix develop' or 'nix-shell' (legacy)
      devShells = libx.forAllSystems (system:
        let pkgs = unstable.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      formatter = libx.forAllSystems (system: self.packages.${system}.nixfmt);
    };
}
