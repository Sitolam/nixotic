_: {
  boot = {
#    initrd.systemd.enable = true;

 #   kernel.sysctl = {
#      "net.ipv4.ip_forward" = 1;
#      "net.ipv6.conf.all.forwarding" = 1;
#    };

    loader = {
    	timeout = 10;
    	grub = {
    		enable = true;
    		devices = ["nodev"];
    		efiSupport = true;
    		useOSProber = true;
    		configurationLimit = 5;
    		default = "0";
    		extraEntries = ''
    			menuentry "Reboot" {
    				reboot
    			}
    			menuentry "Poweroff" {
    				halt
    			};
    		'';
    	};
    	efi = {
    		canTouchEfiVariables = true;
    		efiSysMountPoint = "/boot";
    	};
    };
  };
}
