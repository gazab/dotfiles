{ pkgs, ... }:

{
  # niri is Wayland-only; X11 apps (e.g. Steam) need xwayland-satellite
  # bridging in, since niri has no built-in Xwayland support like sway/hyprland.
  home.packages = [ pkgs.xwayland-satellite ];

  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland outside your Wayland";
      BindsTo = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };
    Service = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # niri's shipped default config, with Mod+Return added as a second terminal
  # bind (Mod+O for overview is already a default bind in this niri version).
  # Writing this file replaces niri's built-in default entirely, so it's kept
  # as a full, validated copy rather than a partial binds-only override.
  xdg.configFile."niri/config.kdl".text = builtins.readFile ./niri-config.kdl;
}
