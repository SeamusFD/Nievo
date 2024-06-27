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
        { lhs = "gb"; mode = "v"; desc = "Toggle blockwise comment"; }
        { lhs = "gc"; mode = "v"; desc = "Toggle linewise comment"; }
        { lhs = "gbb"; desc = "Toggle blockwise comment"; }
        { lhs = "gcc"; desc = "Toggle linewise comment"; }
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
  ];
}
