return {
  "gelguy/wilder.nvim",
  event = "CmdlineEnter",
  config = function()
    local wilder = require("wilder")

    wilder.setup({ modes = { ":", "/", "?" } })

    -- パイプライン設定（デフォルトのリスト補完を有効化）
    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline(), -- コマンドライン用補完
        wilder.search_pipeline() -- 検索用補完
      ),
    })

    -- 画面表示のカスタマイズ
    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        highlights = {
          border = "Normal",
        },
        border = "rounded",
      }))
    )
  end,
}
