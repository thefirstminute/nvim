local status_ok, spectre = pcall(require, "spectre")
if not status_ok then
  return
end

spectre.setup { }

vim.cmd [[
nnoremap co :lua require('spectre').open()<CR>
" search current word
nnoremap cc :lua require('spectre').open_visual({select_word=true})<CR>
vnoremap cc :lua require('spectre').open_visual()<CR>
" search in current file (document)
nnoremap cd viw:lua require('spectre').open_file_search().open_visual({select_word=true})<cr>
vnoremap cd viw:lua require('spectre').open_file_search().open_visual({select_word=true})<cr>
]]
