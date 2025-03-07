return {
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = true,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    config = function()
      require("render-markdown").setup({
        -- You can add your configurations here
        -- For example:
        -- theme = "dark",
      })
    end,
  },
}
