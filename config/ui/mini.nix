{ pkgs, ... }:
{
  plugins.lazy.plugins = with pkgs.vimPlugins;
    let
      mini-module =
        { name
        , event ? [ "BufReadPre" "BufNewFile" ]
        , dependencies ? [ ]
        , opts ? { }
        }: {
          pkg = mini-nvim;
          inherit name;
          inherit event;
          inherit dependencies;
          config = true;
          main = name;
          inherit opts;
        };
    in
    [
      (mini-module {
        name = "mini.ai";
        opts.n_lines = 500;
      })

      (mini-module { name = "mini.align"; })

      (mini-module {
        name = "mini.basics";
        event = [ ];
      })

      (mini-module {
        name = "mini.diff";
        opts.view.style = "sign";
      })

      (mini-module { name = "mini.extra"; })

      (mini-module { name = "mini.indentscope"; })

      (mini-module { name = "mini.surround"; })

      (mini-module { name = "mini.trailspace"; })

      {
        pkg = pkgs.vimPlugins.mini-nvim;
        event = "VeryLazy";
        config = ''
          function()
            require("mini.bufremove").setup()
          end
        '';
        keys = {
          __raw = ''
            {
              {
                "<leader>bd",
                function()
                  require("mini.bufremove").delete(0, false)
                end,
                desc = "Delete Buffer",
              },
              {
                "<leader>bD",
                function()
                  require("mini.bufremove").delete(0, true)
                end,
                desc = "Delete Buffer (Force)",
              },
            }
          '';
        };
      }
    ];
}
