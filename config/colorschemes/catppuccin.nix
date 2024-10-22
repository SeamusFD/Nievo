{ pkgs, ... }:
{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = catppuccin-nvim;
      name = "catppuccin";
      lazy = false;
      priority = 1000;
      config = ''
        function()
          require("catppuccin").setup({
            flavour = "mocha",
            --transparent_background = true,
            integrations = {
              native_lsp = {
                enabled = true,
                virtual_text = {
                  errors = { "italic" },
                  hints = { "italic" },
                  warnings = { "italic" },
                  information = { "italic" },
                },
                underlines = {
                  errors = { "underline" },
                  hints = { "underline" },
                  warnings = { "underline" },
                  information = { "underline" },
                },
                inlay_hints = {
                  background = true,
                },
              },
              telescope = {
                enabled = true,
              },
              navic = { enabled = true, custom_bg = "lualine" },
              cmp = true,
              dashboard = true,
              gitsigns = true,
              neotree = true,
              treesitter = true,
              treesitter_context = true,
              markdown = true,
              mini = true,
              notify = true,
              lsp_trouble = true,
              fidget = true,
              indent_blankline = { enabled = true },
              noice = true,
              which_key = true,
              illuminate = true,
              semantic_tokens = true,
            },
          })
          vim.o.termguicolors = true
          vim.cmd.colorscheme("catppuccin")
        end
      '';

      keys = {
        __raw = ''
          {
            { "<leader>l", "<CMD>Lazy<cr>", desc = "Lazy Menu" },
          }
        '';
      };
    }
  ];
}
