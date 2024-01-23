return {
  'Exafunction/codeium.vim',
  event = "BufEnter",
  config = function ()

    -- Replace with your Codeium API key
    -- vim.api("let g:codeium_api_key = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjAzMmNjMWNiMjg5ZGQ0NjI2YTQzNWQ3Mjk4OWFlNDMyMTJkZWZlNzgiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTm90YSAgQm90IiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2V4YTItZmIxNzAiLCJhdWQiOiJleGEyLWZiMTcwIiwiYXV0aF90aW1lIjoxNzAzMzMwODY4LCJ1c2VyX2lkIjoicElPdlFka2J5WlVnTVhkN0szMjNBUW82c3dMMiIsInN1YiI6InBJT3ZRZGtieVpVZ01YZDdLMzIzQVFvNnN3TDIiLCJpYXQiOjE3MDMzMzA4NzQsImV4cCI6MTcwMzMzNDQ3NCwiZW1haWwiOiJ0YWxraW5ndG9haUBvdXRsb29rLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0YWxraW5ndG9haUBvdXRsb29rLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.M8Vc6FUjZ66FeU3Pa1cMrmADjuDG9nN0NR7MWMlXSXLdOuTK8qGyJdUjmLPeIcymygMNUgWSjnJ7wKvpnCMXvmBlJ8ytZ25BpaVGG8nXRUqCLcZVE5exIQSglgNPA4acfxmDT0__gu_3_h1Pe360RMlTvZEBIzmuX_myYVtqZmtFu2jTR2c3BYDdwikDLnrn1enwGAb1pKdK9v4RZFtrcb6LPBgFOLu0yaNZ6ZPRVKkscQYXC3XFCZiijGv96K1-pzy5GGq33c8ClP756lAC2vtnx4rb-1hZL8GLRspIYwiaPA8zJ2UZgEpnC0BW6SD3NU9agylmuX7iIq_dN1ke7A'")

    -- vim.api("let g:codeium_manual = v:true")


    -- disable codeium for markdown files
    -- vim.api([[
    -- let g:codeium_filetypes = {
    --   \ "markdown": v:false,
    --   \ "text": v:false,
    --   \ }   
    --   let g:codeium_ignore_case = v:true
    -- ]])

    -- vim.api("autocmd FileType markdown let g:codeium_manual = v:false")

    vim.cmd([[
    let g:codeium_manual = v:false
    ]])

    vim.keymap.set('i', '<A-Enter>', function() return vim.fn['codeium#Accept']() end,        { expr = true, silent = true })
    vim.keymap.set('i', '<A-l>', function() return vim.fn['codeium#Accept']() end,            { expr = true, silent = true })
    vim.keymap.set('i', '<A-j>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<A-k>', function() return vim.fn['codeium#CycleCompletions'](-1) end,{ expr = true, silent = true })
    vim.keymap.set('i', '<A-h>', function() return vim.fn['codeium#Clear']() end,             { expr = true, silent = true })

  end
}
