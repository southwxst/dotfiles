-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.clipboard = "unnamedplus"
vim.opt.guifont = "JetBrainsMono Nerd Font:h12" -- フォント名とサイズ
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "shift-jis", "euc-jp" }
