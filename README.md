
1. Generate a new SSH key

```sh
ssh-keygen -t ed25519 -C "steliyan@localhost" -f $HOME/.ssh/id_localhost
```

2. Update the SSH configuration

File: `~/.ssh/config`

Contents:

```text
Host localhost
    IdentityFile ~/.ssh/id_localhost
```

3. Set passworf for the `nixos` user for the NixOS installer

```sh
passwd
```

4. Install

```sh
ssh-keygen -R '[localhost]:22023' && ssh nixos@localhost -p 22023 -o StrictHostKeyChecking=accept-new
```

```sh
cd /tmp && \
git clone https://github.com/steliyan/nix-utm.git && \
cd nix-utm && \
nix run --experimental-features "nix-command flakes" github:nix-community/nixos-anywhere -- --flake '.#utm' --target-host nixos@localhost
```

5. Post-install

  5.1. Reset `steliyan` password: `passwd`
  5.2. Reset `root` password: `sudo passwd root`
  5.3. Connect to VM

```sh
ssh-keygen -R '[localhost]:22023' && ssh steliyan@localhost -p 22023 -o StrictHostKeyChecking=accept-new
```
