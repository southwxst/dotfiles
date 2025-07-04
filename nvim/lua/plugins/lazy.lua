-- set up lazy.nvim
--
-- set up lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.wrap = false
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git ",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.number = true
vim.opt.fillchars:append({ eob = " " })
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  command = "silent! !ctags -R .",
})
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
{
  "zbirenbaum/copilot.lua",
  event = "InsertEnter", -- Insert時に読み込み
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
},
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "whoissethdaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- mason-lspconfigの設定を1か所で集中管理
      require("mason-lspconfig").setup({
        ensure_installed = {
          "html", "cssls", "tailwindcss", "svelte", "lua_ls", "graphql",
          "emmet_ls", "prismals", "pyright", "biome"
        },
        automatic_installation = true,
      })
    end,
    priority = 1000,
  },
  {
  "sphamba/smear-cursor.nvim",
enabled = false,
  opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim", -- 追加
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local keymap = vim.keymap

      -- キーバインド設定（省略）

      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- mason-lspconfigの新しいAPIを使用
      require("mason-lspconfig").setup({
        automatic_installation = true,
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
          ["svelte"] = function()
            lspconfig.svelte.setup({
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePost", {
                  pattern = { "*.js", "*.ts" },
                  callback = function(ctx)
                    client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                  end,
                })
              end,
            })
          end,
          ["graphql"] = function()
            lspconfig.graphql.setup({
              capabilities = capabilities,
              filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
            })
          end,
["html"] = function()
  lspconfig.html.setup({
    capabilities = capabilities,
    filetypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      },
      provideFormatter = true
    }
  })
end,
          ["emmet_ls"] = function()
            lspconfig.emmet_ls.setup({
              capabilities = capabilities,
              filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
            })
          end,
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                  completion = { callsnippet = "replace" },
                },
              },
            })
          end,
        },
      })
    end,
  },  -- その他のプラグイン設定（変更なし）
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "l3mon4d3/luasnip",
    config = function()
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" }
      })
    end,
  },

{
  "hrsh7th/nvim-cmp",
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    "saadparwaiz1/cmp_luasnip",
    "uga-rosa/cmp-dictionary",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Normal insert mode setup
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-a>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'copilot' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = "dictionary", keyword_length = 2 },
      }),
    })

    -- Cmdline mode for `:`
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })

    -- Cmdline mode for `/` and `?`
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      }
    })
  end,
},
{
  "zbirenbaum/copilot-cmp",
  dependencies = { "zbirenbaum/copilot.lua" },
  event = "InsertEnter",
  config = function()
    require("copilot_cmp").setup()
  end,
},
  -- 外観系プラグイン（変更なし）
  {
	  "ellisonleao/gruvbox.nvim",
    "vague2k/vague.nvim",
'navarasu/onedark.nvim',
      --"gmr458/vscode_modern_theme.nvim",
 --"bluz71/vim-moonfly-colors",
    priority = 1000,
    config = function()
     --vim.cmd.colorscheme "gruvbox"
      --vim.cmd.colorscheme "vague"
    --  vim.cmd.colorscheme "moonfly"
    end,
  },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    enabled = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup{}
    end
  },
  -- ファイルエクスプローラー（変更なし）
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup()
    end
  },
  -- その他のプラグイン（変更なし）
  {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
  },
},
{
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  },
  {
    'gelguy/wilder.nvim',
    enabled = false,
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':' } })
      wilder.set_option('pipeline', wilder.cmdline_pipeline())
      wilder.set_option('renderer', wilder.popupmenu_renderer())
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "python", "c", "cpp", "html", "javascript", "typescript", "css" },
        highlight = { enable = true },
      })
    end
  },
  {
    "kraftwerk28/gtranslate.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
    end
  },
  {
    "ngtuonghy/live-server-nvim",
    event = "VeryLazy",
    build = ":LiveServerInstall",
    config = function()
      require("live-server-nvim").setup({})
    end
  },
  {
  },
   {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end
  },
{
  "folke/noice.nvim",
enabled = false,
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
},
{
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
},
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/notes/',
        org_default_notes_file = '~/notes/refile.org',
      })
    end
  },
  {
    'vimwiki/vimwiki',
  },
{
	"MunifTanjim/prettier.nvim"
},
{
	"jose-elias-alvarez/null-ls.nvim"
},
{
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("todo-comments").setup()
        end,
},
{
   "m4xshen/hardtime.nvim",
   enabled =false,
   lazy = false,
   dependencies = { "MunifTanjim/nui.nvim" },
   opts = {},
},
  {
    'akinsho/toggleterm.nvim',
    version = '*', -- または 'v2.*' など特定のバージョンを指定
    cmd = 'ToggleTerm', -- ToggleTerm コマンドが実行されたときにプラグインをロード
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      direction = 'float', -- ここで 'float' を指定
      float_opts = {
        border = 'single', -- フローティングウィンドウの枠線を 'single' に設定
        -- border = 'double', -- あるいは 'double' に設定
        -- width = 80, -- フローティングウィンドウの幅（任意）
        -- height = 25, -- フローティングウィンドウの高さ（任意）
        -- winblend = 3, -- ウィンドウの透明度（任意）
        -- highlights = { -- ハイライトグループのカスタマイズ（任意）
        --     border = "Normal",
        --     background = "Normal",
        -- },
      },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = "cd app && npm install",
    lazy = false,
    config = function()
      vim.g.mkdp_auto_start = 1
    end
  },
{
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
  },
  lazy = false,
  config = function() 
    require('Comment').setup()
  end
},
{
    'xiyaowong/transparent.nvim',
  },

{
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({

 themes = {"gruvbox", "vague","onedark","iceberg" }, -- Your list of installed colorschemes.
  livePreview = true, -- Apply theme while picking. Default to true.
      })
    end
  },
  {
    'rolf-stargate/ankifly.nvim'
  },
  {
	  'oahlen/iceberg.nvim'
  },
  {'ThePrimeagen/harpoon'},
  {"mbbill/undotree"},
{ 'RayenMnif/tgpt.nvim',

},
  {
'rainbowhxch/accelerated-jk.nvim'
  }
})
