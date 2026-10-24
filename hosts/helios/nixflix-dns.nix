{
  # Answers *.nixflix with helios's tailnet IP so devices on the tailnet
  # (once configured as a Split DNS nameserver in the Tailscale admin
  # console) can resolve the same hostnames nginx already routes by.
  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "tailscale0";
      bind-interfaces = true;
      no-resolv = true;
      address = [ "/nixflix/100.99.188.26" ];
    };
  };
}
