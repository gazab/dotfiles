{
  # Answers *.nixflix with helios's tailnet IP so devices on the tailnet
  # (once configured as a Split DNS nameserver in the Tailscale admin
  # console) can resolve the same hostnames nginx already routes by.
  services.dnsmasq = {
    enable = true;
    # Without this, NixOS points the *entire system's* DNS at 127.0.0.1
    # (dnsmasq) by default -- but dnsmasq here only listens on tailscale0,
    # so every lookup on helios itself would fail. This keeps dnsmasq
    # scoped to just answering tailnet peers asking for *.nixflix.
    resolveLocalQueries = false;
    settings = {
      interface = "tailscale0";
      bind-interfaces = true;
      no-resolv = true;
      address = [ "/nixflix/100.99.188.26" ];
    };
  };
}
