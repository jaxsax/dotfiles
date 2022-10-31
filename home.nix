{ pkgs, ... }: {
  home.username = "jaxsax";
  home.homeDirectory = "/home/jaxsax";
  home.packages = [ pkgs.nixfmt pkgs.neovim ];
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
