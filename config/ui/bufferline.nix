{ pkgs, ... }:
let
  plug = pkgs.vimPlugins;
in
{
  plugins.lazy.plugins = [
    {
      pkg = plug.bufferline-nvim;
      name = "bufferline-nvim";
      event = "VeryLazy";
      config = ''
        {
          options = {
            themable = true,
            color_icons = true,
            diagnositics = "nvim_lsp",
            always_show_bufferline = false,
            separator_style = "thick",

            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,

            offsets = {
              {
                filetype = "neo-tree",
                text = "Neo-Tree",
                highlight = "Directory",
                text_align = "left"
              }
            }
          }
        }
      '';
    }
    {
      pkg = plug.nvim-cursorline;
      event = "VeryLazy";
      config = true;
    }
    {
      pkg = plug.vim-illuminate;
      event = "VeryLazy";
      config = ''
        function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
              vim.keymap.set("n", key, function()
                require("illuminate")["goto_" .. dir .. "_reference"](false)
              end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
              callback = function()
                local buffer = vim.api.nvim_get_current_buf()
                map("]]", "next", buffer)
                map("[[", "prev", buffer)
              end,
            })
          end,
          keys = {
            { "]]", desc = "Next Reference" },
            { "[[", desc = "Prev Reference" },
          }
      '';
      opts = {
        delay = 200;
        large_file_cutoff = 2000;
        large_file_overrides = {
          providers = [ "lsp" "treesitter" "regex" ];
        };
      };
    }
  ];
}
