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
        name = "mini.animate";
        opts.__raw = ''
          function()
            -- don't use animate when scrolling with the mouse
            local mouse_scrolled = false
            for _, scroll in ipairs({ "Up", "Down" }) do
              local key = "<ScrollWheel" .. scroll .. ">"
              vim.keymap.set({ "", "i" }, key, function()
                mouse_scrolled = true
                return key
              end, { expr = true })
            end

            local animate = require("mini.animate")
            return {
              resize = {
                timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
              },
              scroll = {
                timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
                subscroll = animate.gen_subscroll.equal({
                  predicate = function(total_scroll)
                    if mouse_scrolled then
                      mouse_scrolled = false
                      return false
                    end
                    return total_scroll > 1
                  end,
                }),
              },
            }
          end,
        '';
      })
      # (mini-module {
      #   name = "mini.ai";
      #   opts.__raw = ''
      #     function()
      #         local ai = require("mini.ai")
      #         return {
      #           n_lines = 500,
      #           custom_textobjects = {
      #             o = ai.gen_spec.treesitter({ -- code block
      #               a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      #               i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      #             }),
      #             f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
      #             c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
      #             t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
      #             d = { "%f[%d]%d+" }, -- digits
      #             e = { -- Word with case
      #               { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
      #               "^().*()$",
      #             },
      #             u = ai.gen_spec.function_call(), -- u for "Usage"
      #             U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      #           },
      #         }
      #       end,
      #   '';
      #   opts.n_lines = 500;
      # })
      # (mini-module { name = "mini.align"; })
      # (mini-module { name = "mini.basics"; })
      # (mini-module { name = "mini.diff"; opts.view.style = "sign"; })
      # (mini-module { name = "mini.extra"; })
      # (mini-module { name = "mini.indentscope"; })
      # (mini-module { name = "mini.trailspace"; })
      {
        pkg = mini-nvim;
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
