{ hostname
, pkgs
, lib
, username
, ...
}: {
  networking = {
    networkmanager = {
      enable = true;
    };
    hostName = hostname;
    useDHCP = lib.mkDefault true;

  };

  # Workaround https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
