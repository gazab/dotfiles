let
  # Your personal SSH public key(s), used so you can re-encrypt/edit secrets
  # with `agenix -e` from your own machine. Replace with the output of e.g.
  # `cat ~/.ssh/id_ed25519.pub`.
  gazab = "ssh-ed25519 AAAA...REPLACE_WITH_YOUR_PUBLIC_KEY gazab";

  # helios's SSH host key, used so the host itself can decrypt secrets at
  # activation time. Generated automatically by sshd on first boot; read it
  # back with `ssh-keyscan helios` or `cat /etc/ssh/ssh_host_ed25519_key.pub`
  # once the host exists, then replace the placeholder below.
  helios = "ssh-ed25519 AAAA...REPLACE_WITH_HELIOS_HOST_KEY helios";

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
