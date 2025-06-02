vim.g.mapleader = " " -- Leader key set to space
local keymap = vim.keymap
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
--vim.keymap.set("i", "<D-k>", function() print("CMD-j pressed") end)
vim.keymap.set("n", "<leader>n", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>p", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "yy", '"+yy', { noremap = true, silent = true })
vim.keymap.set("n", "p", '"+p', { noremap = true, silent = true })
vim.keymap.set("v", "p", '"+p', { noremap = true, silent = true })
vim.keymap.set("v", "y", '"+y', { noremap = true, silent = true })
vim.keymap.set("v", "yw", '"+yw', { noremap = true, silent = true })
--toggleterm
vim.keymap.set("n", "<leader><CR>", ":ToggleTerm<CR>", { noremap = true, silent = true, desc = "Toggle Terminal" })
vim.keymap.set("v", "<leader><CR>", ":ToggleTerm<CR>", { noremap = true, silent = true, desc = "Toggle Terminal" })
--prettier
vim.keymap.set("n", "<leader>cp", ":Prettier<CR>", { noremap = true, silent = true, desc = "Prettier command" })

vim.keymap.set("n", "<Leader>d", 'dd', { noremap = true, silent = true })
vim.keymap.set("v", "<Leader>d", 'd', { noremap = true, silent = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })
vim.keymap.set("v", "d", '"_d', { noremap = true, silent = true })
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR><Esc>', { noremap = true, silent = true })
-- NvimTree key bindings
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>', { desc = 'Refresh NvimTree' })
vim.keymap.set('n', '<leader>a', ':NvimTreeFindFile<CR>', { desc = 'Find file in NvimTree' })
local builtin = require('telescope.builtin')
-- Markdown preview
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
vim.keymap.set("n", "<leader>lb", "<cmd>LiveServerToggle<CR>", { desc = "Live Server Toggle" })
vim.keymap.set("n", "<leader>an", "<cmd>Anki<CR>", { desc = "Open Anki" })
-- window management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
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
-- telescope 

local actions = require('telescope.actions')
local telescope = require('telescope')

