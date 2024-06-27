{ pkgs, ... }:
let
  plugins = pkgs.vimPlugins;
in
{
  plugins.lazy.plugins =  [
    {
      pkg = plugins.nvim-colorizer-lua;
      config = true;
    }
  ];
}
