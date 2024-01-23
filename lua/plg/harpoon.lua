return {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    menu = {
      width = 120
    }
  },
  config = function ()
    local hui = require("harpoon.ui")

    km("n", "<leader>ha", require("harpoon.mark").add_file, { desc = 'harpoon [a]dd' })
    km("n", "<leader>hm", hui.toggle_quick_menu, { desc = 'harpoon [m]enu' })
    km("n", "<A-y>", function() hui.nav_file(1) end, { desc = 'harpoon 1' })
    km("n", "<A-u>", function() hui.nav_file(2) end, { desc = 'harpoon 2' })
    km("n", "<A-i>", function() hui.nav_file(3) end, { desc = 'harpoon 3' })
    km("n", "<A-o>", function() hui.nav_file(4) end, { desc = 'harpoon 4' })
    km("n", "<A-p>", function() hui.nav_file(5) end, { desc = 'harpoon 5' })

    km("n", "<leader>hy", function() hui.nav_file(1) end, { desc = 'harpoon 1' })
    km("n", "<leader>hu", function() hui.nav_file(2) end, { desc = 'harpoon 2' })
    km("n", "<leader>hi", function() hui.nav_file(3) end, { desc = 'harpoon 3' })
    km("n", "<leader>ho", function() hui.nav_file(4) end, { desc = 'harpoon 4' })
    km("n", "<leader>hp", function() hui.nav_file(5) end, { desc = 'harpoon 5' })

  end
}

