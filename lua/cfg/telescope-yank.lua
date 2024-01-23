-- this was an ai suggestion; no workies
-- Install the necessary Telescope extension
-- Run this in Neovim command-line mode: :TelescopeInstall nvim-Telescope/telescope-fzy-native.nvim

-- Load Telescope and its extension
require('telescope').load_extension('fzy_native')

-- Keymap for inserting yanked text
-- vim.api.nvim_set_keymap('n', '<leader>qy', [[:lua require('my_telescope').insert_yanked_text()<CR>]], { noremap = true, silent = true })

-- Telescope configuration
require('telescope').setup {
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

-- Custom Telescope function for inserting yanked text
local M = {}

M.insert_yanked_text = function()
  local opts = {}
  local reg_contents = vim.fn.getreg(vim.fn.getreg('"'))
  local yanked_items = vim.split(reg_contents, '\n')

  local selection = require('telescope.builtin').fzy_native(opts, {
    prompt_title = 'Yanked Text',
    results_title = 'Yanked Text',
    sorting_strategy = 'descending',
    entry_maker = function(entry)
      return {
        valid = true,
        value = entry,
        ordinal = entry,
        display = entry,
        -- You can add more metadata if needed
      }
    end,
    cwd = vim.fn.expand('%:p:h'), -- Current working directory
  })

  if selection and selection[1] then
    local current_cursor_pos = vim.fn.getcurpos()
    vim.fn.append(current_cursor_pos[1] - 1, selection[1].value)
  end
end

return M

