return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- fancy icons
  },
  opts = {
    -- options = {
    --   theme = 'codedark', -- lualine theme
    -- },

    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {
        {
          -- Customize the filename part of lualine to be parent/filename
          'filename',
          file_status = true,      -- Displays file status (readonly status, modified status)
          newfile_status = false,  -- Display new file status (new file means no write after created)
          path = 4,                -- 0: Just the filename
                                   -- 1: Relative path
                                   -- 2: Absolute path
          shorting_target = 40,    -- Shortens path to leave 40 spaces in the window

          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory
          symbols = {
            -- modified = '[+]',      -- Text to show when the file is modified.
            -- readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
            modified = ' ', -- Text to show when the file is modified.
            readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
            unnamed  = '華', -- Text to show for unnamed buffers.
          }
        }
      },

      -- lualine_x = {'encoding', 'fileformat', 'filetype'},

      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
        },
      },

      lualine_y = {
        {
          'diagnostics',
          sections = { 'error', 'warn', 'info', 'hint' },
          -- symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
          colored = false,
          update_in_insert = false, -- Update diagnostics in insert mode.
          always_visible = false,   -- Show diagnostics even if there are none.
        }
      },

      -- lualine_z = {'progress', 'location'},

    }
  }
}
