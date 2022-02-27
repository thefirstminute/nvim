vim.cmd [[
cab CURL r !curl -s http
cnoremap ;i <c-c>

" " let php_folding = 1     " enable folding for classes and functions
" " let php_htmlInStrings=1 " highlight HTML in php
" let php_sql_query = 1     " highlight SQL syntax in strings
" let g:ftplugin_sql_omni_key = '<C-s>'
" let g:sql_type_default = 'mysql'
" " let g:PHP_outdentphpescape = 0
" " StanAngeloff PHP:
" " {{{
" let php_var_selector_is_identifier = 1
" let g:php_html_load = 1
" " }}}



" Terminal Mode:
tnoremap qq <C-c>
tnoremap ;i <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
"cnoreabbrev t terminal
nnoremap <Leader>T :10sp<CR>:terminal<CR>
nnoremap <Leader>VT :vs<CR>:terminal<CR>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

"Operator Remaps:
"{{{

"get parens - easier
onoremap i9 i(
onoremap a9 a(

"get braces - easier
onoremap ib i{
onoremap ab a{

"get quotes - easier
onoremap iq i"
onoremap aq a"

" In Next ...
onoremap in" <esc>/"<cr>n:nohl<cr>ci"
onoremap inq <esc>/"<cr>n:nohl<cr>ci"
onoremap in' <esc>/'<cr>n:nohl<cr>ci'
onoremap in{ <esc>/{<cr>:nohl<cr>ci{
onoremap inb <esc>/{<cr>:nohl<cr>ci{
onoremap in( <esc>/(<cr>:nohl<cr>ci(
onoremap inp <esc>/(<cr>:nohl<cr>ci(
onoremap in[ <esc>/[<cr>:nohl<cr>ci[
onoremap in< <esc>/<<cr>:nohl<cr>ci<
onoremap int <esc>/<<cr>:nohl<cr>%lcit

" Around Next...
onoremap an" <esc>/"<cr>n:nohl<cr>ca"
onoremap anq <esc>/"<cr>n:nohl<cr>ca"
onoremap an' <esc>/'<cr>n:nohl<cr>ca'
onoremap an{ <esc>/{<cr>:nohl<cr>ca{
onoremap anb <esc>/{<cr>:nohl<cr>ca{
onoremap an( <esc>/(<cr>:nohl<cr>ca(
onoremap anp <esc>/(<cr>:nohl<cr>ca(
onoremap an[ <esc>/[<cr>:nohl<cr>ca[
onoremap an< <esc>/<<cr>:nohl<cr>ca<
onoremap ant <esc>/<<cr>:nohl<cr>%lcat

" In Last (previous, but using p slows normal use)...
onoremap il" <esc>?"<cr>n:nohl<cr>ci"
onoremap ilq <esc>?"<cr>n:nohl<cr>ci"
onoremap il' <esc>?'<cr>n:nohl<cr>ci'
onoremap il{ <esc>?{<cr>:nohl<cr>ci{
onoremap ilb <esc>?{<cr>:nohl<cr>ci{
onoremap il( <esc>?(<cr>:nohl<cr>ci(
onoremap ilp <esc>?(<cr>:nohl<cr>ci(
onoremap il[ <esc>?[<cr>:nohl<cr>ci[
onoremap il< <esc>?><cr>:nohl<cr>ci<
onoremap ilt <esc>?</<cr>:nohl<cr>cit

" Around Last (previous, but using p slows normal use)...
onoremap al" <esc>?"<cr>n:nohl<cr>ca"
onoremap alq <esc>?"<cr>n:nohl<cr>ca"
onoremap al' <esc>?'<cr>n:nohl<cr>ca'
onoremap al{ <esc>?}<cr>:nohl<cr>ca{
onoremap alb <esc>?}<cr>:nohl<cr>ca{
onoremap al( <esc>?)<cr>:nohl<cr>ca(
onoremap alp <esc>?)<cr>:nohl<cr>ca(
onoremap al[ <esc>?[<cr>:nohl<cr>ca[
onoremap al< <esc>?><cr>:nohl<cr>ca<
onoremap alt <esc>?</<cr>:nohl<cr>cat

" Delete function
onoremap af <esc>V$%d
onoremap if <esc>jVk$%kd

"}}}

]]
