local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
  -- sections = { "error", "warn" },
  sections = { 'error', 'warn', 'info', 'hint' },
  -- symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = false,
  update_in_insert = false,
  always_visible = false,
}

local codeium_status = {
  function()
    return vim.fn["codeium#GetStatusString"]()
  end
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local mode = {
  "mode",
  fmt = function(str)
    return str
    -- return "~" .. str .. "~"
  end,
}

local filename = {
  'filename',
  file_status = true,      -- Displays file status (readonly status, modified status)
  path = 4,                -- 0: Just the filename
                           -- 1: Relative path
                           -- 2: Absolute path

  shorting_target = 40,    -- Shortens path to leave 40 spaces in the window

  symbols = {
    modified = ' ', -- Text to show when the file is modified.
    readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
    unnamed  = '華', -- Text to show for unnamed buffers.
  }
}

local filetype = {
	"filetype",
  colored = false,
	icons_enabled = true,
  icon_only = true
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

-- local location = {
-- 	"location",
-- 	padding = 0,
-- }

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

-- my_theme {{{
local colours = {
  dark    = '#1f1f1f',
  main    = '#242423',
  muted   = '#333533',
  light   = '#CFDBD5',
  branch  = '#3d348b',
  normal  = '#7678ed',
  visual  = '#f7b801',
  insert  = '#f18701',
  replace = '#f35b04',
}

local my_theme = {
  normal = {
    a = { fg = colours.dark, bg = colours.normal },
    z = { fg = colours.dark, bg = colours.normal },
    b = { fg = colours.light, bg = colours.branch },
    c = { fg = colours.light, bg = colours.main },
    x = { fg = colours.muted, bg = colours.main },
    y = { fg = colours.light, bg = colours.branch },
  },
  visual = {
    a = { fg = colours.dark, bg = colours.visual },
    z = { fg = colours.dark, bg = colours.visual },
    b = { fg = colours.light, bg = colours.branch },
  },
  replace = {
    a = { fg = colours.main, bg = colours.replace },
    z = { fg = colours.dark, bg = colours.replace },
  },
  inactive = {
    c = { fg = colours.muted, bg = colours.main },
  },
  insert = {
    a = { fg = colours.dark,   bg = colours.insert },
    z = { fg = colours.dark,   bg = colours.insert },
    x = { fg = colours.insert, bg = colours.main },
  }
}
-- }}}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {

    options = {
      icons_enabled = true,
      -- theme = 'nightfly',
      -- theme = 'base16-pinky',
      theme = my_theme,
      component_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },
      -- component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },

      disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "netrw" },
      always_divide_middle = true,
      -- one bar for all open windows
      globalstatus = false,
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { branch },
      -- lualine_c = { fileformat, filetype, filename },
      lualine_c = { filename },
      -- lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_x = { codeium_status },
      lualine_y = { diff, diagnostics },
      lualine_z = { progress },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },

    tabline = {},

    extensions = {},



  }
}
