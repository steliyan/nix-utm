let
  k = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMridNIKPDf98fY69bM+ue4EAfN0VXsLoWLS79lIbKIG";
in
{
  "secret1.age".publicKeys = [ k ];
}
