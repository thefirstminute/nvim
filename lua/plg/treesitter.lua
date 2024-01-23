return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'theHamsta/nvim-treesitter-pairs',
  },
  build = ':TSUpdate',

  opts = {
    pairs = {
      enable = true,
      keymaps = {
        goto_partner = "<leader>%",
        delete_balanced = "X",
      }
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },

    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = "<C-s>",
    --     node_incremental = "<C-s>",
    --     scope_incremental = false,
    --     node_decremental = "<BS>",
    --   },
    -- },

    indent = { enable = false },
    auto_install = true, -- automatically install syntax support when entering new file type buffer
    -- ensure_installed = {
    --   'lua'
    -- },

  },
  config = function (_, opts)
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
  end
}

