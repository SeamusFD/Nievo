{ pkgs, ... }:
let
  plug = pkgs.vimPlugins;
in
{
  plugins.lazy.plugins = [
    {
      pkg = plug.persistence-nvim;
      event = "BufReadPre";
      config = true;
      # keys = {
      #   __raw = ''
      #     {
      #       {
      #         "n",
      #         "<leader>ws",
      #         "<cmd>lua require("persistence").load()<CR>"
      #         desc = "Restore Session",
      #       },
      #       {
      #         "n",
      #         "<leader>wl",
      #         "<cmd>lua require("persistence").load({ last = true })<CR>"
      #         desc = "Restore Last Session",
      #       },
      #       {
      #         "n",
      #         "<leader>wl",
      #         "<cmd>lua require("persistence").stop()<CR>"
      #         desc = "Stop Session Manager",
      #       },
      #     }
      #   '';
      # };
    }
  ];
}
