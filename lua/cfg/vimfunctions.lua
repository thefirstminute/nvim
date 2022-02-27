vim.cmd [[
" Capslock Off When Exiting Insert:
" {{{
" https://www.reddit.com/r/vim/comments/bzbv98/detect_whether_caps_locks_is_on/
" thanks @ransom_cynic
function! CapsStatus()
  let St = systemlist('xset -q | grep "Caps Lock" | awk ''{print $4}''')[0]
  return St
endfunction

function! CapsOff()
  if CapsStatus() == "on"
    call system("xdotool key Caps_Lock")
    redraw
    highlight Cursor guifg=white guibg=black
  endif
endfunction

autocmd InsertLeave * call CapsOff()

"bonus clear highlights and get out of caps lock with escape
map <Esc> <Esc>:call CapsOff()<CR>:noh<CR>:<Backspace>
" }}} END CapsOff

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
nnoremap <Leader>kc :call JumpToCSS()<CR>
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

""  Could create one that closes comments??
"" Bracket Close Comment
"command! BC :norm ^mm%y^`mA // END <C-r>"<Esc>
"" Tag Close Comment
"command! TC :norm ^w%wyt>%A <!-- END <C-r>" --><Esc>

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
  else
    let l:Fopen='# {{{' | let l:Fclose='# }}}'
  endif

  exe ":norm gvdO".l:Fopen
  exe ":norm o".l:Fclose
  exe ":norm Pj"
endfunction
vmap vf :call VimFold()<CR>
"}}}

" Stop Auto Comments:!!!! (STILL fails sometimes, jfc vim!!)
 " {{{
augroup NoComment
  autocmd!
  autocmd BufEnter,BufCreate *.* call NoComments()
augroup END

function! NoComments() abort
  set formatoptions=qlj
endfunction

]]
