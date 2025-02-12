# Steps

1. Clear old SSH fingerprints on the host

```sh
ssh-keygen -R '[localhost]:22022'
```

> Only if you've already used the existing port/host.

2. Create a new virtual machine in **UTM**

- CPU: `Default`
- Memory: `16GB` (the `tmpfs` is 50%, so you need more space, otherwise `disko` setup fails)
- Network: `Emulated VLAN`
  - Add a port mapping `22` to `22022`
  - Set password for the `nixos` user by using:

For some reason, SSH can't be used with **Bridged** networking, although `nc` successfully connects using `nc -z <IP_ADDRESS>`.

```sh
passwd
```

3. Test SSH connectivity

```sh
ssh nixos@localhost -p 22022
```

4. Disko

4.1. Disk configuration

```sh
curl https://raw.githubusercontent.com/nix-community/disko/master/example/hybrid.nix -o /tmp/disko-config.nix
```

4.2. Update the disk name
If running in a VM, use `/dev/vda`. Or use `lsblk` to find out the disk name.

4.3. ⚠️ Format disk

```sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko-config.nix
```

4.4. Verify

```sh
mount | grep /mnt # OR lsblk
```

5. Install

5.1. Clone repo

```sh
sudo mkdir -p /mnt/etc/nixos
cd /mnt/etc/nixos
sudo git clone https://github.com/steliyan/nix-utm .
```

5.2. Install NixOS

```sh
sudo nixos-install --root /mnt --flake '/mnt/etc/nixos#nixos'
sudo reboot
```

5.3. Eject NixOS ISO

6. Post-install

- Enable flakes - TODO

## References

- <https://github.com/nix-community/disko/blob/master/docs/quickstart.md>
- <https://nixos.asia/en/nixos-install-disko>
