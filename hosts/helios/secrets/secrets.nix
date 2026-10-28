let
  # Personal key, used to re-encrypt/edit secrets with `agenix -e`.
  gazab = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMX2ax/VTeWqknUlivIAx/IcTDYWHHcYXdB4/wHuBVEE gazab";

  # helios's SSH host key, used so the host itself can decrypt secrets at activation time.
  helios = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHmp/PTKSuQ36ktoi1hN5FiIzkCiR+ps3OYhTbUCRw0 helios";

  users = [ gazab ];
  systems = [ helios ];
in
{
  "sonarr-api-key.age".publicKeys = users ++ systems;
  "sonarr-password.age".publicKeys = users ++ systems;

  "radarr-api-key.age".publicKeys = users ++ systems;
  "radarr-password.age".publicKeys = users ++ systems;

  "prowlarr-api-key.age".publicKeys = users ++ systems;
  "prowlarr-password.age".publicKeys = users ++ systems;

  "sabnzbd-api-key.age".publicKeys = users ++ systems;
  "sabnzbd-nzb-key.age".publicKeys = users ++ systems;

  "jellyfin-api-key.age".publicKeys = users ++ systems;
  "jellyfin-admin-password.age".publicKeys = users ++ systems;
}
