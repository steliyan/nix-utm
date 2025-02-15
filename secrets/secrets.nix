let
  k = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDHuswh8TCO6O/fETFM9Pb9CzTCY7XzuvKUDuLpRvccE";
in
{
  "tailscale.age".publicKeys = [ k ];
}
