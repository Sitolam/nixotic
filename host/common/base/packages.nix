{ pkgs, ... }: {
  basePackages = with pkgs; [
    agenix
    bat
    binutils
    curl
    dig
    dua
    duf
    unstable.eza
    fd
    file
    git
    jq
    killall
    nfs-utils
    ntfs3g
    pciutils
    ripgrep
    rsync
    tpm2-tss
    traceroute
    tree
    unzip
    usbutils
    vim
    wget
    yq-go
  ];
}
