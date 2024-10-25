# Install


```sh
apt update && apt install -y curl git stow zsh build-essential
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
./install-pkgs

curl --proto '=https' --tlsv1.2 -sSf -L \
  https://install.determinate.systems/nix | sh -s -- install
```

Then choose the right base folder and do `$folder/install`
