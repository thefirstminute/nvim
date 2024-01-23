-- TODO:{{{
--[[

https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#note-taking
https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#quickfix
https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#git
https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#editing-support

https://github.com/sudormrfbin/cheatsheet.nvim

--]]
-- }}}
-- Bootstrap lazy 
-- {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- }}}

-- Set some Settings
-- {{{
km = vim.keymap.set
va = vim.api
set = vim.opt

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
km({ 'n', 'v', 'x'  }, '<Space>', '<Nop>', { silent = true })

dofile("/home/bob/Documents/vims/settings.lua")
dofile("/home/bob/Documents/vims/my-keys.lua")
dofile("/home/bob/Documents/vims/hacky.lua")
vim.cmd([[
let &runtimepath .= ',' . expand('~/Documents/vims/colourskeems/')
source /home/bob/Documents/vims/typos.vim"
]])

-- }}}

require("lazy").setup({
  --
  -- AutoCompletings: {{{
  { require("plg.coc") },

  -- { require("plg.codeium") },

  -- AI thingies
  { require("plg.gen") },
  { require("plg.codeium") },


  -- { require("plg.ollama") },


  -- }}}

  -- Extra Language Support: {{{
  { "folke/neodev.nvim", ft = "lua", },
  { 'captbaritone/better-indent-support-for-php-with-html', ft = "php", },
  -- { 'plg.phpactor', ft = "php", },
  { require("plg.treesitter") },

  --}}}

  -- Getting Around & Finding Stuff {{{

  -- the GOAT:
  { require("plg.telescope") },

  -- easily control full buffer sizes
  { require("plg.vim-maximizer") },

  -- quick hop between buffers
  { require("plg.harpoon") },

  -- Jumping around with 's' then a few keystrokes
  -- { require("plg.pounce") },
  { require("plg.flash") },

  -- tmux 
  { require("plg.vim-tmux-navigator") },

  -- }}}

  -- Looks {{{
  { require("plg.nightfly") },
  { require("plg.themes") },
  { require("plg.lualine") },
  { require("plg.indentmini") },

  -- }}}

  -- Cozy Stuff You Really Can Get By Without... {{{

  -- Remember those lesser used commands
  { require("plg.whichkey") },

  -- popup terminal (For lazygit)
  { require("plg.toggleterm") },

  -- Show Hex Colours (There's a better one that will show all colours)
  { require("plg.nvim-colorizer") },

  -- align stuff, mostly to = sign
  { require("plg.vim-easy-align") },

  -- Save Your Butt
  { "mbbill/undotree", cmd = "UndotreeToggle" },

  -- Show Changes:
  { require("plg.gitsigns") },

  -- Git Commands (I always forget to use)
  { "tpope/vim-fugitive", cmd = 'Git' },

  -- Show Troubles:
  -- { require("plg.trouble") },

  -- Convert HEX to RGB
  { 'amadeus/vim-convert-color-to',  cmd = 'ConvertColorTo', },

  --  Comment your codes - Even Works With HTML inside PHP!
  { 'tomtom/tcomment_vim', event = "VeryLazy" },

  -- Fast Surroundings Edits
  -- { require("plg.vim-surround") },
  { require("plg.nvim-surround") },

  -- Orgmode in Vim??
  -- { require("plg.orgmode") },

  -- Todo List:
  { require("plg.vim-todo-lists") },

  -- Swap words around character...
  -- this doesn't allow ranges, and moves end of line elements too...boo.
  -- { 'mmahnic/vim-flipwords', cmd = "Flip",  },
  -- { 'tommcdo/vim-exchange', event = "VeryLazy" },
  { 'kurkale6ka/vim-swap', event = "VeryLazy" },


  -- Hide long inline text like urls and classes
  -- { require("plg.inline-fold") },

  -- highlight keywords
  { require("plg.todo-comments") },

  -- Help figure out where you are big brackets etc
  -- { require("plg.vim-matchup") },

  -- Get Those Habits Outta Here!
  -- { require('plg.bad-practices') },
  -- { require('plg.hardtime') },

  --}}}

})

-- Extra Configurations:
-- TODO: move this into the `plg` setup.
require("cfg.telescope")
-- require("cfg.telescope-yank")

require("cfg.highlight-yanks")

-- Make gf work on lua includes
require("cfg.custom_gf")

require("cfg.lazygit_toggle")

-- Probations
-- {{{

vim.cmd [[

" turn off italic comments:
hi! Comment gui=NONE

augroup _general_settings
  autocmd!
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
  autocmd FileType qf set nobuflisted
  " set omnifunc=syntaxcomplete#Complete
  " au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  " au WinLeave * setlocal nocursorline
augroup end

" Git Controls
augroup _git
  autocmd!
  au FileType gitcommit 1 | startinsert
  au FileType gitcommit 1 | inoremap <CR> <Esc>:wq<CR>
  autocmd FileType gitcommit setlocal wrap
  autocmd FileType gitcommit setlocal spell
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup end

]]

-- Command & Terminal Stuff:
-- TODO: organize this better/use lua
vim.cmd([[
" Enable tab completion in command mode
set wildcharm=<Tab>
set wildmenu
set wildmode=full


cab CURL r !curl -s http
cab tab2space %s/\t/  /g
cab tab4space %s/\t/    /g
cab T2 %s/\t/  /g
cab T4 %s/\t/    /g
cab Snake2camel s/\v_([a-z])/\u\1/g
cab Camel2snake s/\v([a-z])([A-Z])/\1_\L\2/g
cab SC s/\v_([a-z])/\u\1/g
cab CS s/\v([a-z])([A-Z])/\1_\L\2/g

" Bracket Close Comment
command! BC :norm ^mm%y^`mA // END <C-r>"<Esc>
" Tag Close Comment
command! TC :norm ^w%wyt>%A <!-- END <C-r>" --><Esc>

" fix caps
command! W w
command! Q q
"escape command line
cnoremap kj <c-c>

" Terminal Mode:
tnoremap qq <C-c>
tnoremap kj <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
" nnoremap <Leader>T :10sp<CR>:terminal<CR>
" nnoremap <Leader>VT :vs<CR>:terminal<CR>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

]])

-- old Vim Functions
-- TODO: convert to lua someday
vim.cmd([[

" SmartCR:
"{{{
function! SmartCR()
  let char = getline('.')[col('.') - 1]
  let braces = ['(', ')', '{', '}', '[', ']']
  if index(braces, char) != -1
    return "\<CR>\<Esc>O" . matchstr(getline('.'), '\s*') . matchstr(char, '[\[{(]')"
  else
    return "\<CR>"
  endif
endfunction
inoremap <silent> <CR> <C-R>=SmartCR()<CR>
"}}}

" TwiddleCase:
"{{{
" convert current selection upper, lower title case with ~
"https://vim.fandom.com/wiki/Switching_case_of_characters
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
"}}}

" JumpToCSS:
"{{{
function! JumpToCSS()
  let id_pos = searchpos("id", "nb", line('.'))[1]
  let class_pos = searchpos("class", "nb", line('.'))[1]

  if class_pos > 0 || id_pos > 0
    if class_pos < id_pos
      execute ":vim '#".expand('<cword>')."' **/*.css"
    elseif class_pos > id_pos
      execute ":vim '.".expand('<cword>')."' **/*.css"
    endif
  endif
endfunction
" nnoremap <Leader>kc :call JumpToCSS()<CR>
"}}}

" Scratch Me:
"{{{
function ScratchMe()
  execute 'tabnew '
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction
"}}}

" InsertYankedText:
" {{{
function! ShowYankedItems()
  let yanked_items = split(execute('registers "'), "\n")
  let selected = inputlist(yanked_items)
  
  if selected > 0 && selected <= len(yanked_items)
    let yank_text = getreg('"', 1, selected)
    call feedkeys("\<C-R>=InsertYankedText('" . escape(yank_text, '\"') . "')\<CR>")
  endif
endfunction

function! InsertYankedText(text)
  return a:text
endfunction

" inoremap <silent> <expr> qy ShowYankedItems()
"}}}

" TextInput:
" {{{
function! TextInput(question)
  " echo a:question
  let txt = input(a:question)
  return txt
endfunction
" }}}

" YankDeleteUpDown:
" {{{
function YankDeleteUpDown(action, direction)
  let motion = TextInput("how many lines ". a:direction ."? ")

  if a:direction == "up"
    let vimdir = "k"
  else
    let vimdir = "j"
  endif

  if a:action == "yank"
    exe "normal! mm". motion . vimdir ."yy'mp"  
  else
    exe "normal! mm". motion . vimdir ."dd'm"  
  endif

endfunction
" }}}

" Create Vim Folds:
"{{{
function! VimFold() range
  if &filetype == "lua"
    let l:Fopen='-- {{{' | let l:Fclose='-- }}}'
  elseif &filetype == "vim"
    let l:Fopen='" {{{' | let l:Fclose='" }}}'
  elseif &filetype == "php"
    let l:Fopen='/* {{{ */' | let l:Fclose='/* }}} */'
  elseif &filetype == "css"
    let l:Fopen='/* {{{ */' | let l:Fclose='/* }}} */'
  elseif &filetype == "html"
    let l:Fopen='<!-- {{{ -->' | let l:Fclose='<!-- }}} -->'
  else
    let l:Fopen='# {{{' | let l:Fclose='# }}}'
  endif

  exe ":norm gvdO".l:Fopen
  exe ":norm o".l:Fclose
  exe ":norm Pk$hh"
endfunction
vmap vf :call VimFold()<CR>
"}}}

" Toggle Quickfix Window:
"{{{
function! QuickFix_toggle()
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&buftype') == 'quickfix'
      cclose
      return
    endif
  endfor
  copen
endfunction
nnoremap <silent> <Leader>qf :call QuickFix_toggle()<CR>
"}}}

" Open a search results window for selected:
nnoremap <silent> <Leader>sq yiw:execute 'vimgrep <C-r>" **/*'<CR>:copen<CR>
vnoremap <silent> <Leader>sq y:execute 'vimgrep <C-r>" **/*'<CR>:copen<CR>


]])



_G.CreateOrOpenFile = function(filename)
  if vim.fn.filereadable(filename) == 0 then
    vim.fn.writefile({}, filename)
  end
  vim.cmd('edit ' .. filename)
end

-- require "cfg.pick_colorscheme"
local builtin = require("telescope.builtin")
_G.pick_colorscheme = function()
  builtin.colorscheme({
    theme_conf = {
      prompt_title = 'Colorschemes',
      previewer = false, -- Disable previewer for colorschemes
    },
  })
end
-- km('n', '<leader>C', ':lua pick_colorscheme()<CR>', { noremap = true, silent = true })



-- open a vertical split and edit a file 
function V25(file)
  -- Calculate 25% of the current window width
  local width = vim.fn.winwidth(0) * 0.25

  -- Create the vertical split command
  local cmd = 'vertical rightbelow' .. width .. 'new'

  -- Append the file path to the command
  cmd = cmd .. ' ' .. vim.fn.fnameescape(file)

  -- If the file doesn't exist, create it
  if vim.fn.filereadable(file) == 0 then
    vim.fn.writefile({}, file)
  end

  -- Execute the command
  vim.cmd(cmd)

end


-- }}}
