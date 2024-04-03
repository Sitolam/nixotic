{ pkgs
, config
, ...
}:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.sitolam = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "audio"
        "networkmanager"
        "users"
        "video"
        "wheel"
      ]
      ++ ifExists [
        "docker"
        "plugdev"
        "render"
        "lxd"
      ];

    packages = [ pkgs.home-manager ];
  };

  # This is a workaround for not seemingly being able to set $EDITOR in home-manager
  environment.sessionVariables = {
    EDITOR = "vim";
  };
}
