
vim.cmd [[

augroup _general_settings
  autocmd!
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
  autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
  autocmd BufWinEnter * :set formatoptions-=cro
  autocmd FileType qf set nobuflisted
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
augroup end

augroup _auto_resize
  autocmd!
  autocmd VimResized * tabdo wincmd = 
augroup end

" Autoformat
" augroup _lsp
"   autocmd!
"   autocmd BufWritePre * lua vim.lsp.buf.formatting()
" augroup end

" -- Highlight on yank
" augroup YankHighlight
"   autocmd!
"   autocmd TextYankPost * silent! lua vim.highlight.on_yank()
" augroup end

]]
