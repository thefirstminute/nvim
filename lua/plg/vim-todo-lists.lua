return {
  "aserebryakov/vim-todo-lists",
  ft = "markdown",
  config = function()

    vim.cmd [[
    let g:VimTodoListsMoveItems = 0    
    let g:VimTodoListsCustomKeyMapper = 'VimTodoListsCustomMappings'
    let g:VimTodoListsDatesEnabled = 1
    " let g:VimTodoListsDatesFormat = "%a %b, %Y"

function! VimTodoListsCustomMappings()

nnoremap <buffer> <leader>e :silent call VimTodoListsSetItemMode()<CR>

inoremap <buffer> <CR> :VimTodoListsCreateNewItemBelow<CR> " creates a new item in a line below cursor
nnoremap <buffer> O :VimTodoListsCreateNewItemAbove<CR> " creates a new item in a line above cursor
nnoremap <buffer> o :VimTodoListsCreateNewItemBelow<CR> " creates a new item in a line below cursor
nnoremap <buffer> I :VimTodoListsCreateNewItem<CR> " creates a new item in current line
nnoremap <buffer> + :VimTodoListsGoToNextItem<CR> " go to the next item
nnoremap <buffer> - :VimTodoListsGoToPreviousItem<CR> " go to the previous item
nnoremap <buffer> D :VimTodoListsToggleItem<CR> " toggles the current item (or selected items in visual mode)
nnoremap <buffer> > :VimTodoListsIncreaseIndent<CR> " increases the indent of current line
nnoremap <buffer> < :VimTodoListsDecreaseIndent<CR> " decreases the indent of current line

endfunction

    ]]

    vim.keymap.set('i', '<CR>', "<CMD>VimTodoListsCreateNewItemBelow<CR>",{ noremap = true, silent = true, desc = "creates a new item in current line" })
    vim.keymap.set('n', 'o', "<CMD>VimTodoListsCreateNewItemBelow<CR>",   { noremap = true, silent = true, desc = "creates a new item in a line below cursor" })
    vim.keymap.set('n', 'O', "<CMD>VimTodoListsCreateNewItemAbove<CR>",   { noremap = true, silent = true, desc = "creates a new item in a line above cursor" })
    vim.keymap.set('n', 'I', "<CMD>VimTodoListsCreateNewItem<CR>",        { noremap = true, silent = true, desc = "creates a new item in current line" })
    vim.keymap.set('n', 'j', "<CMD>VimTodoListsGoToNextItem<CR>",         { noremap = true, silent = true, desc = "go to the next item" })
    vim.keymap.set('n', 'k', "<CMD>VimTodoListsGoToPreviousItem<CR>",     { noremap = true, silent = true, desc = "go to the previous item" })
    vim.keymap.set('n', 'D', "<CMD>VimTodoListsToggleItem<CR>",           { noremap = true, silent = true, desc = "toggles the current item" })
    vim.keymap.set('n', '>', "<CMD>VimTodoListsIncreaseIndent<CR>",       { noremap = true, silent = true, desc = "increases the indent of current line" })
    vim.keymap.set('n', '<', "<CMD>VimTodoListsDecreaseIndent<CR>",       { noremap = true, silent = true, desc = "decreases the indent of current line" })

  end,

}
