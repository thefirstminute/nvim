local set = vim.opt
vim.cmd 'filetype plugin on'
vim.cmd 'syntax on'
vim.cmd 'let g:do_filetype_lua = 1'

set.termguicolors = true  --needs to be set for colorizer
set.guifont = [[Hack\ Regular\ Nerd\ Font\ Complete]]

-- set.encoding = 'UTF-8'
set.updatetime = 300
set.number = true
set.numberwidth = 5
set.signcolumn = "yes"
set.relativenumber = true
set.wrap = false
set.mouse = 'a'
-- set.clipboard = 'unnamedplus'
set.foldmethod = 'marker'
set.undofile = true
set.swapfile = false

--Case insensitive searching UNLESS /C or capital in search:
set.ignorecase = true
set.smartcase = true

-- set tabs
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.smartindent = true
set.autoindent = true


set.scrolloff = 1
set.sidescrolloff = 7 -- leave space right of cursor!
set.splitright = true
set.splitbelow = true

-- BUG: Enter is still auto grabbing the first thing??!!
-- put this in lua/plg/autocomplete.lua
-- vim.cmd [[ set completeopt=menu,menuone,noselect ]]
-- set.completeopt = 'menu,menuone,noselect' -- FIX: still selecting first option!?!?
-- set.completeopt = {'menu','menuone','noselect' }
-- set.wildmode = {'longest:full', 'full'}
-- set.complete = {'.', 'w', 'b', 'u'} -- complete on...

-- Show some invisible characters
-- set.list = true
-- set.listchars = {tab = '| ', trail = ' '}

set.iskeyword:append('-')
set.nrformats:append('alpha') -- g <c-a> can increment letters now!
