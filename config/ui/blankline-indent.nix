{ pkgs, ... }:
let
  plug = pkgs.vimPlugins;
in
{
  plugins.lazy.plugins = [
    {
      pkg = plug.indent-blankline-nvim; # Indent guides
      event = [ "BufReadPost" "BufNewFile" ];
      main = "ibl";
      opts = {
        scope = { enabled = false; show_end = false; };
        exclude = {
          filetypes = [
            "help"
            "netrw"
            "Trouble"
            "lazy"
            "notify"
            "neo-tree"
          ];
        };
      };
    }
  ];

}
