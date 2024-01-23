return {
  "malbertzard/inline-fold.nvim",
  event = "VeryLazy",
  ft = {"html", "php"},
  opts = {
    -- defaultPlaceholder = "…",
    defaultPlaceholder = "BLAH",
    queries = {
      -- Some examples you can use
      html = {
        { pattern = 'class="([^"]*)"', placeholder = "@" }, -- classes in html
        { pattern = 'href="(.-)"' }, -- hrefs in html
        { pattern = 'src="(.-)"' }, -- HTML img src attribute
      }
    },
  }
}
