# Nievo

A Nixvim and Lazy.nvim Neovim configuration modularised through flakes.

## Structure

- `flake.nix`: Main module flake with inputs and outputs. Creates a derivation of Nixvim with everything in the `config` folder. When in root directly running `nix run .` launches the neovim config without installation.
- `config`
  - `coding`
    - `autopairs.nix`
    - `colorizer.nix`
    - `copilot.nix`
    - `cursorline.nix`
    - `flash.nix`
    - `folding.nix`
    - `git.nix`
    - `yanky.nix`
  - `colorschemes`
    - `catppuccin.nix`
  - `formatting`
    - `format.nix`
    - `lint.nix`
  - `languages`
    - `lsp.nix`
    - `treesitter.nix`
  - `lazy`
    - `lazy.nix`
  - `lib`
    - `mkLazyKey.nix`
  - `ui`
    - `blankline-indent.nix`
    - `bufferline.nix`
    - `dashboard.nix`
    - `lualine.nix`
    - `mini.nix`
    - `neotree.nix`
    - `noice.nix`
    - `scope.nix`
    - `telescope.nix`
    - `which-key.nix`
  - `default.nix`: Simple import file which pulls in all the folders for use in the flake.
  - `keymaps.nix`: Global keymaps in Nixvim. Some keymaps are lazily loaded through the `lazy` folder.
  - `sets.nix`: Global Neovim configurations set through Nixvim. Some overrides are present in the `lazy` folder.
