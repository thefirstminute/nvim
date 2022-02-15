-- this was for  "blackCauldron7/surround.nvim"
-- but it does not add tags!!
if not pcall(require, "surround") then
  vim.notify("can't surround!")
  return
end

-- require"surround".setup { mappings_style = "surround" }

require"surround".setup {
  context_offset = 100,
  -- load_autogroups = false,
  mappings_style = "surround",
  map_insert_mode = true,
  -- quotes = {"'", '"'},
  -- brackets = {"(", '{', '['},
  -- space_on_closing_char = false,
  -- pairs = {
  --     nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
  --     linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' }
  --   },
  --   prefix = "s"
  -- }
}
