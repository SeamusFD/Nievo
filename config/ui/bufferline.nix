{ pkgs, ... }:
{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = bufferline-nvim;
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
      pkg = nvim-cursorline;
      event = "VeryLazy";
      config = true;
    }
  ];
}
