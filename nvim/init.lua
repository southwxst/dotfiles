require("config.lazy")
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
vim.o.modifiable = true
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
vim.api.nvim_set_keymap("n", "<C-e>", ":Neotree toggle<CR>", { noremap = true, silent = true })
-- init.lua
local org = require("orgmode")

org.setup({
  org_agenda_files = { "~/org/todo.org" }, -- 必要なファイルパスが正しいことを確認
  org_default_notes_file = "~/path/to/default/capture/file.org", -- 必要なファイルパスが正しいことを確認
})
