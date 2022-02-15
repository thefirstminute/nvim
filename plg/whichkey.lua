-- Safe Stopper: {{{
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  vim.notify("NO Which Key!!")
  return
end
--[[ NOTES:
Diagnostics...

]]
-- }}}

local n_maps = { -- {{{
  b = { name = 'Buffer', -- {{{
    b = {'<c-^>',    'Back'},
    c = {'<cmd>bd<CR>',        'Close buffer'},
    f = {'<cmd>bfirst<CR>',    'First buffer'},
    j = {"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", "Buffer Jump", },
    l = {'<cmd>blast<CR>',     'Last buffer'},
    n = {'<cmd>bnext<CR>',     'Next buffer'},
    p = {'<cmd>bprevious<CR>', 'Previous buffer'} ,
    S = {'<cmd>call ScratchMe()<CR>', 'new Scratch'} ,
    s = {"<cmd>ls<CR>:b<Space>", 'Search'},
    x = { "<cmd>xa!<CR>", "save all & quit" },
  }, -- }}}

  c = { name = 'Copy & Paste..', -- {{{
    f = {':let @" = expand("%p")<CR>', 'File with path'},
    p = {':let @" = expand("%:p")<CR>', 'Path'},
    d = {':let @" = expand("%:")<CR>', 'Directory'},

  }, -- }}}

  e = { name = 'edit..', -- {{{
    a = {'<cmd>LiveEasyAlign<CR>',         'easy Align'},
    s = {'<cmd>keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==<CR>',         'Split line'},
    j = {'mzJ`z',         'Join line'},
    p = {"<cmd>'[V']<CR>",         'select Pasted'},

    d = { name = 'Delete..', -- {{{
      b = {'<cmd>g/^$/d<CR>',                'Blank lines'},
      e = {'<cmd>%s/\\r//g<CR>',             'EOL characters'},
      h = {'<cmd>%s/<\\_.\\{-1,\\}>//g<CR>', 'HTML Tags'},
      j = {"<cmd>call YankDeleteUpDown('delete', 'down')<CR>", '"x" lines down'},
      k = {"<cmd>call YankDeleteUpDown('delete', 'up')<CR>",   '"x" lines up'},
      s = {'<cmd>%s/span[^\\>]*//<cr>:%s/<>//<cr>:%s/<\\/>//<cr>:%s/<\\/span>//g<cr>/span<cr><CR>', 'span tags'},
      S = {'<cmd>%sort u<CR>',               'Sort, remove duplicate lines'},
      t = {'<cmd>%s/\\s\\+$//e<CR>',         'Trailing whitespace'},
      T = {"<cmd>mq:norm %<CR>dd'qdd<CR>",   'This Tag'},
    }, -- }}}

    f = { name = 'Format..', -- {{{
      i = { name = 'Indent..',
        a = {'gg=G', 'Head'},
        h = {'/<head><CR>V100<<Esc>jV/<\\/head<CR>=', 'Head'},
        b = {'/<body<CR>V100<<Esc>jV/<\\/body<CR>=', 'Body'},
        t = {'vitB$oW0=', 'Tag'},
      },
      l = {':%s/>\\s*</>\\r</g<CR>gg=G',     'new Lines for each tag'},
      s = {'<cmd>sort /.\\{-}\\ze\\w/<CR>', 'Sort, ignoring symbols'},
      S = {'<cmd>%sort u<CR>',               'Sort, remove duplicate lines'},
      -- P = {'<cmd>Format<CR>',               'Format (prettier)'},
      ['_'] = { name = 'CamelSnake',
        c = {'<cmd>s/\\v_([a-z])/\\u\\1/g<CR>', 'snake_case 2 camelCase'},
        s = {'<cmd>s/\\v([a-z])([A-Z])/\\1_\\L\\2/g<CR>', 'camelCase 2 snake_case'},
      },
      ['<Tab>'] = { name = 'Tab|Spaces',
        ['2'] = {'<cmd>%s/\\t/  /g<CR>',        'tabs 2 spaces'},
        ['4'] = {'<cmd>%s/\\t/    /g<CR>',      'tabs 4 spaces'},
      },
    },
    -- END Format }}}

    r = { name = 'Replace..', -- {{{
      c = {"<cmd>mq:norm %<CR>dd'qdd<CR>",  'under Cursor'},
      l = {'<cmd>yiw:s/<C-r>"/<CR>',  'on Line'},

      C = {
        name = 'ConvertColor..',
        a = {'<cmd>ConvertColorTo rgba<CR>',  'convertcolorto rgbA'},
        r = {'<cmd>ConvertColorTo rgb<CR>',   'convertcolorto Rgb'},
        h = {'<cmd>ConvertColorTo hex<CR>',   'convertcolorto Hex'},
      },

      w = {"<cmd>viw:lua require('spectre').open_file_search().open_visual({select_word=true})<cr>",  'Word (spectre)'},
    }, -- END Replace }}}

    y = { name = "Yank..", -- {{{
      j = {"<cmd>call YankDeleteUpDown('yank', 'down')<CR>", '"x" lines down'},
      k = {"<cmd>call YankDeleteUpDown('yank', 'up')<CR>",   '"x" lines up'},

      c = {'"*y :let @+=@*<CR>',         'to Clipboard'},
    }, -- END yank }}}


  }, -- END edit }}}

  f = { name = "file..", -- {{{
    a = { "<cmd>wa!<CR>",            "save All" },
    b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", "Buffer list", },
    d = { "<cmd>lcd %:p:h<CR>",      "set path to current Directory" },
    c = { "<cmd>bd!<CR>",            "Close buffer" },
    e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    f = {"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>", "Find",},
    n = { "<cmd>enew<CR>",           "New" },
    s = { "<cmd>w!<CR>",             "Save" },
    S = { "<cmd>w !sudo tee %<CR>",  "Sudo Save" },
    q = { "<cmd>q!<CR>", "Quit - NO save!" },
    x = { "<cmd>xa!<CR>", "save all & quit" },

    t = { name = "type..", -- {{{
      c = { "<cmd>set ft=css<CR>",    "css" },
      h = { "<cmd>set ft=html<CR>",   "html" },
      H = { "<cmd>set ft=haskel<CR>", "haskel" },
      l = { "<cmd>set ft=lua<CR>",    "lua" },
      p = { "<cmd>set ft=php<CR>",    "php" },
      s = { "<cmd>set ft=sh<CR>",     "shell" },
      v = { "<cmd>set ft=vim<CR>",    "vim" },
      y = { "<cmd>set ft=py<CR>",     "python" },
    }, -- }}}
  }, -- }}}

  G = { name = "Git..", -- {{{
    b = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
    d = { "<cmd>Gitsigns diffthis HEAD<CR>", "Diff", },
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "next hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "prev hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo stage hunk", },
    t = { name = "Telescope",
      b = { "<cmd>Telescope git_branches<CR>", "checkout Branch" },
      c = { "<cmd>Telescope git_commits<CR>", "checkout Commit" },
      o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
    },
  }, -- }}}

  L = { name = "LSP..", -- {{{
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "code Action" },
    d = { "<cmd>Telescope lsp_document_diagnostics<CR>", "Document diagnostics", },
    w = { "<cmd>Telescope lsp_workspace_diagnostics<CR>", "Workspace diagnostics", },
    f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
    i = { "<cmd>LspInfo<CR>", "Info" },
    I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
    j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "next diagnostic", },
    k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "prev diagnostic", },
    l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "codeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<CR>", "document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "workspace Symbols", },
  }, -- }}}

  m = { name = "Marks..", -- {{{
    -- Placeholder Jumper:
    m = {"/<++><Enter>va<\"_c", "next Mark"},
    p = {"?<++><Enter>va<\"_c", "Previous mark"},
    r = {"/<++><Enter>.", "Repeat what you did on last mark"},
  }, -- }}}

  P = { name = "packer..", -- {{{
    c = { "<cmd>PackerCompile<CR>", "Compile" },
    i = { "<cmd>PackerInstall<CR>", "Install" },
    s = { "<cmd>PackerSync<CR>", "Sync" },
    S = { "<cmd>PackerStatus<CR>", "Status" },
    u = { "<cmd>PackerUpdate<CR>", "Update" },
  }, -- }}}

  s = { name = "Search..", -- {{{ TODO: CLEAN THIS UP!!
    -- b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Buffers", },
    c = { "yiw:execute 'vimgrep <C-r>\" **/*'<CR>:copen<CR>", "Copen",},
    C = { "yiw:vimgrepadd <C-r>\" % <bar> copen<CR>", "Copen Directory",},
    -- are ^^ these the same??
    o = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", "Open buffers", },
    F = { "<cmd>find <C-R>=expand('%:h').'/*'<CR>", "Find??",},
    -- f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>", "Find File",},
    k = { "<cmd>Telescope keymaps<CR>", "Keymaps",},
    K = { "<cmd>Telescope keymaps<CR>", "Keymaps",},
    m = { "<cmd>Telescope marks<CR>", "Marks",},
    T = { "<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>", "Tags", },
    w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "Word in open buffers", },
    W = { "<cmd>Telescope live_grep<CR>", "Word in project" },
    -- w = { "<cmd>lua require('telescope.builtin').grep_string()<CR>", "grep by Word",},
    p = { "<cmd>Telescope oldfiles<CR>", "Previously opened" },
    P = { "<cmd>lua require('telescope').extensions.projects.projects()<CR>", "Projects" },
    q = { "<cmd>execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>", "last search in Quickfix",},
    z = { "<cmd>Telescope <CR>", "fuZzy find in current",},
  }, -- }}}

  S = { name = "Snip..", -- {{{
  }, -- END Snip }}}

  t = { name = "Tab..", -- {{{
   n = {'<cmd>tabnew<CR>', 'New'},
   l = {'<cmd>tabnext<CR>', 'next'},
   h = {'<cmd>tabprevious<CR>', 'previous'},
   c = {'<cmd>tabClose<CR>', 'Close'},
  }, -- }}}

  T = { name = "Terminal..", -- {{{
    n = { "<cmd>lua _NODE_TOGGLE()<CR>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<CR>", "ncdU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<CR>", "hTop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<CR>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
  }, -- }}}

  v = { name = "vim..", -- {{{
    c = { "<cmd>Telescope commands<CR>", "Commands" },
    C = { "<cmd>call NoComment()<CR>", "no auto Comments!" },
    d = { "<cmd>:lcd %:p:h<CR>", "set working Directory here" },
    e = { "<cmd>NvimTreeToggle<CR>",     "Explorer" },
    f = {
      name = "set folds..",
      ['0'] = { "<cmd>set foldlevel=0<CR>",                      "level 0"},
      ['1'] = { "<cmd>set foldlevel=1<CR>",                      "level 1"},
      ['2'] = { "<cmd>set foldlevel=2<CR>",                      "level 2"},
      ['3'] = { "<cmd>set foldlevel=3<CR>",                      "level 3"},
      ['4'] = { "<cmd>set foldlevel=4<CR>",                      "level 4"},
        m   = { "<cmd>set foldmethod=manual<CR>",                "Manual"},
        k   = { "<cmd>set foldmethod=marker<CR>",                "marKer {{{"}, -- }}} fold HACK: <-
        i   = { "<cmd>set foldmethod=indent<CR>",                "Indent"},
        y   = { "<cmd>set foldmethod=syntax<CR>",                "sYntax"},
      ['{'] = { "<cmd>set foldmethod=marker foldmarker={,}<CR>", "marker {"},  -- }} fold HACK: <-
      ['('] = { "<cmd>set foldmethod=marker foldmarker=(,)<CR>", "marker ("},
      ['['] = { "<cmd>set foldmethod=marker foldmarker=[,]<CR>", "marker ["},
      ['<'] = { "<cmd>set foldmethod=marker foldmarker=<,><CR>", "marker <"},
    },
    F = { "<C-w>j:let &winheight = &lines * 7 / 10<CR><C-w>j:let &winwidth = &columns * 7 / 10<CR>", "Focus window" },
    H = {
      name = "help",
      h = { "<cmd>Telescope help_tags<CR>", "find Help" },
      m = { "<cmd>Telescope man_pages<CR>", "Man pages" },
    },
    k = { "<cmd>Telescope keymaps<CR>",   "Keymaps" },
    r = { "<cmd>Telescope registers<CR>", "Registers" },
    S = { "<cmd>source ~/.config/nvim/init.lua<CR>",     "Source vimrc" },
    s = {
      name = "Session..",
      s = { "<cmd>mksession! .sess.vim<CR><cmd>echo 'Session Saved'<CR>", "save Session" },
      l = { "<cmd>source .sess.vim<CR>",     "load Session" },
    },
    t = {
      name = "Theme..",
      h = { "<cmd>nohlsearch<CR>",            "no Highlight" },
      d = { "<cmd>set bg=dark<CR>",           "Dark" },
      l = { "<cmd>set bg=light<CR>",          "Light" },
      c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
      n = { "<cmd>set relativenumber!<CR>",   "relative Numbers" },
    },
    w = { "<cmd>MatchupWhereAmI<CR>", "Where am i (matchup)" },
    x = { "<cmd>exit<CR>",            "eXit" },
  }, -- }}}

} -- }}}

