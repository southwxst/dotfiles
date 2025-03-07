require("config.lazy") -- nvim-tree をトグルするショートカットを追加
require("lspconfig").pyright.setup({})
-- nvim-tree でファイルを見つけるショートカットを追加
--

vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("n", "D", '"_D', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":!python3 %<CR>", { noremap = true, silent = true })
