{ config
, pkgs
, lib
, ...
}:

let
  cfg = config.services.homepage-dashboard;
  # Define the settings format used for this program
  settingsFormat = pkgs.formats.yaml { };
in
{
  options = {
    services.homepage-dashboard = {
      enable = lib.mkEnableOption (lib.mdDoc "Homepage Dashboard");

      package = lib.mkPackageOption pkgs "homepage-dashboard" { };

      openFirewall = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc "Open ports in the firewall for Homepage.";
      };

      listenPort = lib.mkOption {
        type = lib.types.int;
        default = 8082;
        description = lib.mdDoc "Port for Homepage to bind to.";
      };

      environmentFile = lib.mkOption {
        type = lib.types.str;
        description = ''
          The path to an environment file that contains environment variables to pass
          to the homepage-dashboard service, for the purpose of passing secrets to
          the service.

          See the upstream documentation:

          https://gethomepage.dev/latest/installation/docker/#using-environment-secrets
        '';
        default = "";
      };

      customCSS = lib.mkOption {
        type = lib.types.lines;
        description = lib.mdDoc ''
          Custom CSS for styling Homepage.

          See https://gethomepage.dev/latest/configs/custom-css-js/.
        '';
        default = "";
      };

      customJS = lib.mkOption {
        type = lib.types.lines;
        description = lib.mdDoc ''
          Custom Javascript for Homepage.

          See https://gethomepage.dev/latest/configs/custom-css-js/.
        '';
        default = "";
      };

      bookmarks = lib.mkOption {
        inherit (settingsFormat) type;
        description = lib.mdDoc ''
          Homepage bookmarks configuration.

          See https://gethomepage.dev/latest/configs/bookmarks/.
        '';
        # Defaults: https://github.com/gethomepage/homepage/blob/main/src/skeleton/bookmarks.yaml
        example = [
          {
            Developer = [
              { Github = [{ abbr = "GH"; href = "https://github.com/"; }]; }
            ];
          }
          {
            Entertainment = [
              { YouTube = [{ abbr = "YT"; href = "https://youtube.com/"; }]; }
            ];
          }
        ];
        default = [ ];
      };

      services = lib.mkOption {
        inherit (settingsFormat) type;
        description = lib.mdDoc ''
          Homepage services configuration.

          See https://gethomepage.dev/latest/configs/services/.
        '';
        # Defaults: https://github.com/gethomepage/homepage/blob/main/src/skeleton/services.yaml
        example = [
          {
            "My First Group" = [
              {
                "My First Service" = {
                  href = "http://localhost/";
                  description = "Homepage is awesome";
                };
              }
            ];
          }
          {
            "My Second Group" = [
              {
                "My Second Service" = {
                  href = "http://localhost/";
                  description = "Homepage is the best";
                };
              }
            ];
          }
        ];
        default = [ ];
      };

      widgets = lib.mkOption {
        inherit (settingsFormat) type;
        description = lib.mdDoc ''
          Homepage widgets configuration.

          See https://gethomepage.dev/latest/configs/service-widgets/.
        '';
        # Defaults: https://github.com/gethomepage/homepage/blob/main/src/skeleton/widgets.yaml
        example = [
          {
            resources = {
              cpu = true;
              memory = true;
              disk = "/";
            };
          }
          {
            search = {
              provider = "duckduckgo";
              target = "_blank";
            };
          }
        ];
        default = [ ];
      };

      kubernetes = lib.mkOption {
        inherit (settingsFormat) type;
        description = lib.mdDoc ''
          Homepage kubernetes configuration.

          See https://gethomepage.dev/latest/configs/kubernetes/.
        '';
        default = { };
      };

      docker = lib.mkOption {
        inherit (settingsFormat) type;
        description = lib.mdDoc ''
          Homepage docker configuration.

          See https://gethomepage.dev/latest/configs/docker/.
        '';
        default = { };
      };

      settings = lib.mkOption {
        inherit (settingsFormat) type;
        description = lib.mdDoc ''
          Homepage settings.

          See https://gethomepage.dev/latest/configs/settings/.
        '';
        # Defaults: https://github.com/gethomepage/homepage/blob/main/src/skeleton/settings.yaml
        default = { };
      };
    };
  };

  config =
    let
      # If homepage-dashboard is enabled, but none of the configuration values have been updated,
      # then default to "unmanaged" configuration which is manually updated in
      # var/lib/homepage-dashboard. This is to maintain backwards compatibility, and should be
      # deprecated in a future release.
      managedConfig = !(
        cfg.bookmarks == [ ] &&
        cfg.customCSS == "" &&
        cfg.customJS == "" &&
        cfg.docker == { } &&
        cfg.kubernetes == { } &&
        cfg.services == [ ] &&
        cfg.settings == { } &&
        cfg.widgets == [ ]
      );

      configDir = if managedConfig then "/etc/homepage-dashboard" else "/var/lib/homepage-dashboard";

      msg = "using unmanaged configuration for homepage-dashboard will be deprecated in 24.05. "
        + "please see the NixOS documentation for `services.homepage-dashboard' and add your "
        + "bookmarks, services, widgets, and other configuration using the options provided.";
    in
    lib.mkIf cfg.enable {
      warnings = lib.optional (!managedConfig) msg;

      environment.etc = lib.mkIf managedConfig {
        "homepage-dashboard/custom.css".text = cfg.customCSS;
        "homepage-dashboard/custom.js".text = cfg.customJS;

        "homepage-dashboard/bookmarks.yaml".source = settingsFormat.generate "bookmarks.yaml" cfg.bookmarks;
        "homepage-dashboard/docker.yaml".source = settingsFormat.generate "docker.yaml" cfg.docker;
        "homepage-dashboard/kubernetes.yaml".source = settingsFormat.generate "kubernetes.yaml" cfg.kubernetes;
        "homepage-dashboard/services.yaml".source = settingsFormat.generate "services.yaml" cfg.services;
        "homepage-dashboard/settings.yaml".source = settingsFormat.generate "settings.yaml" cfg.settings;
        "homepage-dashboard/widgets.yaml".source = settingsFormat.generate "widgets.yaml" cfg.widgets;
      };

      systemd.services.homepage-dashboard = {
        description = "Homepage Dashboard";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];

        environment = {
          HOMEPAGE_CONFIG_DIR = configDir;
          PORT = toString cfg.listenPort;
        };

        serviceConfig = {
          Type = "simple";
          DynamicUser = true;
          EnvironmentFile = lib.mkIf (cfg.environmentFile != null) cfg.environmentFile;
          StateDirectory = lib.mkIf (!managedConfig) "homepage-dashboard";
          ExecStart = lib.getExe cfg.package;
          Restart = "on-failure";
        };
      };

      networking.firewall = lib.mkIf cfg.openFirewall {
        allowedTCPPorts = [ cfg.listenPort ];
      };
    };
}
