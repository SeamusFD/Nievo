{ pkgs, helpers, ... }: {
  # Lazy load
  plugins.lazy = {
    enable = true;
    plugins = [
      # UI Imports
      (import ../ui/noice.nix { plugins = pkgs.vimPlugins; })
      (import ../ui/scope.nix { plugins = pkgs.vimPlugins; })

      # Coding imports
      (import ../coding/cursorline.nix { plugins = pkgs.vimPlugins; })
      (import ../coding/yanky.nix { plugins = pkgs.vimPlugins; })
      (import ../coding/flash.nix { plugins = pkgs.vimPlugins; helpers = helpers; })
    ];
  };

  # Multiple plugin imports
  imports = [
    ../colorschemes/catppuccin.nix
    ../coding/copilot.nix
    ../coding/colorizer.nix
    ../coding/git.nix
    ../coding/autopairs.nix
    ../coding/folding.nix

    ../ui/dashboard.nix
    ../ui/bufferline.nix
    ../ui/lualine.nix
    ../ui/telescope.nix
    ../ui/which-key.nix
    ../ui/blankline-indent.nix
    ../ui/mini.nix
    ../ui/neotree.nix
    ../languages/treesitter/treesitter.nix
    ../languages/lsp/lsp.nix

    ../formatting/format.nix
    ../formatting/lint.nix
  ];
}
