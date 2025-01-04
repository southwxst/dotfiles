-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.clipboard = "unnamedplus"
vim.opt.guifont = "JetBrainsMono Nerd Font:h12" -- フォント名とサイズ
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "shift-jis", "euc-jp" }
-- Neo-treeのデフォルト設定を読み込む
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
-- 'modifiable' オプションをオンにする
vim.o.modifiable = true
-- キーマッピングを設定
-- 例: `Ctrl+e` でファイルツリーを開く
vim.api.nvim_set_keymap("n", "<C-e>", ":Neotree toggle<CR>", { noremap = true, silent = true })
