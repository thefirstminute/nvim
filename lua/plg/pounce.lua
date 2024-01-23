  return {
    'rlane/pounce.nvim',
    event = "VeryLazy",
    config = function()

      require'pounce'.setup{
        accept_keys = "SADFERCTGVBJKL:POIUMNHY",
        accept_best_key = "<enter>",
        multi_window = true,
        debug = false,
      }

      km("n", "s",  function() require'pounce'.pounce { } end)
      km("n", "S",  function() require'pounce'.pounce { do_repeat = true } end)
      km("x", "s",  function() require'pounce'.pounce { } end)
      km("o", "gs", function() require'pounce'.pounce { } end)
      -- km("n", "S", function() require'pounce'.pounce { input = {reg="/"} } end)
    end,
  }
