-- Jump anywhere in 3 keystrokes...
-- (do I like pounce better?)
return {
  "folke/flash.nvim",
  dependencies = {},
  event = "VeryLazy",
  opts = {
    -- labels = "fjdka;lqwertyuiopcmvn,.xz",
    labels = "fjdkla;rueiwovncm",
    modes = {
      search = {
        -- let flash take over /? searches too???
        enabled = false,
      },
      char = {
        -- let flash take over f, F, t, T??
        enabled = false,

        -- makes tf have lables too
        jump_labels = false,
        -- jump_labels = true,

        -- go away after you jump?
        autohide = true,

      }
    },
    jump = {
      jumplist = true,
      -- just go when there's only one match
      autojump = true,
    },
    rainbow = {
      enabled = true,
      -- number between 1 and 9
      shade = 4,
    },
  },
  keys = {
    { "s", mode     = { "n", "x", "o" }, function() require("flash").jump() end,                desc = "Flash" },
    -- { "S", mode     = { "n", "x", "o" }, function() require("flash").treesitter() end,          desc = "Flash Treesitter" },
    { "S", mode     = { "n" },           function() require("flash").treesitter() end,          desc = "Flash Treesitter" },
    { "!", mode     = { "n", "x", "o" }, function() require("flash").jump({continue=true}) end, desc = "Flash" },

    { "r", mode     = { "o" },           function() require("flash").remote() end,              desc = "Remote Flash" },
    { "R", mode     = { "o", "x" },      function() require("flash").treesitter_search() end,   desc = "Treesitter Search" },
    { "<a-s>", mode = { "c" },           function() require("flash").toggle() end,              desc = "Toggle Flash Search" },

  },
}
