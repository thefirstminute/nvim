-- XXX: also needs plenary...This isn't quite working right
-- https://github.com/folke/todo-comments.nvim
local status_ok, todo_comments = pcall(require, "todo-comments")
if not status_ok then
  vim.notify('No Todo Comments')
  return
end

-- if not pcall(require, "plenary") then
--   vim.notify('No Plenary')
--   return
-- end

config = function()
  todo_comments.setup {
    signs = true,
    sign_priority = 8,

    keywords = {
      ERR = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "BAD", "GLITCH", "WTF", "ISSUE" }, -- a set of other keywords that all map to this BAD keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      NICE = { icon = " ", color = "success" },
      TODO = { icon = " ", color = "info" },
      HEAD = { icon = " ", color = "info" },
      PERF = { icon = " ", color = "info"},
      NOTE = { icon = " ", color = "hint"},
      KISS = { icon = " ", color = "hint" },
      WARN = { icon = " ", color = "warning" },
      LOOK = { icon = " ", color = "warning" },
      MESS = { icon = " ", color = "warning"},
      HACK = { icon = " ", color = "warning" },
      WIP  = { icon = "裂", color = "hint" },
      BUG  = { icon = " ", color = "warning" },
      HUH  = { icon = " ", color = "warning" },
      FIX  = { icon = " ", color = "warning" },
      HEY  = { icon = " ", color = "warning" },
      POO  = { icon = " ", color = "warning" },
      ZZZ  = { icon = "鈴", color = "warning" },
      XXX  = { icon = " ", color = "warning" }
    },

    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "fg", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      -- pattern = [[\b(KEYWOR

    }
  }
end

--[[
-- {{{
-- Code..
 ﲵ
 
  

 נּ



-- Attention/Notice/Fix/Idea
   ﮻﮻ 𥉉   

 

   
華


   
   



 
 ﴫ  

 
-- Gauges/Measure/Date/Time/etc..
 龍
 愈

-- Binary...Yes/No/Done/Todo
  ﲏ 
  ﯇ 
 ﰸ
ﮖ
-- Status/Progress/Gestures/Events/Locations
    
  
 
  
  
  


 

    


-- Misc & silly (I've spent WAY too much time on this)







嘆




שּ
ﴪ
   














裂
鈴








-- }}}
--]]
-- find symbols/icons: https://www.nerdfonts.com/cheat-sheet
