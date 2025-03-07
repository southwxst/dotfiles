return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      -- add the config here
      themes = { "gruvbox", "onedark", "ayu", "tokyonight", "kanagawa" },
      livePreview = true, -- Apply theme while picking. Default to true.
    })
  end,
}
