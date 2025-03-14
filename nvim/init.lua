vim.cmd [[packadd packer.nvim]]
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright",  "clangd" }, -- 必要な LSP をインストール
  automatic_installation = true, -- 自動インストール
})
vim.keymap.set("n", "yy", '"+yy', { noremap = true, silent = true })
vim.keymap.set("v", "y", '"+y', { noremap = true, silent = true })

require("nvim-tree").setup()
require'lspconfig'.pyright.setup{}
vim.opt.termguicolors = true
require("bufferline").setup{}
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- packer自体を管理
    use {"kraftwerk28/gtranslate.nvim", requires = {"nvim-lua/plenary.nvim"}}
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'neovim/nvim-lspconfig' -- 例: LSP
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'nvim-treesitter/nvim-treesitter' -- 例: Treesitter
    use 'vimwiki/vimwiki' -- VimWiki
    use {'iamcco/markdown-preview.nvim'}
    use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }
    use({
  "rareitems/anki.nvim",
  config = function()
    require("anki").setup({
      -- this function will add support for associating '.anki' extension with both 'anki' and 'tex' filetype.
      tex_support = false,
      models = {
        -- Here you specify which notetype should be associated with which deck
        NoteType = "PathToDeck",
        ["Basic"] = "Deck",
        ["Super Basic"] = "Deck::ChildDeck",
      },
      -- linters = require("anki.linters").default_linters();
    })
  end,
})
    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end
    }
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
    }
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
    'gelguy/wilder.nvim',
    config = function()
        local wilder = require('wilder')
        wilder.setup({ modes = { ':' } })
        wilder.set_option('pipeline', wilder.cmdline_pipeline())
        wilder.set_option('renderer', wilder.popupmenu_renderer())
    end,
}
       use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
end)

require('lualine').setup {
    -- (既存の lualine 設定はそのまま)
}
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mason でインストールされた LSP を有効化
require("mason-lspconfig").setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end,
})

-- nvim-cmp の設定
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- LuaSnip を使用
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
    { name = 'nvim_lsp' }, -- LSP からの補完
    { name = 'buffer' },   -- バッファ内の単語補完
    { name = 'path' },     -- ファイルパス補完
  })
})

vim.cmd.colorscheme "gruvbox"
vim.g.mapleader = " " -- Leader キーをスペースに設定

-- `nvim-tree` を開閉するキーバインド
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>', { desc = 'Refresh NvimTree' })
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>', { desc = 'Find file in NvimTree' })
vim.keymap.set('n', '<leader>a', ':NvimTreeOldFile<CR>', { desc = 'Open Old file in NvimTree' })
local builtin = require('telescope.builtin')
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope old files' })


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

vim.api.nvim_set_keymap("n", "<leader>ttj", ":Translate  ja<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ttj", ":Translate  ja<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tte", ":Translate  en<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>tte", ":Translate  en<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ttf", ":Translate  fr<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ttf", ":Translate  fr<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ttk", ":Translate  Korean<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ttk", ":Translate  Korean<CR>", { noremap = true, silent = true })

-- ChatGPT command
vim.api.nvim_create_user_command("ChatGPT", function()
  vim.fn.system("xdg-open https://chatgpt.com/")
end, { desc = "Open ChatGPT in browser" })
vim.api.nvim_set_keymap(
  "n",
  "<leader>cg",
  ":silent !xdg-open https://chatgpt.com/<CR>",
  { noremap = true, silent = true }
)

-- Spotifiy commands
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
-- Translate

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
vim.api.nvim_set_keymap("n", "<C-n>", ":!python3 %<CR>", { noremap = true, silent = true })


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

vim.api.nvim_set_keymap("n", "<leader>ttj", ":Translate  ja<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ttj", ":Translate  ja<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tte", ":Translate  en<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>tte", ":Translate  en<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ttf", ":Translate  fr<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ttf", ":Translate  fr<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ttk", ":Translate  Korean<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ttk", ":Translate  Korean<CR>", { noremap = true, silent = true })

-- ChatGPT command
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
vim.opt.spell = false
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal nospell",
})

-- Spotifiy commands
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
-- Translate

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
-- Markdown のやつ
vim.keymap.set(
  "n",
  "<leader>ma",
  "i[]()<Esc>ha",
  { noremap = true, silent = true, desc = "Insert []() and move inside" }
)
