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
        __raw = ''
          {
            plugins = {
              spelling = {
                enabled = true,
              },
            },
            defaults = {
              { "<leader>b", group = "+Buffer" },
              { "<leader>b_", hidden = true },
              { "<leader>c", group = "+Code" },
              { "<leader>c_", hidden = true },
              { "<leader>f", group = "+File" },
              { "<leader>f_", hidden = true },
              { "<leader>g", group = "+Git" },
              { "<leader>g_", hidden = true },
              { "<leader>h", group = "+Hunk" },
              { "<leader>h_", hidden = true },
              { "<leader>q", group = "+Quit" },
              { "<leader>q_", hidden = true },
              { "<leader>r", group = "+Rename" },
              { "<leader>r_", hidden = true },
              { "<leader>s", group = "+Search" },
              { "<leader>s_", hidden = true },
              { "<leader>t", group = "+Telescope" },
              { "<leader>t_", hidden = true },
              { "<leader>u", group = "+UI" },
              { "<leader>u_", hidden = true },
              { "<leader>v", group = "+Visibility" },
              { "<leader>v_", hidden = true },
              { "<leader>w", group = "+Workspace" },
              { "<leader>w_", hidden = true },
              { "<leader>x", group = "+Trouble" },
              { "<leader>x_", hidden = true },
              mode = { "n", "v" },
              { "[", group = "+Prev" },
              { "[_", hidden = true },
              { "]", group = "+Next" },
              { "]_", hidden = true },
              { "g", group = "+Goto" },
              { "g_", hidden = true },
            },
          }
        '';
      };
      config = ''
        function(_, opts)
          local wk = require("which-key")
          wk.setup(opts)
          wk.add(opts.defaults)
        end
      '';
    }
  ];
}
