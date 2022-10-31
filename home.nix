{ config, lib, pkgs, ... }:
let vimPlugsFromSource = import ./plugins.nix pkgs;
in {
  home.username = "jaxsax";
  home.homeDirectory = "/home/jaxsax";
  home.packages = with pkgs; [ nixfmt zsh ripgrep rnix-lsp ];
  home.stateVersion = "22.05";
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
  programs.bash.shellAliases = { g = "git"; };
  programs.tmux = {
    enable = true;
    escapeTime = 10;
    clock24 = true;
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-autopairs
      telescope-nvim
      nvim-lspconfig
      nvim-treesitter
      nvim-compe
      vimPlugsFromSource.nvim-popup
      vimPlugsFromSource.nvim-lsp-saga
      vimPlugsFromSource.gruvbox
    ];
    extraConfig = ''
      lua << EOF
      ${builtins.readFile ./lsp.lua}
      EOF

      colorscheme gruvbox
    '';
  };
}
