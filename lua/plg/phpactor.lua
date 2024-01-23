-- https://github.com/gbprod/phpactor.nvim
return {
  "gbprod/phpactor.nvim",
  run = require("phpactor.handler.update"), -- To install/update phpactor when installing this plugin
  ft = "php",
  requires = {
    "nvim-lua/plenary.nvim", -- required to update phpactor
    "neovim/nvim-lspconfig" -- required to automaticly register lsp serveur
  },
  config = function()
    require("phpactor").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })
  end
}
