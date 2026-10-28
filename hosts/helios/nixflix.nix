{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = [
    # for `agenix -e <secret>.age` to create/edit the encrypted secrets
    # referenced below
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # agenix decrypts secrets at activation using the host's SSH key
  # (age.identityPaths defaults to it once openssh is enabled).
  services.openssh.enable = true;

  age.secrets = {
    "sonarr-api-key".file = ./secrets/sonarr-api-key.age;
    "sonarr-password".file = ./secrets/sonarr-password.age;

    "radarr-api-key".file = ./secrets/radarr-api-key.age;
    "radarr-password".file = ./secrets/radarr-password.age;

    "prowlarr-api-key".file = ./secrets/prowlarr-api-key.age;
    "prowlarr-password".file = ./secrets/prowlarr-password.age;

    "sabnzbd-api-key".file = ./secrets/sabnzbd-api-key.age;
    "sabnzbd-nzb-key".file = ./secrets/sabnzbd-nzb-key.age;

    "jellyfin-api-key".file = ./secrets/jellyfin-api-key.age;
    "jellyfin-admin-password".file = ./secrets/jellyfin-admin-password.age;
  };

  nixflix = {
    enable = true;
    mediaDir = "/data/media";
    stateDir = "/data/.state";
    mediaUsers = [ "gazab" ];

    nginx = {
      enable = true;
      addHostsEntries = true; # disable if you run your own DNS
    };

    postgres.enable = true;

    sonarr = {
      enable = true;
      config = {
        apiKey._secret = config.age.secrets.sonarr-api-key.path;
        hostConfig.password._secret = config.age.secrets.sonarr-password.path;
      };
    };

    radarr = {
      enable = true;
      config = {
        apiKey._secret = config.age.secrets.radarr-api-key.path;
        hostConfig.password._secret = config.age.secrets.radarr-password.path;
      };
    };

    prowlarr = {
      enable = true;
      config = {
        apiKey._secret = config.age.secrets.prowlarr-api-key.path;
        hostConfig.password._secret = config.age.secrets.prowlarr-password.path;
      };
    };

    usenetClients.sabnzbd = {
      enable = true;
      settings.misc = {
        api_key._secret = config.age.secrets.sabnzbd-api-key.path;
        nzb_key._secret = config.age.secrets.sabnzbd-nzb-key.path;
      };
    };

    jellyfin = {
      enable = true;
      # generate with: openssl rand -hex 16
      apiKey._secret = config.age.secrets.jellyfin-api-key.path;
      users.admin = {
        policy.isAdministrator = true;
        password._secret = config.age.secrets.jellyfin-admin-password.path;
      };

      # Expose Jellyfin directly on the LAN (in addition to the nginx
      # vhost) so Chromecast devices -- which can't join the tailnet or
      # resolve jellyfin.nixflix -- can fetch streams directly from the
      # server when casting, and so the official apps' local-network
      # auto-discovery works.
      openFirewall = true;
      network = {
        # Empty means "bind to all interfaces"; reverseProxy.enable
        # defaults this to 127.0.0.1-only otherwise.
        localNetworkAddresses = [ ];
        # Tell LAN clients to use the direct address rather than
        # whatever hostname/IP they happened to reach the server
        # through. Update if helios's LAN IP changes (consider a DHCP
        # reservation on the router to keep it stable).
        publishedServerUriBySubnet = [ "192.168.0.0/24=http://192.168.0.15:8096" ];
      };
    };
  };
}
