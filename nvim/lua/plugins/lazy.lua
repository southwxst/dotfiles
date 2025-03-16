-- Set up Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options
vim.g.mapleader = " " -- Leader key set to space
vim.opt.termguicolors = true
vim.opt.spell = false

-- Plugin specification
require("lazy").setup({
  -- Appearance
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Make sure colorscheme loads first
    config = function()
      vim.cmd.colorscheme "gruvbox"
    end,
  },
{
  "github/copilot.vim",
  lazy=false,
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
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup{}
    end
  },
  
  -- LSP and completion
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "clangd" },
        automatic_installation = true,
      })
      
      -- Set up LSP handlers
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
      })
      
      -- Specific LSP configurations
      require('lspconfig').pyright.setup{}
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  },
  
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup()
    end
  },
  
  -- Telescope (fuzzy finder)
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope old files' })
    end
  },
  
  -- Which-key (key binding helper)
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  },
  
  -- Wilder (enhanced command-line)
  {
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':' } })
      wilder.set_option('pipeline', wilder.cmdline_pipeline())
      wilder.set_option('renderer', wilder.popupmenu_renderer())
    end,
  },
  
  -- TreeSitter (better syntax highlighting)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "python", "c", "cpp" },
        highlight = { enable = true },
      })
    end
  },
  
  -- Translation
  {
    "kraftwerk28/gtranslate.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Translation key bindings will be set up separately
    end
  },
  
  -- Markdown and wiki
  {
    'vimwiki/vimwiki',
  },
  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  
  -- Anki integration
  {
    "rareitems/anki.nvim",
    config = function()
      require("anki").setup({
        tex_support = false,
        models = {
          ["Basic"] = "Deck",
          ["Super Basic"] = "Deck::ChildDeck",
        },
      })
    end,
  },
})

-- Clipboard integration
vim.keymap.set("n", "yy", '"+yy', { noremap = true, silent = true })
vim.keymap.set("v", "y", '"+y', { noremap = true, silent = true })

-- NvimTree key bindings
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>', { desc = 'Refresh NvimTree' })
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>', { desc = 'Find file in NvimTree' })
vim.keymap.set('n', '<leader>a', ':NvimTreeOldFile<CR>', { desc = 'Open Old file in NvimTree' })

-- Spotify control
vim.api.nvim_set_keymap(
  "n",
  "<leader>sz",
  ":!playerctl --player=spotify previous<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sc",
  ":!playerctl --player=spotify play-pause<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>sx", ":!playerctl --player=spotify next<CR>", { noremap = true, silent = true })

-- Translation key bindings
vim.api.nvim_set_keymap("n", "<leader>ttj", ":Translate ja<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ttj", ":Translate ja<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tte", ":Translate en<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>tte", ":Translate en<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ttf", ":Translate fr<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ttf", ":Translate fr<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ttk", ":Translate Korean<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ttk", ":Translate Korean<CR>", { noremap = true, silent = true })

-- ChatGPT and Google Translate shortcuts
vim.api.nvim_create_user_command("ChatGPT", function()
  vim.fn.system("xdg-open https://chatgpt.com/")
end, { desc = "Open ChatGPT in browser" })
vim.api.nvim_set_keymap(
  "n",
  "<leader>cg",
  ":silent !xdg-open https://chatgpt.com/<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>gt",
  ":silent !xdg-open https://translate.google.com/<CR>",
  { noremap = true, silent = true }
)

-- Markdown settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal nospell",
})

vim.keymap.set(
  "n",
  "<leader>ma",
  "i[]()<Esc>ha",
  { noremap = true, silent = true, desc = "Insert []() and move inside" }
)

-- Run Python script
vim.api.nvim_set_keymap("n", "<C-n>", ":!python3 %<CR>", { noremap = true, silent = true })

-- Spotify commands
vim.api.nvim_create_user_command("SpotifyPrev", function()
  vim.fn.system("playerctl --player=spotify previous")
end, {})

vim.api.nvim_create_user_command("SpotifyNext", function()
  vim.fn.system("playerctl --player=spotify next")
end, {})

vim.api.nvim_create_user_command("SpotifyPlayPause", function()
  vim.fn.system("playerctl --player=spotify play-pause")
end, {})

vim.api.nvim_create_user_command("SpotifyStop", function()
  vim.fn.system("playerctl --player=spotify stop")
end, {})

vim.api.nvim_create_user_command("SpotifyStatus", function()
  local status = vim.fn.system("playerctl --player=spotify status")
  print("Spotify Status: " .. status)
end, {})

vim.api.nvim_create_user_command("SpotifySong", function()
  local song = vim.fn.system("playerctl --player=spotify metadata title")
  print("Now Playing: " .. song)
end, {})

-- Translate commands
vim.api.nvim_create_user_command("TranslateJapanese", function(opts)
  local query = table.concat(opts.fargs, " ")
  if query == "" then
    print("Usage: :Translate <text>")
    return
  end
  local output = vim.fn.system("trans :ja " .. vim.fn.shellescape(query))
  print(output)
end, { nargs = "+" })

vim.api.nvim_create_user_command("TranslateEnglish", function(opts)
  local query = table.concat(opts.fargs, " ")
  if query == "" then
    print("Usage: :Translate <text>")
    return
  end
  local output = vim.fn.system("trans :en " .. vim.fn.shellescape(query))
  print(output)
end, { nargs = "+" })

vim.api.nvim_create_user_command("TranslateKorean", function(opts)
  local query = table.concat(opts.fargs, " ")
  if query == "" then
    print("Usage: :Translate <text>")
    return
  end
  local output = vim.fn.system("trans :ko " .. vim.fn.shellescape(query))
  print(output)
end, { nargs = "+" })

vim.api.nvim_create_user_command("TranslateFrench", function(opts)
  local query = table.concat(opts.fargs, " ")
  if query == "" then
    print("Usage: :Translate <text>")
    return
  end
  local output = vim.fn.system("trans :fr " .. vim.fn.shellescape(query))
  print(output)
end, { nargs = "+" })
