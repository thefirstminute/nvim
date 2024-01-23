--  FAK:
-- this breaks my - leader! 
return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    -- restriction_mode = "hint",
    max_count           = 4,
    allow_different_key = true,

    -- disabled_keys       = {
    --   ["<Up>"]          = {},
    --   ["-"]             = {},
    --   ["<Space>"]       = { "n", "x" },
    -- },

    hints               = {

      ["d[tTfF].i"] = {          -- this matches d + {t/T/f/F} + {any character} + i
        message = function(keys) -- keys is a string of key strokes that matches the pattern
          return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
          -- example: Use ct( instead of dt(i
        end,
        length = 3,
      },
    }

  }
}
