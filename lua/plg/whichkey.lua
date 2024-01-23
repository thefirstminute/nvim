return {
  'folke/which-key.nvim',
  event = "VeryLazy",
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
  },
  config = function()

    local builtin = require("telescope.builtin")
    local actions = require "telescope.actions"

    ----------------- Whichkey Setup  ---------------------
    --{{{--------------------------------------------------
    local whichkey = require("which-key")
    local wk = whichkey.register
    whichkey.setup {
      opts = {
        -- Include other options as needed
      },

      window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
        padding = { 1, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 8, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        zindex = 1000, -- positive value to position WhichKey above other floating windows.
      },
      layout = {
        height = { min = 4, max = 20 }, -- min and max height of the columns
        width = { min = 5, max = 50 }, -- min and max width of the columns spacing = 10, -- spacing between columns
        align = "center", -- align columns left, center or right
      },

      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "", -- symbol prepended to a group
      },
      -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      },
      triggers_blacklist = {
        i = { "e", "j", "k", "v", "q", "/", "!" , "=" },
        -- didn't work n = { [' '] = {" l", " q",}, },
      },
    }
    vim.g.which_key_timeout = 1200

    --}}}--------------------------------------------------
    ----------------- Insert Mode -------------------------
    --{{{--------------------------------------------------

    -- Insert Mode [\] Mappings: {{{
    wk({
      ['\\'] = { '\\',  '\\' },
      ['c'] = { '<Esc>bviwUgi',  'Capitalize word' },
      ['f'] = {'<C-x><C-f>',   '[F]ile'},
      ['i'] = {'<C-x><C-i>',   '[I]ncluded'},
      ['l'] = {'<C-x><C-l>',   '[L]ine'},
      ['o'] = {'<C-x><C-o>',   '[O]mni'},
      ['r'] = {'<C-r>',        '[R]egisters'},
      ['s'] = { "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", "[S]pelling",},
      ['t'] = {'<C-x><C-]>',   '[T]ag'},
      ['v'] = {'<C-r>+',       '<C-[v]> (paste from clipboard)'},
      ['p'] = {'<C-r>"',       '[P]aste'},
      ['P'] = {'<C-r>0',       '2nd Last Paste'},
    }, { prefix = '\\', mode = 'i' })

    if vim.fn.match(vim.bo.filetype, 'php') ~= -1 then
      wk({
        ["$"] = { '<Esc>mmBi$<Esc>`mla',  '[$]variable this word'},
      }, { prefix = '\\', mode = 'i' })
    end

    -- Insert Mode [\] Mappings: }}}

    -- Insert Mode [;] Mappings: {{{
    wk({
      [";"] = { ';<Esc>',  '; & <Esc>'},
      ['c'] = { '<Esc>bviwUgi',  '[c]apitalize word' },
      ['I'] = { '<Esc>I',  '<SOL>' },
      ['A'] = { '<Esc>A',  '<EOL>' },
      ['H'] = { '<Esc>I',  '<SOL>' },
      ['L'] = { '<Esc>A',  '<EOL>' },
      ["O"] = { '<Esc>O',  'New Above'},
      ["o"] = { '<Esc>o',  'New Line'},
      ["S"] = { '<Plug>(coc-snippets-expand)',  'expand [Snippet]'},
      ['h'] = { '<Left>',  '<Left>' },
      ['j'] = { '<Down>',  '<Down>' },
      ['k'] = { '<Up>',    '<Up>' },
      ['l'] = { '<Right>', '<Right>' },
      ['r'] = { '<C-r>',   '<C-r>' },

      ['d'] = { name = '[d]elete..', -- {{{
        d = {'<Esc>^C', 'Line'},
        h = {'<Esc>lc^', 'to Start of line'},
        l = {'<Esc>lC', 'to End of line'},
        w = {'<Esc>bciw', 'Word'},
        i = { name = 'Inside..',
          d = {'<Esc>^C', 'Line'},
        },
      }, -- }}}

      ['n'] = { name = '[n]ext Empty..', -- {{{
        t     = {'<Esc>/><<CR>a', 'Tag'},
        q     = {'<Esc>/""<CR>a', 'Quotes'},
        s     = {"<Esc>/''<CR>a", 'Single Quotes'},
      }, -- }}}

      ['p'] = { name = '[p]revious Empty..', -- {{{
        t = {'<Esc>?><<CR>a', 'Tag'},
        q = {'<Esc>?""<CR>a', 'Quotes'},
        s = {"<Esc>?''<CR>a", 'Single Quotes'},
      }, -- }}}

      ['m'] = { name = 'Marks (.)(.)..', -- {{{
        -- was failing...moved to regular keybinds
        -- m = {'(.)(.)',               '[m]ake (.)(.)'},
        -- f = {'<Esc>/(.)(.)',         '[n]ext'},
        -- n = {'<Esc>/(.)(.)<CR>c2f)', '[n]ext'},
        -- p = {'<Esc>?(.)(.)<CR>c2f)', '[P]revious'},
        -- r = {'<Esc>/(.)(.)<CR>.',    '[R]epeat last action'},
        -- P = {'v2f)"+P',              '[P]aste from clipboard'},
        -- y = {'v2f)p',                'paste [y]anked'},
      }, -- }}}

      ["'"] = { name = 'Quotes..', -- {{{
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

        ['.'] = {"'.  .'<left><left><left>", "'. .'"},
        ['='] = {"='';<left><left>",         "='';"},

      }, -- }}}

    }, { prefix = ';', mode = 'i' })
    -- Insert Mode [;] Mappings: }}}

    -- Insert Mode [Q] Mappings: {{{
    wk({
      Q = {'Q',    'Q'},
    }, { prefix = 'Q', mode = 'i' })

    -- php & html Q's
    --{{{
    if vim.fn.match(vim.bo.filetype, 'php\\|html') ~= -1 then
      wk({
        ['='] = { name = '= stuff', -- {{{
          ["'"] = {"= '<Esc>A';<Esc>", "$Var| = '____';"},
          ['"'] = {'= "<Esc>A";<Esc>', '$Var| = "____";'},
        }, --}}}

        ['"'] = { name = '["] Double quotes', -- {{{
          ["."] = {'".  ."<Left><Left><Left>', '". | ."'},
        }, --}}}


        ["'"] = { name = "['] single quotes", -- {{{
          ["."] = {"'.  .'<Left><Left><Left>", "'. | .'"},
        }, --}}}


        ['D'] = {'die(\'<style> body { background-color: #333; color:#EEE; }</style>\');', '[D]ie Dark'},

        ['c'] = { name = 'Chars..', -- {{{
          a = {'&amp;', '&amp; Ampersand'},
        }, --}}}

        ['e'] = { name = '[e]cho..', -- {{{
          b = {'echo \'<br>\';', '<br>'},
          h = {'echo \'<hr>\';', '<hr>'},
        }, --}}}

        ['h'] = { name = '[h]eadings..', -- {{{
          ['1'] = {'<h1></h1><Esc>4hi', '<h1>'},
          ['2'] = {'<h2></h2><Esc>4hi', '<h2>'},
          ['3'] = {'<h3></h3><Esc>4hi', '<h3>'},
          ['4'] = {'<h4></h4><Esc>4hi', '<h4>'},
          ['5'] = {'<h5></h5><Esc>4hi', '<h5>'},
        }, --}}}

        ['d'] = { name = '[d]iv..',
          c = {'<div class=""></div><Esc>7hi', 'Insert Classed Div'},
          s = {'<div style=""></div><Esc>7hi', 'Insert Styled Div'},
          i = {'<div></div><Esc>5<left>i', 'Insert Div'},
        },

        ['a'] = { name = '[a]ttributes (HTML)..',
        -- moved these to regular keys because the text was delayed here...
        -- comma = {'style=""<left>', 'Insert Style Attribute'},
        -- dot   = {'class=""<left>', 'Insert Class Attribute'},
        -- i     = {'id=""<left>', 'Insert ID Attribute'},
        -- c     = {'class=""<left>', 'Insert Class Attribute'},
        -- d     = {'id=""<left>', 'Insert ID Attribute'},
        -- t     = {'title=""<left>', 'Insert Title Attribute'},
        -- n     = {'name=""<left>', 'Insert Name Attribute'},
        -- s     = {'style=""<left>', 'Insert Style Attribute'},
        -- v     = {'value=""<left>', 'Insert Value Attribute'},
        },

        ['l'] = { name = '[l]ink..',
          l = {'<a href="">(.)(.)</a><Esc>9hi', 'Insert Link'},
          c = {'<a href="">Click Here</a><Esc>15hi', 'Insert "Click Here" Link'},
        },

        ['t'] = { name = '[t]ag..',
          ['p'] = {'<p></p><Esc>3<left>i', 'Insert Paragraph'},
          ['b'] = {'<br>', 'Insert Line Break'},
          ['h'] = {'<hr />', 'Insert Horizontal Rule'},
        },

        }, { prefix = 'Q', mode = 'i' })
      end
      -- php Q's }}}

      -- css Q's 
      -- {{{
      if vim.fn.match(vim.bo.filetype, 'php\\|css\\|html') ~= -1 then
        wk({
          ['C'] = { name = '[C]SS..',
            ['!'] = {'!important', 'Insert !important'},
            ['0'] = {'margin:0; padding:0;', 'Set Margin and Padding to 0'},
            -- Media Queries should just become snippets...
            ['m'] = {'@media screen and (max-width: 770px) {}<left>', 'Insert Media Query'},
            ['B'] = {'background-color:', 'Insert Background Color'},
            ['b'] = {'box-sizing: border-box;', 'Set Box Sizing to Border Box'},
            ['v'] = { name = '[v]ar..',
              ['v'] = {'var(--);<left><left>', 'Insert CSS Variable'},
              ['c'] = {'var(--color);<left><left>', 'Insert CSS Variable with Color'},
            },
          },
        }, { prefix = 'Q', mode = 'i' })
      end
  -- css Q's }}}


  -- Insert Mode [Q] Mappings: }}}

    --}}}--------------------------------------------------
    ----------------- Normal Mode -------------------------
    --{{{--------------------------------------------------

    -- Normal Mode [SPC] Mappings: {{{
    wk({
      -- ignore these: {{{
      [";"] = "which_key_ignore",
      ["_"] = "which_key_ignore",
      ["j"] = "which_key_ignore",
      ["l"] = "which_key_ignore",
      ["q"] = "which_key_ignore",
      ["V"] = "which_key_ignore",
      ["w"] = "which_key_ignore",
      ["x"] = "which_key_ignore",
      [" "] = "which_key_ignore",
      -- }}}

      ['b'] = { name = '[b]uffer..', -- {{{
        b = {'<c-^>',    '[b]ack'},
        d = {'<cmd>bd<CR>',               '[d]elete'},
        f = {'<cmd>bfirst<CR>',           '[f]irst'},
        j = {"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", "[j]ump", },
        l = {'<cmd>blast<CR>',            '[l]ast'},
        n = {'<cmd>bnext<CR>',            '[n]ext'},
        o = {'<cmd>only<CR>',             '[o]nly'},
        p = {'<cmd>bprevious<CR>',        '[p]revious'} ,
        s = {"<cmd>ls<CR>:b<Space>",      'list buffer[s]'},
        x = { "<cmd>xa!<CR>",             "save all & quit" },
      }, -- }}}

      ['c'] = { name = '[c]hat..', -- {{{
          a = { "<cmd>Gen Ask<CR>",    "[a]sk" },
          c = { "<cmd>Gen Chat<CR>",   "[c]hat" },
          l = { "<cmd>Gen Lou<CR>",    "[l]ua" },
          p = { "<cmd>Gen Phrank<CR>", "[p]hp" },
          n = { "<cmd>Gen Neo<CR>",    "[n]eovim" },
      }, -- }}}

      ['e'] = { name = '[e]dit..', -- {{{
        a = {':EasyAlign<CR>',         'easy Align'},
        j = {'mzJ`z',         'Join line'},

        d = { name = '[d]elete..', -- {{{
          b = {'mm:g/^$/d<CR>`m',                'Blank lines'},
          e = {'<cmd>%s/\\r//g<CR>',             'EOL characters'},
          h = {'<cmd>%s/<\\_.\\{-1,\\}>//g<CR>', 'HTML Tags'},
          j = {"<cmd>call YankDeleteUpDown('delete', 'down')<CR>", '"x" lines down'},
          k = {"<cmd>call YankDeleteUpDown('delete', 'up')<CR>",   '"x" lines up'},
          s = {'<cmd>%s/span[^\\>]*//<cr>:%s/<>//<cr>:%s/<\\/>//<cr>:%s/<\\/span>//g<cr>/span<cr><CR>', 'span tags'},
          S = {'<cmd>%sort u<CR>',               'Sort, remove duplicate lines'},
          t = {'<cmd>%s/\\s\\+$//e<CR>',         'Trailing whitespace'},
          T = {"mq:norm %<CR>dd'qdd",   'This Tag'},
        }, -- }}}

        f = { name = '[f]ormat..', -- {{{
          i = { name = '[i]ndent..',
            a = {'gg=G', 'All'},
            h = {'/<head><CR>V100<<Esc>jV/<\\/head<CR>=', 'Head'},
            b = {'/<body<CR>V100<<Esc>jV/<\\/body<CR>=', 'Body'},
            t = {'vitB$oW0=', 'Tag'},
          },
          l = {':%s/>\\s*</>\\r</g<CR>gg=G',     'new Lines for each tag'},
          s = {'<cmd>sort /.\\{-}\\ze\\w/<CR>', 'Sort, ignoring symbols'},
          S = {'<cmd>%sort u<CR>',               'Sort, remove duplicate lines'},
          -- P = {'<cmd>Format<CR>',               'Format (prettier)'},
          ['_'] = { name = 'Camel|Snake..',
            c = {'<cmd>s/\\v_([a-z])/\\u\\1/g<CR>', 'snake_case 2 camelCase'},
            s = {'<cmd>s/\\v([a-z])([A-Z])/\\1_\\L\\2/g<CR>', 'camelCase 2 snake_case'},
          },
          ['<Tab>'] = { name = 'Tab|Spaces..',
            ['2'] = {'<cmd>%s/\\t/  /g<CR>',        'tabs 2 spaces'},
            ['4'] = {'<cmd>%s/\\t/    /g<CR>',      'tabs 4 spaces'},
          },
        },
        -- END Format }}}

        r = { name = '[r]eplace..', -- {{{
          c = {'yiw:%s/<C-r>"/',  'under Cursor'},
          l = {'yiw:s/<C-r>"/',  'on Line'},

          C = {
            name = '[C]onvertColor..',
            a = {'<cmd>ConvertColorTo rgba<CR>',  'convertcolorto rgbA'},
            r = {'<cmd>ConvertColorTo rgb<CR>',   'convertcolorto Rgb'},
            h = {'<cmd>ConvertColorTo hex<CR>',   'convertcolorto Hex'},
          },

          w = {"<cmd>viw:lua require('spectre').open_file_search().open_visual({select_word=true})<cr>",  'Word (spectre)'},
        }, -- END Replace }}}
      }, -- END edit }}}

      ['m'] = { name = '[m]arks (.)(.)..', -- {{{
        m = {'i(.)(.)<Esc>',       'make (.)(.) Mark'},
        f = {'/(.)(.)', '[f]ind mark'},
        n = {'/(.)(.)<CR>c2f)', 'next Mark'},
        p = {'?(.)(.)<CR>c2f)', 'Previous mark'},
        r = {'/(.)(.)<CR>.',    'Repeat last action'},
        P = {'?(.)(.)<CR>v2f)"+P', '[P]aste from clipboard'},
        y = {'?(.)(.)<CR>v2f)p', 'paste [y]anked'},
      }, -- }}}

      ['R'] = { name = '[R]eplace..', -- {{{
        c = { name = '[c]onfirm..',
          d = { name = 'in [d]ocument..',
            w = { [[:%s/\<<C-R><C-W>\>//gc<Left><Left>]], '[w]ord under cursor' },
            s = { [[:%s/<C-R>//gc<Left><Left>]], 'last [s]earch' },
            y = { [[:%s/<C-R>"//gc<Left><Left>]], 'last [y]ank' },
            i = { [[:%s/<C-R>.//gc<Left><Left>]], 'last [i]nserted' },
          },
          l = { name = 'in [l]ine..',
            w = { [[:s/\<<C-R><C-W>\>//gc<Left><Left>]], '[w]ord under cursor' },
            s = { [[:s/<C-R>//gc<Left><Left>]], 'last [s]earch' },
            y = { [[:s/<C-R>"//gc<Left><Left>]], 'last [y]ank' },
            i = { [[:s/<C-R>.//gc<Left><Left>]], 'last [i]nserted' },
          },
        },
        d = { name = 'in [d]ocument..',
          w = { [[:%s/\<<C-R><C-W>\>//g<Left><Left>]], '[w]ord under cursor' },
          s = { [[:%s/<C-R>//g<Left><Left>]], 'last [s]earch' },
          y = { [[:%s/<C-R>"//g<Left><Left>]], 'last [y]ank' },
          i = { [[:%s/<C-R>.//g<Left><Left>]], 'last [i]nserted' },
        },
        l = { name = 'in [l]ine..',
          w = { [[:s/\<<C-R><C-W>\>//g<Left><Left>]], '[w]ord under cursor' },
          s = { [[:s/<C-R>//g<Left><Left>]], 'last [s]earch' },
          y = { [[:s/<C-R>"//g<Left><Left>]], 'last [y]ank' },
          i = { [[:s/<C-R>.//g<Left><Left>]], 'last [i]nserted' },
        },
      }, -- [R]eplace }}}

      ['s'] = { name = '[s]earch..', --{{{
          b = { builtin.buffers,   '[b]uffers'},
          c = {':call JumpToCSS()<CR>',   'jump to [c]ss'},
          d = { builtin.diagnostics, '[d]iagnostics' },
          f = { builtin.find_files, '[f]iles' },
          g = { builtin.git_files, '[G]it Files' },
          h = { builtin.help_tags, '[h]elp tags' },
          p = { builtin.live_grep, 'grep [p]roject' },
          r = { builtin.oldfiles, '[r]ecently opened' },
          R = { builtin.resume, '[R]esume' },
          w = { builtin.grep_string, '[w]ord in project' },
      }, --- }}}

      ['t'] = { name = "[t]ab..", -- {{{
       n = {'<cmd>tabnew<CR>', 'New'},
       l = {'<cmd>tabnext<CR>', 'next'},
       h = {'<cmd>tabprevious<CR>', 'previous'},
       c = {'<cmd>tabclose<CR>', 'Close'},
      }, -- }}}

      ['y'] = { name = "[y]ank..", -- {{{
        y = {"yy:TComment<CR>p", '[y]ank line, comment it, and add below'},
        j = {"<cmd>call YankDeleteUpDown('yank', 'down')<CR>", '"x" lines down'},
        k = {"<cmd>call YankDeleteUpDown('yank', 'up')<CR>",   '"x" lines up'},
        c = {[[:let @+ = @"<CR>]],                             'to Clipboard'},
      }, -- END yank }}}

      ['f'] = { name = '[f]ile..', --{{{
        a = { "<cmd>wa!<CR>",                   "save All" },
        d = { "<cmd>lcd %:p:h<CR>",             "set path to current Directory" },
        e = { "<cmd>Lexplore!<CR>",             "Explorer" },
        n = { "<cmd>enew<CR>",                  "New" },
        p = { '<cmd>let @" = expand("%p")<CR>', "yank file [p]ath" },
        s = { "<cmd>w!<CR>",                    "Save" },
        S = { "<cmd>w !sudo tee %<CR>",         "Sudo Save" },
        c = { [[:lua CreateOrOpenFile(vim.fn.expand("<cfile>"))<CR>]], "[c]reate (or open) file" },
        f = {"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>", "Find",},
        j = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", "Buffer list", },
        T = { '<cmd>lua require("telescope.builtin").find_files({cwd = "~/Documents/templates/"})<CR>',  "Templates" },

        q = { "<cmd>xa!<CR>", "save all & Quit all" },
        x = { "<cmd>qall!<CR>", "quit all - NO save!" },

        r = { name = "[r]ead..", -- {{{
          c = { ":-1 read ~/Documents/templates/css",  "css" },
          h = { ":-1 read ~/Documents/templates/html", "html" },
          k = { ":-1 read ~/Documents/templates/koadstrap", "koadstrap" },
          p = { ":-1 read ~/Documents/templates/php",  "php" },

        }, --}}}

        t = { name = "[t]ype..", -- {{{
          c = { "<cmd>set ft=css<CR>",    "css" },
          h = { "<cmd>set ft=html<CR>",   "html" },
          H = { "<cmd>set ft=haskel<CR>", "haskel" },
          l = { "<cmd>set ft=lua<CR>",    "lua" },
          p = { "<cmd>set ft=php<CR>",    "php" },
          s = { "<cmd>set ft=sh<CR>",     "shell" },
          v = { "<cmd>set ft=vim<CR>",    "vim" },
          y = { "<cmd>set ft=py<CR>",     "python" },
        }, -- }}}

        o = { builtin.find_files, '[o]pen' },
        b = { builtin.buffers, '[j]ump' },

      }, -- [f]ile.. }}}

      ['h'] = { name = '[h]arpoon..' },

      -- ['A'] = { "<CMD>EasyAlign<CR>", 'Easy[A]lign' },
      ['G'] = { "<cmd>lua _lazygit_toggle()<CR>", '[G]it (Lazy)' },
      ['U'] = { "<CMD>UndotreeToggle<CR>", '[U]ndo Tree' },
      [' '] = { "zA", '[space] toggle fold' },

    }, { prefix = ' ', mode = 'n' })
    -- Normal Mode [SPC] Mappings: }}}

    -- Normal Mode [\] Mappings: {{{
    wk({
      ['F'] = { 'yo<CR><Esc>k:r!figlet -f pagga ""<Left>', '[F]iglet!' },

      ['f'] = { name = "[f]olds..", -- {{{
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
      }, --}}}

      ['c'] = {'c', '[C]omments...', --{{{
        t = {':norm ^w%wyt>%A <!-- END <C-r>" --><Esc>', 'closing comment of [t]ag'},
        b = {':norm ^mm%y^`mA // END <C-r>"<Esc>', 'closing comment of [b]racket'},
      }, -- }}}

      ['g'] = { name = "Git..", -- {{{
        b = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
        d = { "<cmd>Gitsigns diffthis HEAD<CR>", "Diff", },
        g = { "<cmd>LazyGit<CR>", "Lazygit" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "next hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "prev hunk" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo stage hunk", },
      }, -- }}}

      o = { name= '[o]mni completions..', -- {{{
        c = {'<cmd>setlocal omnifunc=csscomplete#CompleteCSS<CR>', "CSS"},
        h = {'<cmd>setlocal omnifunc=htmlcomplete#CompleteTags<CR>', 'HTML'},
        j = {'<cmd>setlocal omnifunc=javascriptcomplete#CompleteJS<CR>', 'Javascript'},
        o = {'<cmd>setlocal omnifunc=syntaxcomplete#Complete<CR>', 'syntax'},
        p = {'<cmd>setlocal omnifunc=phpcomplete#CompletePHP<CR>', 'PHP'},
        P = {'<cmd>setlocal omnifunc=python3complete#Complete<CR>', 'Python3'},
        s = {'<cmd>setlocal omnifunc=sqlcomplete#Mapsyntax<CR>', 'SQL'},
        y = {'<cmd>setlocal omnifunc=pythoncomplete#Complete<CR>', 'python'},
      }, -- }}}

      p = { name = '[p]ath..', -- {{{
        f = {':let @" = expand("%p")<CR>', 'File with path'},
        p = {':let @" = expand("%:p")<CR>', 'Path'},
        d = {':let @" = expand("%:")<CR>', 'Directory'},
      }, -- }}}

      ['q'] = { name = '[q]uick fix..', --{{{
        n = { ':cnext<CR>', '[n]ext'},
        p = { ':cprevious<CR>', '[p]revious'},
        b = { ':vimgrep BUG **/*<CR>:copen<CR>', '[b]ug'},
        c = { ':vimgrep <c-r><c-w> **/*<CR>:copen<CR>', 'under [c]ursor'},
        f = { ':vimgrep FAK **/*<CR>:copen<CR>', '[f]ak'},
        t = { ':vimgrep TODO **/*<CR>:copen<CR>', '[t]odo'},
        u = { ':vimgrep URGENT **/*<CR>:copen<CR>', '[u]rgent'},
      }, -- }}}

      s = { name = "[s]ession..", -- {{{
        s = { "<cmd>mksession! .sess.vim<CR><cmd>echo 'Session Saved'<CR>", "save Session" },
        l = { "<cmd>source .sess.vim<CR>",     "load Session" },
      }, --}}}

      ['T'] = { name = "[T]elescope..", --{{{

        h = { "<cmd>Telescope help_tags<CR>", "find Help" },
        k = { "<cmd>Telescope keymaps<CR>", "Keymaps",},
        M = { "<cmd>Telescope man_pages<CR>", "Man pages" },
        m = { "<cmd>Telescope marks<CR>", "Marks",},
        p = { "<cmd>Telescope oldfiles<CR>", "Previously opened" },
        s = { "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", "Spelling",},
        T = { "<cmd>lua require('telescope.config').values.buffer_previewer_maker<CR>", "Tags", },
        W = { "<cmd>Telescope live_grep<CR>", "Word in project" },
        w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "Word in open buffers", },
        z = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "fuZzy find in current",},

        g = { name = "[g]it..",
          b = { "<cmd>Telescope git_branches<CR>", "checkout Branch" },
          c = { "<cmd>Telescope git_commits<CR>", "checkout Commit" },
          o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
        },

      }, -- }}}

      ['$'] = { name = "Terminal..", -- {{{
        ['$'] = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Small" },
        f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
      }, -- }}}

      ['t'] = { name = '[t]emplates..', --{{{
        r = { '<CMD>.read! ~/.config/rofi/scripts/snippets.sh cat<CR>', '[r]ead into file'},
        o = { ':tabnew ~/snippets/', '[o]pen snippets directory'},
      }, -- }}}

      ['v'] = { name = '[v]im Settings..', -- {{{
        c = { ':set clipboard=unnamedplus<CR>',                   'use system [c]lipboard'},
        C = { ':lua pick_colorscheme()<CR>',                      '[c]olor scheme'},
        k = { ':tabnew ~/Documents/vims/my-keys.lua<CR>',         '[k]eymaps'},
        S = { "<cmd>set nospell!<CR>",                            '[S]pelling highlight' },
        s = { ':tabnew ~/Documents/vims/settings.lua<CR>',        '[s]ettings'},
        t = { ':tabnew ~/Documents/vims/typos.vim<CR>',           '[t]ypos'},
        u = { ':tabnew<CR>:CocCommand snippets.editSnippets<CR>', '[u]ltisnips'},
        v = { ':vs ~/Documents/vims/',                            '[v]ims folder'},
        W = { "<cmd>set nowrap!<CR>",                             '[W]rap text' },
        w = { ':tabnew ~/.config/nvim/lua/plg/whichkey.lua<CR>',  '[s]ettings'},
      }, -- }}}

    }, { prefix = '\\', mode = 'n' })
    -- Normal Mode [\] Mappings: }}}

    -- Normal Mode [-] Mappings: {{{
    wk({
      ['s'] = {'<cmd>call ScratchMe()<CR>', '[s]cratch buffer'} ,
      ['f'] = { "<C-w>j:let &winheight = &lines * 7 / 10<CR><C-w>j:let &winwidth = &columns * 7 / 10<CR>", "[f]ocus window" },
      ['m'] = { "<CMD>MaximizerToggle<CR>", "[m]aximizer toggle" },
      ['t'] = { ":lua V25('1.todo.md')<CR>", "[t]odo split" },
      ['v'] = { ":lua V25(vim.fn.input('File: '))<CR>", "[v]ertical split 25%" },

      ['q'] = { name = '[q]uick fix..', --{{{
        n = { ':cnext<CR>', '[n]ext'},
        p = { ':cprevious<CR>', '[p]revious'},
        b = { ':vimgrep BUG **/*<CR>:copen<CR>', '[b]ug'},
        c = { ':vimgrep <c-r><c-w> **/*<CR>:copen<CR>', 'under [c]ursor'},
        f = { ':vimgrep FAK **/*<CR>:copen<CR>', '[f]ak'},
        t = { ':vimgrep TODO **/*<CR>:copen<CR>', '[t]odo'},
        u = { ':vimgrep URGENT **/*<CR>:copen<CR>', '[u]rgent'},
      }, -- }}}

    }, { prefix = '-', mode = 'n' })
    -- Normal Mode [-] Mappings: }}}

    -- Normal Mode [g] Mappings: {{{
    wk({
      ['p'] = { [[:normal! `[v`] <CR>]], 'grab last [p]asted', noremap = true },
    }, { prefix = 'g', mode = 'n' })
    -- Normal Mode [g] Mappings: }}}

    -- Normal Mode [X] Mappings: {{{
    wk({
      ['='] = { [[:normal! `[v`] <CR>]], 'swap around [=]', noremap = true },
    }, { prefix = 'X', mode = 'n' })
    -- Normal Mode [X] Mappings: }}}


    -- Normal Mode [C] Mappings: {{{

    -- stop C from doing what it do.
    vim.api.nvim_set_keymap('n', 'C', [[<Cmd>WhichKey C<CR>]], { noremap = true, silent = true })

    wk({

      ['c'] = { name = 'change [c]ase..',
        s = {[[<CMD>s/\v([a-z])([A-Z])/\1_\L\2/g<CR>]], '[s]nake case'},
        c = {[[<CMD>s/\v_([a-z])/\u\1/g<CR>]], '[c]amel case'},
      },

      ['C'] = {'C', '[C]hange to EOL'}, -- keeping a Change Line Ability
      ['t'] = {':norm ^w%wyt>%A <!-- END <C-r>" --><Esc>', 'closing comment of [t]ag'},
      ['b'] = {':norm ^mm%y^`mA // END <C-r>"<Esc>', 'closing comment of [b]racket'},

      ['a'] = { name = '[a]ction..',
        c = {'<Plug>(coc-codeaction-cursor)', 'Apply Code Actions Cursor'},
        q = {'<Plug>(coc-fix-current)', 'Apply Quickfix Action'},
        r = {'<Plug>(coc-codeaction-refactor)', 'Refactor Code Actions'},
        R = {'<Plug>(coc-codeaction-refactor-selected)', 'Refactor Selected'},
        s = {'<Plug>(coc-codeaction-selected)', 'Code Action Selected'},
        S = {'<Plug>(coc-codeaction-source)', 'Apply Source Code Actions'},
      },

      ['D'] = {'<CMD>lua _G.show_docs()<CR>', 'Show [D]ocumentation'},
      ['d'] = {'<Plug>(coc-definition)', 'Go To [d]efinition'},
      ['f'] = {'<Plug>(coc-format-selected)', '[f]ormat Selected'},
      ['i'] = {'<Plug>(coc-implementation)', 'Go To [i]mplementation'},
      ['j'] = {'<Plug>(coc-diagnostic-next)', 'Next Diagnostic'},
      ['k'] = {'<Plug>(coc-diagnostic-prev)', 'Prev Diagnostic'},
      ['L'] = {'<Plug>(coc-codelens-action)', 'Run Code [L]ens Action'},
      ['n'] = {':<C-u>CocNext<cr>', 'Coc [n]ext'},
      ['p'] = {':<C-u>CocPrev<cr>', 'Coc [p]rev'},
      ['R'] = {'<Plug>(coc-references)', 'Find [R]eferences'},
      ['r'] = {'<Plug>(coc-rename)', 'Symbol [r]ename'},
      ['y'] = {'<Plug>(coc-type-definition)', 'Go To T[y]pe Definition'},

    }, { prefix = 'C', mode = 'n' })
    -- Normal Mode [C] Mappings: }}}

    --}}}--------------------------------------------------
    ----------------- Visual Mode -------------------------
    --{{{--------------------------------------------------

    vim.api.nvim_set_keymap('x', 'C', [[<Cmd>WhichKey C<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'C', [[<Cmd>WhichKey C<CR>]], { noremap = true, silent = true })

    -- Visual [C] Mappings: {{{
    wk({
      ['r'] = {'<Plug>(coc-codeaction-refactor-selected)', '[r]efactor Selected'},

      ['c'] = { name = 'change [c]ase..',
        s = {[[<CMD>s/\%V\v([a-z])([A-Z])/\1_\L\2/g<CR>]], '[s]nake case'},
        c = {[[<CMD>s/\%V\v_([a-z])/\u\1/g<CR>]], '[c]amel case'},
      },
    }, { prefix = 'C', mode = 'x' })
    -- }}}

    -- Visual Mode [SPC] Mappings: {{{
    wk({

      ['c'] = { "y:execute 'vimgrep <C-r>\" **/*'<CR>:copen<CR>", "COpen",},
      ['C'] = { "y:vimgrepadd <C-r>\" % <bar> copen<CR>", "COpen Directory",},
      ['p'] = {'<cmd>"+P<CR>',       'Paste from clipboard'},
      ['s'] = {'o<ESC>O<ESC>gvo<ESC>o<ESC>',       '[s]pace around selection'},
      ['y'] = {'"*y :let @+=@*<CR>', '[y]ank to Clipboard'},
      ['{'] = {'<ESC>DA {<CR><C-r>"<CR>}<ESC>kva{=<ESC>',    "{ NL }"},
      ['='] = {':EasyAlign =<CR>',     "Easy Align On [=]"},

      ['e'] = { name = 'edit..', -- {{{
        a = {':EasyAlign<CR>',         'easy [a]lign'},
      }, --}}}


      ['R'] = { name = '[R]eplace..', -- {{{

        d = { name = 'in [d]ocument..',
          w = { [[y:<C-U>%s/\<<C-R><C-W>\>//gc<Left><Left>]], { noremap = true, desc = '[w]ord under cursor' } },
          s = { [[y:<C-U>%s/<C-R>//gc<Left><Left>]], { noremap = true, desc = '[s]earch' } },
          y = { [[y:<C-U>%s/<C-R>"//gc<Left><Left>]], { noremap = true, desc = '[y]ank' } },
          i = { [[y:<C-U>%s/<C-R>.//gc<Left><Left>]], { noremap = true, desc = 'last [i]nserted' } },
        },

        l = { name = 'in [l]ine..',
          w = { [[y:<C-U>s/\<<C-R><C-W>\>//g<Left><Left>]], { noremap = true, desc = '[w]ord under cursor' } },
          s = { [[y:<C-U>s/<C-R>//g<Left><Left>]], { noremap = true, desc = '[s]earch' } },
          y = { [[y:<C-U>s/<C-R>"//g<Left><Left>]], { noremap = true, desc = '[y]ank' } },
          i = { [[y:<C-U>s/<C-R>.//g<Left><Left>]], { noremap = true, desc = 'last [i]nserted' } },
        },

      }, --}}}

    }, { prefix = ' ', mode = { 'x', 'v' } })
    -- Visual Mode [SPC] Mappings: }}}

    -- Visual Mode [\] Mappings: {{{
    wk({
      ['F'] = { 'yo<CR><Esc>k:r!figlet -f pagga "<c-r>""<CR>vip:TCommentBlock<CR>', 'Figlet!' },
    }, { prefix = '\\', mode = { 'x', 'v' } })
    -- Visual Mode [\] Mappings: }}}

    -- Visual Mode [-] Mappings: {{{
    wk({
      ['f'] = { '<cmd>echo "Testing Visual Mode"<CR>', 'Test Visual Mode' },
    }, { prefix = '-', mode = { 'x', 'v' } })
    -- Visual Mode [-] Mappings: }}}

  --}}}--------------------------------------------------
  end,
}
