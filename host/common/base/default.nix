{ hostname
, pkgs
, lib
, username
, ...
}: {
  imports = [
    ./boot.nix
    ./console.nix
    ./hardware.nix
    ./locale.nix
    ./zramswap.nix

    ../services/avahi.nix
    ../services/firewall.nix
    ../services/openssh.nix
#    ../services/tailscale.nix
  ];

  networking = {
#  	defaultGateway = "192.168.68.1";
#  	nameservers = [
#  		"1.1.1.1"
#  		"1.0.0.1"
#  	];
    hostName = hostname;
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
#    interfaces = {
#    	"wlp59s0" = {
#    		ipv4.addresses = [ {
#    			address = "192.168.68.116";
#    			prefixLength = 24;
#    		}];
#    	};
#   }; 
  };

  environment.systemPackages = (import ./packages.nix { inherit pkgs; }).basePackages;

  programs = {
    zsh.enable = true;
  };

  services = {
    chrony.enable = true;
    journald.extraConfig = "SystemMaxUse=250M";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Create dirs for home-manager
  systemd.tmpfiles.rules = [
    "d /nix/var/nix/profiles/per-user/${username} 0755 ${username} root"
  ];
}
