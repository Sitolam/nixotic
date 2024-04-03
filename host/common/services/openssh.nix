_: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
