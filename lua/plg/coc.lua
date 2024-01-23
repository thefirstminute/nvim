return {
  "neoclide/coc.nvim",
  branch = "release",
  -- event = "InsertEnter",
  event = "VeryLazy",
  -- branch = "master",
  -- build = "yarn install --frozen-lockfile",

  config = function()
    -- Install Coc extensions automatically
    va.nvim_command([[
    autocmd User CocFirstLaunch nested
    :CocInstall
    \ coc-css
    \ coc-emmet
    \ coc-eslint
    \ coc-highlight
    \ coc-html
    \ coc-json
    \ coc-lua
    \ coc-pairs
    \ coc-phpactor
    \ coc-sh
    \ coc-snippets
    \ coc-sql
    \ coc-tsserver
    \ coc-yank
    ]])
    -- coc-python coc-pyright coc-intelephense coc-arduino coc-prettier

    va.nvim_exec([[
    autocmd FileType css let b:coc_additional_keywords = ["-"]
    ]], false)

    -- Disable auto suggestions
    vim.g.coc_suggest_disable_auto_popup = 1

    -- Autocomplete
    function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
    -- km("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    -- km("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
    -- Make <CR> to accept selected completion item or notify coc.nvim to format
    -- <C-g>u breaks current undo, please make your own choice
    -- km("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

    vim.g.coc_snippet_next = 'qj'
    vim.g.coc_snippet_prev = 'qk'

    km("i", "<C-l>", 'coc#pum#visible() ? coc#_select_confirm() : coc#refresh()', opts)
    km("i", "<C-j>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<c-n>" : coc#refresh()', opts)
    km("i", "<C-k>", 'coc#pum#visible() ? coc#pum#prev(1) : coc#refresh()', opts)
    -- hide suggestions:
    km("i", "<C-h>", [[coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"]], opts)

    -- trigger snippets
    -- km("i", ";S", "<Plug>(coc-snippets-expand)")

    -- Use <c-space> to trigger completion
    km("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

    -- -- navigate diagnostics
    -- -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
    -- km("n", "<leader>Ck", "<Plug>(coc-diagnostic-prev)", { silent = true })
    -- km("n", "<leader>Cj", "<Plug>(coc-diagnostic-next)", { silent = true })
    --
    -- -- GoTo code navigation
    -- km("n", "<leader>Cd", "<Plug>(coc-definition)", { silent = true })
    -- km("n", "<leader>Cy", "<Plug>(coc-type-definition)", { silent = true })
    -- km("n", "<leader>Ci", "<Plug>(coc-implementation)", { silent = true })
    -- km("n", "<leader>CR", "<Plug>(coc-references)", { silent = true })


    -- show documentation in preview window
    function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        va.nvim_command('h ' .. cw)
      elseif va.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
      else
        va.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
    end

    -- km("n", "<leader>CK", '<CMD>lua _G.show_docs()<CR>', { silent = true })


    -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
    va.nvim_create_augroup("CocGroup", {})
    va.nvim_create_autocmd("CursorHold", {
      group = "CocGroup",
      command = "silent call CocActionAsync('highlight')",
      desc = "Highlight symbol under cursor on CursorHold"
    })


    -- Symbol renaming
    -- km("n", "<leader>Cr", "<Plug>(coc-rename)", { silent = true })


    -- -- Formatting selected code
    -- km("x", "<leader>Cf", "<Plug>(coc-format-selected)", { silent = true })
    -- km("n", "<leader>Cf", "<Plug>(coc-format-selected)", { silent = true })


    -- Setup formatexpr specified filetype(s)
    va.nvim_create_autocmd("FileType", {
      group = "CocGroup",
      pattern = "typescript,json",
      command = "setl formatexpr=CocAction('formatSelected')",
      desc = "Setup formatexpr specified filetype(s)."
    })

    -- Update signature help on jump placeholder
    va.nvim_create_autocmd("User", {
      group = "CocGroup",
      pattern = "CocJumpPlaceholder",
      command = "call CocActionAsync('showSignatureHelp')",
      desc = "Update signature help on jump placeholder"
    })

    -- Apply codeAction to the selected region
    -- Example: `<leader>aap` for current paragraph
    -- opts = { silent = true, nowait = true }
    -- -- Do default action for next item
    -- km("n", "<leader>J", ":<C-u>CocNext<cr>", opts)
    -- -- Do default action for previous item
    -- km("n", "<leader>K", ":<C-u>CocPrev<cr>", opts)
    --
    -- km("x", "<leader>Cas", "<Plug>(coc-codeaction-selected)", opts)
    -- km("n", "<leader>Cas", "<Plug>(coc-codeaction-selected)", opts)
    --
    -- -- Remap keys for apply code actions at the cursor position.
    -- km("n", "<leader>Cac", "<Plug>(coc-codeaction-cursor)", opts)
    -- -- Remap keys for apply source code actions for current file.
    -- km("n", "<leader>CaS", "<Plug>(coc-codeaction-source)", opts)
    -- -- Apply the most preferred quickfix action on the current line.
    -- km("n", "<leader>Caq", "<Plug>(coc-fix-current)", opts)
    --
    -- -- Remap keys for apply refactor code actions.
    -- km("n", "<leader>CR", "<Plug>(coc-codeaction-refactor)", { silent = true })
    -- km("x", "<leader>Cr", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
    -- km("n", "<leader>Cr", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
    --
    -- -- Run the Code Lens actions on the current line
    -- km("n", "<leader>CL", "<Plug>(coc-codelens-action)", opts)


    -- Map function and class text objects
    -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
    km("x", "if", "<Plug>(coc-funcobj-i)", opts)
    km("o", "if", "<Plug>(coc-funcobj-i)", opts)
    km("x", "af", "<Plug>(coc-funcobj-a)", opts)
    km("o", "af", "<Plug>(coc-funcobj-a)", opts)
    km("x", "ic", "<Plug>(coc-classobj-i)", opts)
    km("o", "ic", "<Plug>(coc-classobj-i)", opts)
    km("x", "ac", "<Plug>(coc-classobj-a)", opts)
    km("o", "ac", "<Plug>(coc-classobj-a)", opts)


    -- Remap <C-f> and <C-b> to scroll float windows/popups
    ---@diagnostic disable-next-line: redefined-local
    opts = { silent = true, nowait = true, expr = true }
    km("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
    km("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
    km("i", "<C-f>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
    km("i", "<C-b>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
    km("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
    km("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

    -- Use CTRL-S for selections ranges
    -- Requires 'textDocument/selectionRange' support of language server
    km("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
    km("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

    -- Add `:Format` command to format current buffer
    va.nvim_create_user_command("Format", "call CocAction('format')", {})

    -- " Add `:Fold` command to fold current buffer
    va.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

    -- Add `:OR` command for organize imports of the current buffer
    va.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

    -- Add (Neo)Vim's native statusline support
    -- NOTE: Please see `:h coc-status` for integrations with external plugins that
    -- provide custom statusline: lightline.vim, vim-airline
    -- vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

    -- Mappings for CoCList
    -- code actions and coc stuff
    ---@diagnostic disable-next-line: redefined-local
    -- local opts = { silent = true, nowait = true }

    -- -- Show all diagnostics
    -- km("n", "<space>cld", ":<C-u>CocList diagnostics<cr>", opts)
    -- -- Manage extensions
    -- km("n", "<space>cle", ":<C-u>CocList extensions<cr>", opts)
    -- -- Show commands
    -- km("n", "<space>clc", ":<C-u>CocList commands<cr>", opts)
    -- -- Find symbol of current document
    -- km("n", "<space>clo", ":<C-u>CocList outline<cr>", opts)
    -- -- Search workspace symbols
    -- km("n", "<space>cls", ":<C-u>CocList -I symbols<cr>", opts)
    -- -- Resume latest coc list
    -- km("n", "<space>clr", ":<C-u>CocListResume<cr>", opts)
    -- -- Show YankRing
    -- km("i", "qy", "<c-o>:CocList -A --normal yank<cr>", opts)

  end,
}
