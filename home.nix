{ config, lib, pkgs, ... }:
let vimPlugsFromSource = import ./plugins.nix pkgs;
in {
  home.username = "jaxsax";
  home.homeDirectory = "/home/jaxsax";
  home.shellAliases = {
    "g" = "git";
    "l" = "ls -la";
  };
  home.packages = with pkgs; [
    nixfmt
    zsh
    ripgrep
    rnix-lsp
    tree-sitter
    sumneko-lua-language-server
  ];
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
      cma = "commit --amend -v";
    };
    extraConfig = { core = { editor = "nvim"; }; };
  };
  programs.zsh = {
    # https://github.com/NixOS/nix/issues/5445
    # Don't really wanna do the workaround here so let's just not use it for now
    enable = false;
  };
  programs.bash = {
    enable = true;
    profileExtra = ''
      export LC_ALL="en_US.UTF-8"
      export LANG="en_US.UTF-8"

      export PATH="$HOME/.nix-profile/bin:$PATH"
    '';
  };
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
      nvim-compe
      lspkind-nvim
      nvim-web-devicons
      (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          tree-sitter-python
          tree-sitter-go
          tree-sitter-json
          tree-sitter-lua
        ]))
      plenary-nvim
      vimPlugsFromSource.nvim-popup
      vimPlugsFromSource.nvim-lsp-saga
      vimPlugsFromSource.gruvbox
    ];
    extraConfig = ''
      lua << EOF
      ${builtins.readFile ./sane_defaults.lua}
      ${builtins.readFile ./telescope.lua}
      ${builtins.readFile ./treesitter.lua}
      ${builtins.readFile ./lsp.lua}
      EOF

      colorscheme gruvbox
      autocmd BufWritePre *.go :silent! lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    '';
  };
}
