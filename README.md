<h1 align="center">
<a href='#'><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/></a>
  <br>
  <br>
  <div>
    <a href="https://github.com/SeamusFD/Nievo/issues">
        <img src="https://img.shields.io/github/issues/redyf/Neve?color=fab387&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/SeamusFD/Nievo/stargazers">
        <img src="https://img.shields.io/github/stars/redyf/Neve?color=ca9ee6&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/SeamusFD/Nievo">
        <img src="https://img.shields.io/github/repo-size/SeamusFD/Nievo?color=ea999c&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/SeamusFD/Nievo/blob/main/LICENCE">
        <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=ca9ee6&colorA=313244&colorB=cba6f7"/>
    </a>
    <br>
        <img href="https://builtwithnix.org" src="https://builtwithnix.org/badge.svg"/>
    </div>
   </h1>

<h1 align="center">Nievo</h1>
<br>
A Nixvim and Lazy.nvim Neovim configuration modularised through flakes.
<br>
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