local v_maps = { -- {{{
  a = {'<cmd>LiveEasyAlign<CR>', 'easy Align'},
  c = { "y:execute 'vimgrep <C-r>\" **/*'<CR>:copen<CR>", "COpen",},
  C = { "y:vimgrepadd <C-r>\" % <bar> copen<CR>", "COpen Directory",},
  p = {'<cmd>"+P<CR>',       'Paste from clipboard'},
  y = {"<cmd>let @+=@*<CR>", 'Yank to clipboard'},
  ['{'] = {'<ESC>DA {<CR><C-r>"<CR>}<ESC>kva{=<ESC>',    "{ NL }"},

  f = { name = 'format..',
    ['_'] = { name = 'CamelSnake',
      c = {'<cmd>s/\\%V\\v_([a-z])/\\u\\1/g<CR>', 'snake_case 2 camelCase'},
      s = {'<cmd>s/\\%V\\v([a-z])([A-Z])/\\1_\\L\\2/g<CR>', 'camelCase 2 snake_case'},
    },
  },

  r = { name = 'replace..',
    l = {'<cmd>y:s/<C-r>"/<CR>',  'on Line'},
    c = {'<cmd>y:%s/<C-r>"/<CR>', 'Replace under cursor'},
    s = {"<cmd>viw:lua require('spectre').open_file_search().open_visual({select_word=true})<cr>",  'Spectre'},
  },

  x = { name = 'x', -- {{{
    a = {'<++>',    '<++>'},
    b = {'<++>',    '<++>'},
    c = {'<++>',    '<++>'},
  },
  -- }}}
} -- END v_maps }}}

