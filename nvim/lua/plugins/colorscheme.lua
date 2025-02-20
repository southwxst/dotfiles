return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "darker", -- 他のスタイル: "darker", "cool", "deep", "warm"
      })
      require("onedark").load()
    end,
  },
}
