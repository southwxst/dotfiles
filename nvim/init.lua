require("config.lazy") -- nvim-tree をトグルするショートカットを追加
require("lspconfig").pyright.setup({})
-- nvim-tree でファイルを見つけるショートカットを追加
--
vim.api.nvim_set_keymap("n", "<C-e>", ":Neotree toggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-n>", ":!python3 %<CR>", { noremap = true, silent = true })
