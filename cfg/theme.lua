vim.opt.termguicolors = true  -- colorizer needs this!
vim.cmd 'syntax on'
vim.cmd 'set background=dark'

local colorscheme = "minimalist"
-- local colorscheme = "tokyodark"
-- local colorscheme = "melange"
if not pcall(vim.cmd, "colorscheme " .. colorscheme) then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  vim.cmd("colorscheme slate")
  return
end
vim.cmd("colorscheme " .. colorscheme)

if colorscheme == "material" then
-- material theme: https://github.com/marko-cerovac/material.nvim
vim.g.material_style = 'darker'
-- vim.g.material_style = 'lighter'
-- vim.g.material_style = 'oceanic'
-- vim.g.material_style = 'palenight'
-- vim.g.material_style = 'deep ocean'
end

if colorscheme == "tokyonight" then
--https://github.com/folke/tokyonight.nvim
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.cmd 'colorscheme tokyonight'
end

if colorscheme == "tokyodark" then
--https://github.com/tiagovla/tokyodark.nvim
vim.g.tokyodark_transparent_background = true
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"
end

-- vim: ts=2 sts=2 sw=2
