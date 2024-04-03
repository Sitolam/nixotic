{ pkgs, lib, ... }: {
  boot = {
    # Secure boot configuration
#   bootspec.enable = true;
    loader.systemd-boot.enable = lib.mkForce false;

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "uas"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];

      kernelModules = [ ];

    };

    kernelModules = [
      "kvm-intel"
    ];

    # Use the latest Linux kernel, rather than the default LTS
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
