{ pkgs, helpers, ... }:

let
  inherit (import ../lib/mkLazyKey.nix { inherit helpers; }) mkLazyKeys;
  searchmap = desc: key: cmd: {
    lhs = "<leader>${key}";
    rhs = "<cmd>Telescope ${cmd}<cr>";
    inherit desc;
  };
  lua = x: x;
in
{
  config.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = telescope-nvim;
      dependencies = [
        noice-nvim
        plenary-nvim
        telescope-file-browser-nvim
        telescope-live-grep-args-nvim
        telescope-media-files-nvim
        telescope-ui-select-nvim
        telescope-fzf-native-nvim
        telescope-undo-nvim
        telescope-zoxide
        telescope-symbols-nvim
      ];
      cmd = [ "Telescope" ];
      keys = mkLazyKeys [
        (searchmap "Search Recently Opened Files" "<space>" "oldfiles")
        (searchmap "Resume Telescope" "tr" "resume")
        (searchmap "Pick Symbols" "ts" "symbols")
        (searchmap "Change Directory" "td" "zoxide list")
        (searchmap "Search Buffers" "sb" "buffers")
        (searchmap "Search Files" "sf" "find_files")
        (searchmap "Search Help" "sh" "help_tags")
        (searchmap "Search Current Word" "sw" "grep_string")
        (searchmap "Search Via Ripgrep" "sr" "live_grep")
        (searchmap "Search Current Buffer" "sc" "current_buffer_fuzzy_find")
        (searchmap "Search Diagnostics" "sd" "diagnostics")
        (searchmap "Search Quickfix" "sq" "quickfix")
        (searchmap "Search Jumplist" "sj" "jumplist")
        (searchmap "Search Marks" "sm" "marks")
        (searchmap "Search Git status" "sgs" "git_status")
        (searchmap "Search Document symbols" "sds" "lsp_document_symbols")
        (searchmap "Search Document references" "sdr" "lsp_references")
        (searchmap "Search Workspace Symbols" "sdw" "lsp_dynamic_workspace_symbols")
        (searchmap "Search Undo Tree" "su" "undo")
      ];
      config = lua ''
        function (_, opts)
          require("telescope").setup(opts)
          require("telescope").load_extension("file_browser")
          require("telescope").load_extension("live_grep_args")
          require("telescope").load_extension("media_files")
          require("telescope").load_extension("ui-select")
          require("telescope").load_extension("undo")
          require("telescope").load_extension("noice")
          require("telescope").load_extension("zoxide")
          require("telescope").load_extension("fzf")
        end
      '';
      opts = {
        extensions = {
          fzf = {
            fuzzy = true;
            override_generic_sorter = true;
            override_file_sorter = true;
            case_mode = "smart_case";
          };
        };
      };
    }
  ];
}
