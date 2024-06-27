{ pkgs, ... }:
let
  plug = pkgs.vimPlugins;
in
{
  plugins.lazy.plugins = [
    {
      pkg = plug.which-key-nvim;
      event = "VeryLazy";
      opts = {
        plugins = { spelling = true; };
        defaults = {
          mode = [ "n" "v" ];
          "g" = { name = "+goto"; _ = "which_key_ignore"; };
          "]" = { name = "+next"; _ = "which_key_ignore"; };
          "[" = { name = "+prev"; _ = "which_key_ignore"; };
          "<leader>c" = { name = "+code"; _ = "which_key_ignore"; };
          "<leader>g" = { name = "+git"; _ = "which_key_ignore"; };
          "<leader>s" = { name = "+search"; _ = "which_key_ignore"; };
          "<leader>f" = { name = "+file"; _ = "which_key_ignore"; };
        };
      };
      config = ''
        function(_, opts)
          local wk = require("which-key")
          wk.setup(opts)
          wk.register(opts.defaults)
        end
      '';
    }
  ];
}
