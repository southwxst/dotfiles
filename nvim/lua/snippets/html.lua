-- ~/.config/nvim/lua/snippets/html.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("div", { t("<div></div>") }),
  s("html5", { t("<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<meta charset=\"UTF-8\">\n<title>Title</title>\n</head>\n<body>\n\n</body>\n</html>") }),
}
