{ pkgs, ... }:
{
  plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.copilot-lua;
      cmd = "Copilot";
      event = "InsertEnter";
      opts = {
        suggestion = { enabled = true; };
        panel = { enabled = true; };
        filetypes = {
          markdown = true;
          help = true;
          rust = true;
          nix = true;
          javascript = true;
          typescript = true;
          lua = true;
        };
      };
      keys = {
        __raw = ''
          {
            {
              "<leader>cP",
              function()
                if require("copilot.client").is_disabled() then
                  vim.cmd("Copilot enable")
                else
                  vim.cmd("Copilot disable")
                end
              end,
              desc = "Copilot Toggle",
            },
            {
              "<leader>cp",
              "<cmd>Copilot panel<CR>",
              desc = "Copilot Panel",
            },
          }
        '';
      };
    }
    {
      pkg = pkgs.vimPlugins.copilot-cmp;
      dependencies = [ pkgs.vimPlugins.copilot-lua ];
      config = true;
    }
  ];

  extraPackages = with pkgs; [
    nodejs
  ];
}
