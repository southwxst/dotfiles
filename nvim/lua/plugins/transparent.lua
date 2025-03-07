return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      extra_groups = { -- Extra groups to clear
        "NormalFloat", -- Floating windows
        "NvimTreeNormal", -- NvimTree background
      },
      exclude = {}, -- Groups to not clear
    })
  end,
}
