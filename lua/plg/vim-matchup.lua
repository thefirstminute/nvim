if not pcall(require, "vim-matchup") then
  return
end

local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

ts_configs.setup {
  matchup = {
    keys    = '%',
    enable  = true, -- mandatory, false will disable the whole extension
    disable = {},  -- optional, list of language that will be disabled
    -- [options]
  },
}
