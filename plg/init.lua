-- Pre-Packing {{{
-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

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

-- vim.cmd [[
--   augroup Packer
--     autocmd!
--     " autocmd BufWritePost init.lua PackerCompile
--     autocmd BufWritePost init.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
--
-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

local use = require('packer').use

-- END Pre-Packing }}}
require('packer').startup(function()
  use "wbthomason/packer.nvim"       -- Go Packer Yourself

  -- Syntax & Language Supports {{{
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-treesitter/nvim-treesitter-textobjects"

  use "neovim/nvim-lspconfig"           -- enable LSP
  use "williamboman/nvim-lsp-installer" -- language server installer
  use "tamago324/nlsp-settings.nvim"    -- defined in plg/lsp/settings/jsonls.lua
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- probably smarter to just make the gutter bigger...
  -- use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  -- use '2072/PHP-Indenting-for-VIm'
  use 'captbaritone/better-indent-support-for-php-with-html'
  -- use 'StanAngeloff/php.vim'


  -- END Syntax & Language Supports }}}


  -- Navigation, Finding, & Getting Around {{{
  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use {"nvim-telescope/telescope-fzf-native.nvim", run = 'make' }
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', }, }
  use 'rlane/pounce.nvim'  -- get almost anywhere in 3-4 keystrokes
  -- END Navigation, Finding, & Getting Around }}}


  -- AutoMagic Texts {{{
  -- cmp hrsh7th plugins {{{
  use "hrsh7th/nvim-cmp"             -- The completion plugin
  use "hrsh7th/cmp-nvim-lsp"         -- Language Server
  use "hrsh7th/cmp-nvim-lua"         -- lua completions
  use "hrsh7th/cmp-buffer"           -- buffer completions
  use "hrsh7th/cmp-path"             -- path completions
  use "hrsh7th/cmp-cmdline"          -- cmdline completions
  use "hrsh7th/cmp-omni"             -- omni completions
  -- }}}

  -- snippets {{{
  -- -- For LuaSnip
  use "L3MON4D3/LuaSnip"             -- snippet engine
  use "saadparwaiz1/cmp_luasnip"     -- snippet completions

  -- -- For ultisnips
  -- use "SirVer/ultisnips"
  -- use { "quangnguyen30192/cmp-nvim-ultisnips",
  --   requires = {"nvim-treesitter/nvim-treesitter" },
  -- }

  use "rafamadriz/friendly-snippets" -- some pre-made snippets
  use "mattn/emmet-vim"              -- Emmet "magic" html coding
  -- }}}

  -- editing {{{
  -- use "blackCauldron7/surround.nvim" -- Surround text with quotes and brackets
  use "tpope/vim-surround"           -- Surround text with quotes and brackets AND TAGS
  use "numToStr/Comment.nvim"        -- Quickly add and remove comments
  use "junegunn/vim-easy-align"      -- Make stuff look good by lining up
  -- }}}

  -- other interesting libraries: {{{
  -- https://github.com/uga-rosa/cmp-dictionary
  -- https://github.com/f3fora/cmp-spell
  -- https://github.com/hrsh7th/cmp-emoji
  -- https://github.com/hrsh7th/cmp-omni -- manage vim's ommicompletions
  -- https://github.com/vappolinario/cmp-clippy -- opensource co-pilot?
  -- }}}
  -- END AutoMagic Texts }}}


  -- Nice-Pretty-Fluff {{{
  use "kyazdani42/nvim-web-devicons" -- icons for looking cool, but YOU still don't

  -- nice, noticable actionable notes
  use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim", }

  use "norcalli/nvim-colorizer.lua" -- makes hex and rgb codes show their true colours

  -- Makes tags work better for html in particular...may not be required in lua-nvim?
  use "andymass/vim-matchup"

  -- colourschemes: {{{
  use "mjlbach/onedark.nvim"
  use "marko-cerovac/material.nvim"
  -- use "folke/tokyonight.nvim"
  use "tiagovla/tokyodark.nvim"
  use "sainnhe/edge"
  use "savq/melange"
  use 'dikiaap/minimalist'
  -- }}}
  --END Nice-Pretty-Fluff}}}


  -- Crutches {{{
  use 'irrationalistic/vim-tasks'
  --{{{
  -- https://github.com/irrationalistic/vim-tasks
  -- h Tasks
  -- <leader>n Add a new task below the current line
  -- <leader>N Add a new task above the current line
  -- <leader>d Complete the current task(s)
  -- <leader>x Cancel the current task(s)
  -- <leader>a Update/build the archives
  --}}}

  use "folke/which-key.nvim" -- pop-up menu for commands etc

  -- find/replace thingy
  use { "windwp/nvim-spectre", requires = "nvim-lua/plenary.nvim", }

  use {
    -- https://github.com/sudormrfbin/cheatsheet.nvim
    "sudormrfbin/cheatsheet.nvim",
    requires = {
      {"nvim-telescope/telescope.nvim"},
      {"nvim-lua/popup.nvim"},
      {"nvim-lua/plenary.nvim"},
    },
  }
  -- END Crutches }}}


  --[[ {{{
  LOOKS INTERESTING:
  https://github.com/lazytanuki/nvim-mapper
  -- }}} ]]

  -- if PACKER_BOOTSTRAP then
  --   require("packer").sync()
  -- end

end)

-- Configur Plugins: {{{
require 'plg.autocomplete'
require 'plg.colorizer'
require 'plg.comment'
require 'plg.emmet'
require 'plg.lsp'
require 'plg.nvim-tree'
require 'plg.pounce'
require 'plg.spectre'
require 'plg.telescope'
require 'plg.todo-comments'
require 'plg.vim-matchup'
require 'plg.whichkey'
-- }}}

-- vim: ts=2 sts=2 sw=2
