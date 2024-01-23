return {
  -- so much it can do...
  -- https://github.com/junegunn/vim-easy-align
  "junegunn/vim-easy-align",
  -- event = "VeryLazy",
  cmd = { "EasyAlign", "LiveEasyAlign"},
  config = function()
    km( {"n", "v", "x"}, "ga", "<Plug>(EasyAlign)")
    km( {"n", "v", "x"}, "<leader>al", "<Plug>(LiveEasyAlign)")
    km( {"n", "v", "x"}, "<leader>a=", ":EasyAlign *=<CR>")
    km( {"n", "v", "x"}, "<leader>a:", ":EasyAlign *:<CR>")
    km( {"n", "v", "x"}, "<leader>a,", ":EasyAlign *,<CR>")

    vim.g.easy_align_ignore_groups = { 'Comment' }
  end,
}
