{ ... }: {
  # Lazy load
  plugins.lazy.enable = true;
  # Plugin imports
  imports = [
    ./coding
    ./formatting
    ./colorschemes
    ./ui
    ./languages
  ];
}
