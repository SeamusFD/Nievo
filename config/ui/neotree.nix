{ pkgs, ... }:
let
  plug = pkgs.vimPlugins;
in
{
  plugins.lazy.plugins = [
    {
      pkg = plug.neo-tree-nvim;
      dependencies = [
        plug.plenary-nvim
        plug.nvim-web-devicons
        plug.nui-nvim
        plug.nvim-window-picker
      ];
      opts = {
        close_if_last_window = true;
        popup_border_style = "rounded";
        default_component_configs = {
          container = {
            enable_character_fade = false;
          };
          git_status = {
            symbols = {
              added = "";
              deleted = "";
              modified = "";
              renamed = "";
              untracked = "";
              ignored = "";
              unstaged = "";
              staged = "";
              conflict = "";
            };
          };
        };
        window = {
          width = 36;
          mappings."Z" = "expand_all_nodes";
        };
        filesystem = {
          filtered_items = {
            force_visible_in_empty_folder = true;
            hide_dotfiles = false;
            hide_by_name = [ ".git" ];
            never_show = [ ".DS_Store" ];
          };
          group_empty_dirs = true;
          follow_current_file = {
            enabled = true;
          };
          use_libuv_file_watcher = true;
        };
      };
    }
  ];
}
