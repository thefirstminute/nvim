-- {{{
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify('CMP Missing!')
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  vim.notify('CMP Snippets Missing!')
	return
end

local buff_status_ok, cmp_buffer = pcall(require, "cmp_buffer")
if not buff_status_ok then
  vim.notify('CMP Buffer Missing!')
	return
end

-- require("luasnip/loaders/from_vscode").lazy_load()

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } }) -- Load snippets from my snippets folder
-- luasnip.filetype_extend("php", {"html", "sql", "css", "javascript"})
-- luasnip.filetype_extend("html", {"css", "javascript"})
vim.cmd([[
  inoremap <C-x><C-o> <Cmd>lua vimrc.cmp.lsp()<CR>
  inoremap <C-x><C-s> <Cmd>lua vimrc.cmp.snippet()<CR>
]])


local check_backspace = function()
	local col = vim.fn.col "." - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end
-- }}}

local kind_icons = {
  -- {{{
  -- find more here: https://www.nerdfonts.com/cheat-sheet
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
  -- }}}
}

cmp.setup {
	snippet = { -- {{{
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	}, -- }}}

  confirmation = { completeopt = 'menu,menuone,noinsert' },

	mapping = { -- {{{
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm { select = false },
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- elseif luasnip.expandable() then
			-- 	luasnip.expand()
			-- elseif luasnip.expand_or_jumpable() then
			-- 	luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s", }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then
      --   luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s", }),

    ["<A-j>"] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s", }),
    ["<A-k>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s", }),
  }, -- END MAPING }}}

  formatting = { -- {{{
	  fields = { "kind", "abbr" }, --, "menu"
	  format = function(entry, vim_item)
		  -- Kind icons
		  vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
		  -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
		  vim_item.menu = ({
			  path = "[Path]",
			  nvim_lsp = "[LSP]",
			  luasnip = "[Snippet]",
			  buffer = "[Buffer]",
		  })[entry.source.name]
		  return vim_item
	  end,
  }, -- }}}

  sources = { -- {{{
	  { name = "path" },
	  { name = "luasnip" },
	  { name = "buffer" },
	  { name = "nvim_lsp" },
	  { name = "omni" },
  }, -- }}}

  sorting = { -- {{{
    comparators = {
      function(...) return cmp_buffer:compare_locality(...) end,
      -- The rest of your comparators...
    }
  }, -- }}}

  confirm_opts = { -- {{{
	  behavior = cmp.ConfirmBehavior.Replace,
	  select = false,
  }, -- }}}

  documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, },

  experimental = { -- {{{
	  ghost_text = false,
	  native_menu = false,
  }, -- }}}
}

-- vim: ts=2 sts=2 sw=2
