-- Safe Stopper: {{{
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("NO Telescope!!")
  return
end
-- }}}
-- See `:help telescope` and `:help telescope.setup()`

local km = vim.keymap.set
local builtin = require("telescope.builtin")
-- local pickers = require "telescope.pickers"
-- local finders = require "telescope.finders"
-- local conf = require("telescope.config").values
local actions = require "telescope.actions"
-- local action_state = require "telescope.actions.state"

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
      },
      i = {
        -- ['<C-u>'] = false,
        -- ['<C-d>'] = false,
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    registers = {
      register_information = {},
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')

-- Keymaps:
-- quick registers:
km('i', 'qy', [[<cmd>lua require('telescope.builtin').registers({insert = true})<CR>]], { noremap = true })

km('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
-- km('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
km('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
 
-- Map a key to open the yank history
vim.api.nvim_set_keymap("n", "<Leader>qy", [[<Cmd>lua require'telescope'.extensions.registers.register_information{}<CR>]], { noremap = true, silent = true })

-- Auto-insert selected yank item in insert mode
vim.api.nvim_set_keymap("i", "qy", [[<Cmd>lua require'telescope'.extensions.registers.register_information{}<CR>]], { noremap = true, silent = true })

--

-- km('n', '<leader>sg', builtin.git_files, { desc = 'Search [G]it Files' })
-- km('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
-- km('n', '<leader>fo', builtin.find_files, { desc = '[F]ile [O]pen' })
-- km('n', '<leader>fj', builtin.buffers, { desc = '[f]ile [j]ump' })
-- km('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
-- km('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
-- km('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
-- km('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
-- km('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

-- km('n', '<leader>fj', function()
--   builtin.buffers({
--     ---@diagnostic disable-next-line: unused-local
--     attach_mappings = function(_, map) return true end,
--   })
-- end, { noremap = true, silent = true, desc = "[F]ile [J]ump - Open Buffers" })

_G.pick_colorscheme = function()
  builtin.colorscheme({
    theme_conf = {
      prompt_title = 'Colorschemes',
      previewer = false, -- Disable previewer for colorschemes
    },
  })
end
