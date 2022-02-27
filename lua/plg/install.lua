-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost install.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Not Packing!")
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "kyazdani42/nvim-web-devicons"
  use "nvim-lualine/lualine.nvim"
  use "folke/which-key.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "mattn/emmet-vim"              -- Emmet "magic" html coding
  -- use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Language
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use 'captbaritone/better-indent-support-for-php-with-html'

  -- Navigating, Finding, & Getting Around {{{
  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use {"nvim-telescope/telescope-fzf-native.nvim", run = 'make' }
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', }, }
  use 'rlane/pounce.nvim'  -- get almost anywhere in 3-4 keystrokes
  -- END Navigation, Finding, & Getting Around }}}


  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "nvim-treesitter/nvim-treesitter-textobjects"


  -- Git: {{{
  use 'tpope/vim-fugitive'    -- Git commands in nvim
  use 'tpope/vim-rhubarb'     -- Fugitive-companion to interact with github
  use 'kdheepak/lazygit.nvim' -- Use LazyGit inside vim
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- }}}



  -- FluffyBloat
  use "tpope/vim-surround"           -- Surround text with quotes and brackets AND TAGS
  use 'tomtom/tcomment_vim' -- Best commenting, works with multi-language files!
  use "junegunn/vim-easy-align"      -- Make stuff look good by lining up
  use "norcalli/nvim-colorizer.lua" -- makes hex and rgb codes show their true colours
  use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim", }
  use { "windwp/nvim-spectre", requires = "nvim-lua/plenary.nvim", }

  -- Makes tags work better for html in particular...may not be required in lua-nvim?
  use "andymass/vim-matchup"
  -- https://github.com/aserebryakov/vim-todo-lists#commands
  use 'aserebryakov/vim-todo-lists'

  -- colourschemes: {{{
  use "lunarvim/colorschemes"
  use "lunarvim/darkplus.nvim"
  use "mjlbach/onedark.nvim"
  use "marko-cerovac/material.nvim"
  -- use "folke/tokyonight.nvim"
  use "tiagovla/tokyodark.nvim"
  use "sainnhe/edge"
  use "savq/melange"
  use 'dikiaap/minimalist'
  -- }}}




  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
