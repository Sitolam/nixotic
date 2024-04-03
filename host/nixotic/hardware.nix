{ inputs
, ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-15-9570-nvidia
    ../common/hardware/bluetooth.nix
  ];


  nixpkgs.hostPlatform = "x86_64-linux";

  # TODO: Replace with Disko config
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos_root";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
    };
  };
  
  swapDevices =
  [ { device = "/dev/disk/by-label/nixos_swap"; }
  ];
}