local iQ_maps = { -- {{{

  f = {'<C-x><C-f>', 'File'},
  i = {'<C-x><C-i>', 'Included'},
  l = {'<C-x><C-l>', 'Line'},
  n = {'<C-n>',      'Next'},
  o = {'<C-x><C-o>', 'Omni'},
  p = {'<C-p>',      'Previous'},
  t = {'<C-x><C-]>', 'Tag'},

  Q = { name = 'QuickTxts..', -- {{{
    v = {'<++>',    '<++>'},
    b = {"='';",    "Blank ='';"},
    c = {'<++>',    '<++>'},
    d = {'<++>',    '<++>'},
    e = {'<++>',    '<++>'},
    f = {'<++>',    '<++>'},
    n = {"name = '',<left><left> ", "name = '',"},
    -- }}}
  },


  v = {'<C-r>"',    'Paste'},
  V = {'<C-r>0',    '2nd Last Paste'},

} -- END iQ_maps }}}

local iSlash_maps = { -- {{{
  d = { name = 'Double Quotes', -- {{{
    r = { name = 'Round ()',
      ["'"] = {'("")<left><left>',         '("")'},
      [','] = {'(""),<left><left><left>',  '(""),'},
      [';'] = {'("");<left><left><left>',  '("");'},
    },
    s = { name = "Square []",
      ["'"] = {'[""]<left><left>',         '[""]'},
      [','] = {'[""],<left><left><left>',  '[""],'},
      [';'] = {'[""];<left><left><left>',  '[""];'},
    },

    ["'"] = {"''<left>",                 "''"},
    ['"'] = {'""<left>',                 '""'},
    [';'] = {"'';<left><left>",          "'';"},
    [','] = {"'',<left><left>",          "'',"},
    ['.'] = {"'.  .'<left><left><left>", "'. .'"},

  }, -- }}}

  c = { name = 'Curly {}', -- {{{
    [';'] = {"{};<left><left>", "{''};"},
    [','] = {"{},<left><left>", "{''},"},
    r = {"('')<left><left>",    "Round ('')"},
    s = {"['']<left><left>",    "Square ['']"},
    ['<CR>'] = {'{<CR>}<ESC>O',    "{ NL }"},
    ['}'] = {'{<CR>};<ESC>O',    "{ NL };"},

  }, -- }}}

  s = { name = 'Single Quotes', -- {{{
    r = { name = 'Round ()',
      ["'"] = {"('')<left><left>",         "('')"},
      [','] = {"(''),<left><left><left>",  "(''),"},
      [';'] = {"('');<left><left><left>",  "('');"},
    },
    s = { name = "Square []",
      ["'"] = {"['']<left><left>",         "['']"},
      [','] = {"[''],<left><left><left>",  "[''],"},
      [';'] = {"[''];<left><left><left>",  "[''];"},
    },

    ["'"] = {"''<left>",                 "''"},
    [';'] = {"'';<left><left>",          "'';"},
    [','] = {"'',<left><left>",          "'',"},
    ['.'] = {"'.  .'<left><left><left>", "'. .'"},

  }, -- END Single Quotes }}}

  ['('] = {"()<left>",                 "()"},
  [')'] = {"(),<left><left>",          "(),"},
  ["'"] = {"''<left>",                 "''"},
  ['"'] = {'""<left>',                 '""'},
  ['['] = {"[]<left>",                 "[]"},
  [']'] = {"[],<left><left>",          "[],"},
  ['{'] = {"{}<left>",                 "{}"},
  ['}'] = {"{()}<left><left>",         "{()}"},
  ['.'] = {"'.  .'<left><left><left>", "'. .'"},
  ['='] = {"='';<left><left>",         "='';"},
  ['\\'] = {"\\",         "\\"},

} -- END iQ_maps }}}

