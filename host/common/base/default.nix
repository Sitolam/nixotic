{ hostname
, hostid
, pkgs
, lib
, ...
}: {
  imports = [
    ./locale.nix

    ../hardware/yubikey.nix

    ../services/fwupd.nix
    ../services/networkmanager.nix
    ../services/openssh.nix
    ../services/swapfile.nix
    ../services/tailscale.nix
  ];

  networking = {
    hostName = hostname;
    hostId = hostid;
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    bat
    binutils
    ctop
    curl
    dive
    duf
    exa
    git
    htop
    jq
    killall
    pciutils
    ripgrep
    rsync
    tree
    unzip
    usbutils
    wget
    yq-go
  ];

  programs = {
    zsh.enable = true;
    _1password.enable = true;
  };

  services.chrony.enable = true;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}