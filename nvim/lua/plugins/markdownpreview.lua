return {
  -- Other plugins ...
  {
    "preservim/vim-markdown", -- Popular Markdown plugin
    ft = { "markdown" }, -- Load only for Markdown files
    config = function()
      -- Optional configurations
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_frontmatter = 1
    end,
  },
  -- Optionally, add Markdown preview plugin
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 1 -- Auto start preview on file open
    end,
  },
}
