{ pkgs, ... }:
let
  lua = x: x;
in
{
  config.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-navic;
      lazy = true;
      config = true;
    }
    {
      pkg = neodev-nvim;
      ft = [ "lua" ];
      opts.pathStrict = true;
    }
    {
      pkg = nvim-cmp;
      dependencies = [
        # Utils
        lspkind-nvim
        # Config
        cmp-nvim-lsp
        nvim-lspconfig
        # Autocompletion
        cmp-buffer
        cmp-nvim-lua
        cmp-path
        cmp-treesitter
        cmp-spell
        copilot-cmp
        cmp_luasnip
        nvim-autopairs
        # Snippets
        luasnip
        friendly-snippets # Extra
        nvim-navic
      ];
      event = [ "BufReadPre" "BufNewFile" ];
      opts.__raw = lua ''
        function (_, opts)
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          }
          capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

          local server = {
            dartls = {},
            kotlin_language_server = {},
            nixd = {},
            svelte = {},
            phpactor = {},
            pyright = {},
            rust_analyzer = {
              ["rust-analyzer"] = {
                files = {
                  excludeDirs = { ".direnv", ".devenv" },
                },
              },
            },
            lua_ls = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
            gopls = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
              },
            },
            tsserver = {},
          }

          local lspconfig = require("lspconfig")
          for name, settings in pairs(server) do
            lspconfig[name].setup({
              capabilities = capabilities,
              settings = settings,
            })
          end

          local cmp = require("cmp")
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")

          cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
          )

          local lspkind = require("lspkind")
          lspkind.init({
            mode = "symbol_text",
            preset = "codicons",
            symbol_map = {
                  Text = "󰉿",
                  Method = "󰆧",
                  Function = "󰊕",
                  Constructor = "",
                  Field = "󰜢",
                  Variable = "󰀫",
                  Class = "󰠱",
                  Interface = "",
                  Module = "",
                  Property = "󰜢",
                  Unit = "󰑭",
                  Value = "󰎠",
                  Enum = "",
                  Keyword = "󰌋",
                  Snippet = "",
                  Color = "󰏘",
                  File = "󰈙",
                  Reference = "󰈇",
                  Folder = "󰉋",
                  EnumMember = "",
                  Constant = "󰏿",
                  Struct = "󰙅",
                  Event = "",
                  Operator = "󰆕",
                  TypeParameter = "",
                },
            })

          local luasnip = require("luasnip")
          require("luasnip.loaders.from_vscode").lazy_load()

          return vim.tbl_extend("keep", {
            formatting = {
              format = lspkind.cmp_format({
                with_text = true,
                maxwidth = 60,
                menu = {
                  buffer = "[﬘]",
                  luasnip = "[]",
                  nvim_lsp = "[]",
                  nvim_lua = "[]",
                  path = "[]",
                  copilot = "[]",
                  treesitter = "[]",
                  spell = "[󰓆]",
                },
              }),
            },
            mapping = cmp.mapping.preset.insert {
              ["<C-d>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete({}),
              ["<CR>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              },
              ["<C-e>"] = cmp.mapping(function(_)
                if cmp.visible() then
                  cmp.abort()
                else
                  cmp.complete()
                end
              end),
              ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" }),
              ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" }),
            },
            sources = cmp.config.sources({
              { name = "nvim_lsp", priority = 1, group_index = 1 },
              { name = "copilot", priority = 2, group_index = 1 },
              { name = "luasnip", keyword_length = 2 , group_index = 2  },
              { name = "treesitter", group_index = 2 },
              { name = "spell", group_index = 2, option = {
                keep_all_entries = false,
                enable_in_context = function()
                    return true
                end,
                preselect_correct_word = true,
              }},
              { name = "path", group_index = 2  },
            }, {
              { name = "buffer", group_index = 1, keyword_length = 3 },
            }),

            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
          }, opts)
        end
      '';
    }
  ];
  config.extraPackages = with pkgs; [
    nodePackages_latest.bash-language-server
    nodePackages_latest.typescript-language-server
    nodePackages_latest.svelte-language-server
    nodePackages_latest.svelte-check
    vimPlugins.nvim-treesitter-parsers.svelte
    rust-analyzer
    gopls
    tailwindcss-language-server
    vscode-langservers-extracted
    pyright
    ruff-lsp
    lua-language-server
    taplo
    yaml-language-server
    marksman
    typst-lsp
    nixd
  ];
  config.extraConfigLua = lua ''
    do
      -- diagnostic
      local sign = function(opts)
        if type(opts.text) ~= "string" then
          return
        end

        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = "",
        })
      end

      sign({ name = "DiagnosticSignError", text = "✘" })
      sign({ name = "DiagnosticSignWarn", text = "▲" })
      sign({ name = "DiagnosticSignHint", text = "⚑" })
      sign({ name = "DiagnosticSignInfo", text = "" })
      vim.diagnostic.config({
        -- Enable warnings inline.
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Diagnostic keymaps
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float)
      vim.keymap.set("n", "<leader>gL", vim.diagnostic.setloclist)
    end
  '';
  config.autoGroups.lspConfig = { };
  config.autoCmd = [
    {
      group = "lspConfig";
      event = "LspAttach";
      pattern = "*";
      callback.__raw =
        let
          rawMapping = desc: key: fn: ''
            vim.keymap.set("n", "${key}", ${fn}, { buffer = bufnr, desc = "${desc}" }) 
          '';
          mapping = desc: key: cmd: (rawMapping desc key "vim.lsp.buf.${cmd}");
        in
        lua ''
          function(opts)
            local bufnr = opts.buf
            local client = vim.lsp.get_client_by_id(opts.data.client_id)

            if client.server_capabilities["documentSymbolProvider"] then
              require("nvim-navic").attach(client, bufnr)
            end

            -- TODO(pope): Enable this.
            -- -- Enable inlay hints if supported
            -- local capabilities = client.server_capabilities
            -- if capabilities.inlayHintProvider then
            --   vim.lsp.inlay_hint.enable(bufnr, true)
            -- end
            -- -- Some Lsp servers do not advertise inlay hints properly so enable this keybinding regardless
            -- ${rawMapping "Hints toggle" "<leader>ht" (lua ''
            --   function()
            --     vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
            --   end
            -- '')}

            -- Enable completion triggered by <c-x><c-o>
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

            -- Add mappings
            ${mapping "Rename" "<leader>rn" "rename"}
            ${mapping "Code Action" "<leader>ca" "code_action"}

            ${mapping "Goto Definition" "gd" "definition"}
            ${mapping "Goto Declaration" "gD" "declaration"}
            ${mapping "Goto Implementation" "gi" "implementation"}
            ${mapping "Goto Type Definition" "gtd" "type_definition"}
            ${mapping "Goto References" "gr" "references"}

            ${mapping "Hover Documentation" "K" "hover"}
            ${mapping "Signature Documentation" "<C-k>" "signature_help"}

            ${mapping "Workspace Add Folder" "<leader>wa" "add_workspace_folder"}
            ${mapping "Workspace Remove Folder" "<leader>wr" "remove_workspace_folder"}
            ${rawMapping "Workspace list folders" "<leader>wl" (lua ''
              function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end
            '')}

            ${mapping "Format" "<leader>ff" "format"}

            ${rawMapping "Format and Save" "<leader>fF" (lua ''
              function()
                vim.lsp.buf.format()
                vim.api.nvim_command("write")
              end
            '')}
          end
        '';
    }
  ];
}

