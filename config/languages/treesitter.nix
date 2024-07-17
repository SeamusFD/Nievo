{ pkgs, ... }:
let
  allParsers = with pkgs.vimPlugins;
    builtins.filter
      (p: p.pkg ? type && p.pkg.type == "derivation")
      (builtins.map
        (name: {
          pkg = nvim-treesitter-parsers.${name};
          ft = [ name ];
        })
        (builtins.attrNames nvim-treesitter-parsers));
in
{
  plugins.lazy.plugins = with pkgs.vimPlugins; allParsers ++ [
    {
      pkg = nvim-treesitter;
      event = [ "BufReadPost" "BufNewFile" ];
      dependencies = [
        nvim-treesitter-textobjects
        rainbow-delimiters-nvim
        # Parsers that should be auto-loaded. These are ones that can be
        # embedded into other languages or are just so common.
        nvim-treesitter-parsers.bash
        nvim-treesitter-parsers.lua
        nvim-treesitter-parsers.markdown
        nvim-treesitter-parsers.markdown_inline
        nvim-treesitter-parsers.regex
        nvim-treesitter-parsers.vimdoc
      ];
      config = ''
        function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = {},
            auto_install = false,
            indent = { enable = true, disable = { "python" } },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
              },
            },
            textobjects = {
              select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ["aa"] = "@parameter.outer",
                  ["ia"] = "@parameter.inner",
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                },
              },
              move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                  ["]m"] = "@function.outer",
                  ["]]"] = "@class.outer",
                },
                goto_next_end = {
                  ["]M"] = "@function.outer",
                  ["]["] = "@class.outer",
                },
                goto_previous_start = {
                  ["[m"] = "@function.outer",
                  ["[["] = "@class.outer",
                },
                goto_previous_end = {
                  ["[M"] = "@function.outer",
                  ["[]"] = "@class.outer",
                },
              },
              swap = {
                enable = true,
                swap_next = { ["<leader>a"] = "@parameter.inner" },
                swap_previous = { ["<leader>A"] = "@parameter.inner" },
              },
            },
          })
        end
      '';
    }
    {
      pkg = nvim-treesitter-context;
      dependencies = [ nvim-treesitter ];
      event = [ "BufReadPost" "BufNewFile" ];
      config = true;
      keys = {
        __raw = ''
          {
            {
              "[c",
              function()
                require("treesitter-context").go_to_context()
              end,
              desc = "Go to Context",
            },
          }
        '';
      };
    }
  ];
}
