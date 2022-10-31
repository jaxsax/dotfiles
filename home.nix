{ pkgs, ... }: {
  home.username = "jaxsax";
  home.homeDirectory = "/home/jaxsax";
  home.shellAliases = { g = "git"; };
  home.packages = [ pkgs.nixfmt pkgs.neovim pkgs.zsh ];
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "jaxsax";
    userEmail = "jaxsax@users.noreply.github.com";
    aliases = {
      cm = "commit -v";
      ai = "add --interactive -p";
      pf = "push --force-with-lease";
    };
    extraConfig = { core = { editor = "nvim"; }; };
  };
  programs.zsh = {
    # https://github.com/NixOS/nix/issues/5445
    # Don't really wanna do the workaround here so let's just not use it for now
    enable = false;
  };
}
