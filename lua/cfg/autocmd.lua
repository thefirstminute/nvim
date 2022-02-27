vim.cmd [[

augroup _general_settings
  autocmd!
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
  autocmd FileType qf set nobuflisted
  autocmd BufWinEnter * :set formatoptions-=cro
  autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
  " set omnifunc=syntaxcomplete#Complete
augroup end

" augroup _web
"   autocmd!
"   autocmd FileType php,html,css,scss set iskeyword+=@,48-57,192-255
"   autocmd FileType php,html,css set iskeyword-=$,!,~,+,=
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
" augroup end

augroup _python
  autocmd!
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType python setlocal commentstring=#\ %s
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal foldlevel=2
  autocmd FileType python setlocal foldmethod=indent
  " autocmd FileType python retab
augroup end

augroup Packer
  autocmd!
  autocmd BufWritePost init.lua PackerCompile
augroup end

augroup _git
  autocmd!
  au FileType gitcommit 1 | startinsert
  au FileType gitcommit 1 | inoremap <CR> <Esc>:wq<CR>
  autocmd FileType gitcommit setlocal wrap
  autocmd FileType gitcommit setlocal spell
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup end

augroup _markdown
  autocmd!
  autocmd FileType markdown setlocal wrap
  autocmd FileType markdown setlocal spell
  autocmd FileType *.todo.md setlocal nospell | set nowrap
augroup end

" augroup _auto_resize
"   autocmd!
"   autocmd VimResized * tabdo wincmd = 
" augroup end

" Autoformat
" augroup _lsp
"   autocmd!
"   autocmd BufWritePre * lua vim.lsp.buf.formatting()
" augroup end

]]
