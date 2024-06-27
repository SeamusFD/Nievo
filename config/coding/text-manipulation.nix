{ pkgs, helpers, ... }:
let
  inherit (import ../lib/mkLazyKey.nix { inherit helpers; }) lua mkLazyKeys;
in
{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = guess-indent-nvim;
      event = [ "BufReadPost" "BufNewFile" ];
      config = true;
    }
    {
      pkg = comment-nvim;
      config = true;
      keys = mkLazyKeys [
        { lhs = "gb"; mode = "v"; desc = "Toggle Blockwise Comment"; }
        { lhs = "gc"; mode = "v"; desc = "Toggle Linewise Comment"; }
        { lhs = "gbb"; desc = "Toggle Blockwise Comment"; }
        { lhs = "gcc"; desc = "Toggle Linewise Comment"; }
      ];
    }
    {
      pkg = nvim-autopairs;
      dependencies = [ nvim-treesitter nvim-cmp ];
      event = [ "InsertEnter" ];
      opts = {
        break_undo = false;
        check_ts = true; # enable tree-sitter
        ts_config = {
          lua = [ "string" ];
          javascript = [ "string" "template_string" ];
        };
      };
    }
    {
      pkg = nvim-surround;
      event = [ "InsertEnter" ];
      config = true;
    }
    {
      pkg = yanky-nvim;
      event = "VeryLazy";
      config = true;
    }
  ];
}
