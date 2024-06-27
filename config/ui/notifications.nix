{ pkgs, ... }:
{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-notify;
      event = "VeryLazy";
      config = true;
      opts = {
        stages = "static";
        timeout = 3000;
      };
      keys = {
        __raw = ''
          {
            {
              "<leader>un",
              function()
                require("notify").dismiss({ silent = true, pending = true })
              end,
              desc = "Dismiss All Notifications",
            },
            {
              "<leader>uh",
              function()
                require("telescope").extensions.notify.notify()
              end,
              desc = "Open Notification History",
            },
          }
        '';
      };
    }
    {
      pkg = noice-nvim;
      event = "VeryLazy";
      dependencies = [
        nui-nvim
        nvim-notify
        nvim-treesitter
      ];
      config = ''
        {
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        }
      '';
    }
  ];
}
