{ ... }: {
  # Lazy load
  plugins.lazy.enable = true;
  # Plugin imports
  imports = [
    ./formatting
    ./colorschemes
    ./ui
    ./languages
  ];
}