local iNorm_maps = { -- {{{
  h = {'<Esc>^i', 'Start of line'},
  l = {'<Esc>$a', 'End of line'},
  j = {'<Esc>jl', 'Down'},
  k = {'<Esc>kl', 'Up'},
  J = {'<Esc>:call CapsOff()<CR>:<Backspace>jl', 'Down & CapsOff'},
  K = {'<Esc>:call CapsOff()<CR>:<Backspace>kl', 'Up & CapsOff'},

  b = {'<Esc>B', 'Back'},
  e = {'<Esc> E', 'End of word'},
  o = {'<Esc>o', 'Open below'},
  O = {'<Esc>O', 'Open above'},
  m = {'<Esc>`mi', 'back to Mark "m"'},
  M = {'<Esc>mma', 'create Mark "m"'},
  w = {'<Esc> W', 'next Word'},

  ['.'] = {'<Esc>f>la', 'Next Tag ">"'},
    s = {"<Esc>f'la", 'Next Single Quote'},
    q = {'<Esc>f"la', 'Next Double Quote'},
  ["'"] = {"<Esc>f'la", 'Next Single Quote'},
  ['"'] = {'<Esc>f"la', 'Next Double Quote'},
  [';'] = {';', ';'},
  ['/'] = {'<Esc>n',    'next search'},
  ['?'] = {'<Esc>N',    'previous search'},

  d = { name = 'Delete',
    d = {'<Esc>^C', 'Line'},
    h = {'<Esc>lc^', 'to Start of line'},
    l = {'<Esc>lC', 'to End of line'},
    w = {'<Esc>bciw', 'Word'},
    i = { name = 'Inside..',
      d = {'<Esc>^C', 'Line'},
    },
  },

  n = { name = 'Next Empty..',
    t     = {'<Esc>/><<CR>a', 'Tag'},
    q     = {'<Esc>/""<CR>a', 'Quotes'},
    s     = {"<Esc>/''<CR>a", 'Single Quotes'},
  },
  p = { name = 'Previous Empty..',
    t = {'<Esc>?><<CR>a', 'Tag'},
    q = {'<Esc>?""<CR>a', 'Quotes'},
    s = {"<Esc>?''<CR>a", 'Single Quotes'},
  },

} -- END iNorm_maps }}}

local setup = { -- {{{
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
} -- END setup }}}


-- opts: {{{
-- HACK: almost certainly a better way to send these variables...
local n_opts = { -- {{{
  mode = "n",
  -- prefix = "\\",
  prefix = "<Leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
} -- }}}

local v_opts = { -- {{{
  mode = "v",
  prefix = "<Leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
} -- }}}

local iQ_opts = { -- {{{
  mode = "i",
  -- prefix = "Q",
  prefix = "Q",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
} -- }}}

local iSlash_opts = { -- {{{
  mode = "i",
  -- prefix = "Q",
  prefix = "\\",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
} -- }}}

local iNorm_opts = { -- {{{
  mode = "i",
  prefix = ";",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
} -- }}}
-- END opts }}}


-- do it! {{{
which_key.setup(setup)
which_key.register(v_maps, v_opts)
which_key.register(iQ_maps, iQ_opts)
which_key.register(iSlash_maps, iSlash_opts)
which_key.register(iNorm_maps, iNorm_opts)
which_key.register(n_maps, n_opts)
-- }}}
