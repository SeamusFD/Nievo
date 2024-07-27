{ ... }: {
  # Lazy load
  plugins.lazy.enable = true;
  plugins.treesitter.enable = true;
  # Plugin imports
  imports = [
    ./coding
    ./formatting
    ./colorschemes
    ./ui
    ./languages
  ];
}
