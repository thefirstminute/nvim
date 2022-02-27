-- Notes {{{2
  -- normal_mode = "n",
  -- insert_mode = "i",
  -- visual_mode = "v",
  -- visual_block_mode = "x",
  -- term_mode = "t",
  -- command_mode = "c",

-- FUNCS {{{2
local function set_keymap(mode, opts, keymaps)
  for _, keymap in ipairs(keymaps) do
    vim.api.nvim_set_keymap(mode, keymap[1], keymap[2], opts)
  end
end

-- HACKS {{{2
-- for your Copy & Paste
vim.cmd[[set pastetoggle=<F10>]]
-- stop space from moving you around
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", {noremap=true, silent=true})

-- copy paste:
-- vim.api.nvim_set_keymap("", "<c-c>", '"*y :let @+=@*<CR>', {noremap=true, silent=true})
-- vim.api.nvim_set_keymap("", "<c-v>", '"+P', {noremap=true, silent=true})

-- <Tab> to navigate the completion menu
-- vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
-- vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

-- LEADER {{{2
vim.g.mapleader = ' '
vim.g.MODE = ' '

-- NORMAL MODE KEYMAPS {{{1
local n_maps = {
  -- Escape clears highlights {{{2
  {"<Esc>", "<Esc>:noh<CR>"},

  -- don't move around with space {{{2
  {"<Space>", "<Nop>"},
  {" ", "<Nop>"},

  -- Change The Vimdamentals {{{2
  -- Visual Block Is Better {{{3
  {'v', '<c-v>'},
  {'gV', 'v'},
  -- "Ho-Lee-Just-Kidding" {{{3
  { "J", "<PageDown>2kzz" },
  { "K", "<PageUp>2jzz" },
  {"<Leader>j","mzJ`z"},
  {"<Leader>k","K"},
  {"H", "^"},
  {"L", "$"},
  {"gt","H"},
  {"gb","L"},

  -- execute q macro {{{2
  {'Q', '@q'},
  -- don't lose ex mode
  {"<Leader>x","m Q"},

  -- RSI-CTRL{{{2
  {'<Leader>w', '<c-w>'},
  {"U", "<C-r>",},
  {"<Leader>;", ":"},

  -- Copy & Paste {{{3
  {"vv", '"+P'},
  {'gP', '"+p'},
  {'gy', '"+y'},
  {'gY', '"+y$'},


  -- Resize split {{{2
  {'<S-Up>',    '<cmd>resize +2<CR>'},
  {'<S-Down>',  '<cmd>resize -2<CR>'},
  {'<S-Left>',  '<cmd>vertical resize -2<CR>'},
  {'<S-Right>', '<cmd>vertical resize +2<CR>'},

  -- Quickfix {{{2
  {'<C-Up>',    ':copen<CR>'},
  {'<C-Down>',  ':cclose<CR>'},
  {'<C-Left>',  ':cprevious<CR>'},
  {'<C-Right>', ':cnext<CR>'},

  -- fix spelling with first suggestion {{{2
  {'gs', 'z=1<CR><CR>'},


  -- Escape clears highlights {{{2
  {"<Esc>", "<Esc>:noh<CR>"},


  -- fix so registers don't get rekd by p {{{2
  {"c", '"xc'},
  {"C", '"xC'},
  {"x", '"xx'},
  {"X", '"xX'},


  -- navigation...quit, close, save, open {{{2
  {"<Leader>qq", "<cmd>qall!<CR>"},
  {"<Leader>ee", "<cmd>bd!<CR>"},
  {"<A-j>", "<cmd>bnext<CR>"},
  {"<A-k>", "<cmd>bprevious<CR>"},
  {"<A-l>", "<cmd>tabnext<CR>"},
  {"<A-h>", "<cmd>tabprevious<CR>"},

  -- Marks and Jumps {{{2
  -- when jumping to next find, center on screen {{{3
  {"N", "Nzz"},
  {"n", "nzz"},

  -- quickly go to [M]ark - also swap 'for` {{{2
  {'M', "`mzz"},
  {'gm', "M"},
  {"'", "`"},
  {'`', "'"},

  -- mark spot before different jumps {{{3
  {"G", "mgG"},
  {"gg", "mggg"},
  {"/", "ms/"},
  {"?", "ms?"},
  {"*", "ms*"},
  {"#", "ms#"},

  -- Editing: {{{2
  -- Change In/Around..: {{{3
  -- doing in onoremap
  -- {"ci<", "?><CR>lvt<c"},
  -- {"ca<", "?<<CR>vf>;c"},

  -- fix so registers don't get rekd {{{3
  {"X", '"_X'},
  {"x", '"_x'},
  {"C", '"_C'},
  {"c", '"_c'},
  -- Indenting: {{{3
  {">", "m`>>``ll"},
  {"<", "m`<<``hh"},
  {"ga", ":LiveEasyAlign<CR>"},

  -- Insert space(s) up/down/surround {{{3
  {"gk", "m`O<Esc>``"},
  {"gj", "m`o<Esc>``"},
  {"gs", "m`O<Esc>``o<Esc>``"},
  {"gh", "i <Esc>l"},
  {"gl", "a <Esc>h"},

  -- Select inside Tag (vim always grabs extra)
  {"viT", "vitB$oW0"},

}

-- SET NORMAL KEYMAPS {{{1
set_keymap('n', {noremap=true, silent=true}, n_maps)

-- VISUAL MODE {{{1
local v_maps = {
  -- Escape clears highlights {{{2
  {"<Esc>", "<Esc>:noh<CR>"},

  -- repeat dot {{{2
  -- {'.', '<Cmd>normal .<CR>'},

  -- "Ho-Lee-Just-Kidding" {{{2
  {"H", "^"},
  {"L", "$"},
  {"gt","H"},
  {"gb","L"},
  {"J", "<PageDown>2kzz"},
  {"K", "<PageUp>2jzz"},
  {"<Leader>j","J"},
  {"<Leader>k","K"},

  -- Quick Macros: {{{2
  {"Q", ":norm @q<CR>"},


  -- * & # search as I would expect {{{2
  {'*', 'y/<C-r>"<CR>'},
  {'#', 'y?<C-r>"<CR>'},

  -- Editing: {{{2
  -- Copy & Paste {{{3
  -- yank to system clipboard
  {"gy", '"*y :let @+=@*<CR>'},
  {"gp", '"+P'},
  {"vv", '"+P'},
  -- {"<C-c>", '"*y :let @+=@*<CR>:echo "a vim noob just copied something"<CR>gv'},
  -- {"<C-v>", '"+P'},

  -- move selected line(s) {{{3
  {"<C-K>", ':move \'<-2<CR>gv-gv'},
  {"<C-J>", ':move \'>+1<CR>gv-gv'},


  -- fix so registers don't get rekd {{{3
  {"X", '"_X'},
  {"x", '"_x'},
  {"C", '"_C'},
  {"c", '"_c'},
  {"p", '"_dP'},


  -- Indenting: {{{3
  {"=", "=gv"},
  {"<", "<gv"},
  {">", ">gv"},
  {"ga", ":LiveEasyAlign<CR>"},


  -- Marks and Jumps {{{2
  -- when jumping to next find, center on screen {{{3
  {"N", "Nzz"},
  {"n", "nzz"},

  -- quickly go to [M]ark - also swap 'for` {{{2
  {'M', "`mzz"},
  {'gm', "M"},
  {"'", "`"},
  {'`', "'"},
  -- mark spot before different jumps {{{3
  {"G", "mgG"},
  {"gg", "mggg"},
  {"/", "ms/"},
  {"?", "ms?"},
  {"*", "ms*"},
  {"#", "ms#"},

}
-- Set Visual Keymaps {{{1
set_keymap('v', {noremap=true, silent=true}, v_maps)

-- INSERT MODE {{{1
set_keymap('i', {noremap=true, silent=true}, {
  -- esc {{{2
  {';i', '<Esc>'},
  {';I', '<Esc>'},
  {"<Esc>", "<Esc>:noh<CR>"},

  -- Copy & Paste: {{{2
  -- {"<c-v>","<F10><c-r>+<F10>"},

  -- Quick Omni's: {{{2
  {'qo', '<C-X><C-O>'},
  {'qi', '<C-X><C-I>'},
  {'qp', '<C-X><C-P>'},
  {'qn', '<C-X><C-N>'},

})

-- TERMINAL {{{1
set_keymap('t', {noremap=true, silent=true}, {
  -- escape in terminal
  {'<Esc>', [[<C-\><C-n>]]},
  {';i', '<Esc>'},

})

