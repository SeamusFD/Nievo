{ pkgs, ... }:
{
  config.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = trouble-nvim;
      event = "VeryLazy";
      dependencies = [ nvim-web-devicons ];
      config = true;
      keys = {
        __raw = ''
          {
            {
              "<leader>xx",
              "<cmd>Trouble diagnostics toggle<cr>",
              desc = "Trouble Diagnostics",
            },
            {
              "<leader>xX",
              "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
              desc = "Trouble Buffer Diagnostics",
            },
            {
              "<leader>cs",
              "<cmd>Trouble symbols toggle focus=false<cr>",
              desc = "Trouble Symbols Toggle",
            },
            {
              "<leader>cl",
              "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
              desc = "Trouble LSP Definitions / references / ...",
            },
            {
              "<leader>xL",
              "<cmd>Trouble loclist toggle<cr>",
              desc = "Trouble Location List",
            },
            {
              "<leader>xQ",
              "<cmd>Trouble qflist toggle<cr>",
              desc = "Trouble Quickfix List",
            },
          }
        '';
      };
    }
  ];
}
