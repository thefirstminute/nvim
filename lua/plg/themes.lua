return {
  'RRethy/nvim-base16',
  'xiyaowong/transparent.nvim',
  'folke/tokyonight.nvim',
  config = function()
    -- vim.opt.runtimepath:prepend("~/Documents/vims/colourskeems/")
    vim.cmd([[
    set runtimepath+=~/Documents/vims/colourskeems
    ]])
    -- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    vim.cmd('colorscheme minimalist')
  end
}

