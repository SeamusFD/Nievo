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
          "g" = { name = "+Goto"; _ = "which_key_ignore"; };
          "]" = { name = "+Next"; _ = "which_key_ignore"; };
          "[" = { name = "+Prev"; _ = "which_key_ignore"; };
          "<leader>b" = { name = "+Buffer"; _ = "which_key_ignore"; };
          "<leader>c" = { name = "+Code"; _ = "which_key_ignore"; };
          "<leader>g" = { name = "+Git"; _ = "which_key_ignore"; };
          "<leader>q" = { name = "+Quit"; _ = "which_key_ignore"; };
          "<leader>s" = { name = "+Search"; _ = "which_key_ignore"; };
          "<leader>h" = { name = "+Hunk"; _ = "which_key_ignore"; };
          "<leader>r" = { name = "+Rename"; _ = "which_key_ignore"; };
          "<leader>w" = { name = "+Workspace"; _ = "which_key_ignore"; };
          "<leader>f" = { name = "+File"; _ = "which_key_ignore"; };
          "<leader>x" = { name = "+Trouble"; _ = "which_key_ignore"; };
          "<leader>t" = { name = "+Telescope"; _ = "which_key_ignore"; };
          "<leader>u" = { name = "+UI"; _ = "which_key_ignore"; };
          "<leader>v" = { name = "+Visibility"; _ = "which_key_ignore"; };
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
