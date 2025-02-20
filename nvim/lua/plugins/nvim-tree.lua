return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          icons = {
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_closed = "",
                arrow_open = "",
              },
            },
          },
        },
      })
      -- Keymap to toggle NvimTree
      vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>a", ":NvimTreeOpen<CR>", { noremap = true, silent = true })
    end,
  },
}
