function custom_gf()
  local line = vim.fn.getline('.')
  local module = line:match('require%("([^"]+)"%)')
  if module and vim.bo.filetype == 'lua' then
    local path = module:gsub('%.', '/')
    local lua_file = 'lua/' .. path .. '.lua'
    -- local check_file = vim.fn.findfile(lua_file, vim.fn.stdpath('config') .. '/lua;')
    local check_file = vim.fn.findfile(lua_file)
    if check_file ~= '' then
      vim.cmd('edit ' .. lua_file)
      return
    end
  end
  vim.cmd('normal! gf')
end

km ('n', 'gf', '<CMD>lua custom_gf()<CR>', { noremap = true })
