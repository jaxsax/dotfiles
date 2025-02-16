# Install

Setup nix

```sh
curl --proto '=https' --tlsv1.2 -sSf -L \
  https://install.determinate.systems/nix | sh -s -- install
```

Setup packages
```sh
./install-pkgs
```

Setup dotfiles
```sh
./install
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
```
