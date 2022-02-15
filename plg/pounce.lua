local status_ok, pounce = pcall(require, "pounce")
if not status_ok then
  vim.notify("can't pounce!")
  return
end

pounce.setup{
  accept_keys = "ASDFWERQTGVCBXZ",
  accept_best_key = "<enter>",
  multi_window = false,
  debug = false,
}


vim.cmd [[
nmap s <cmd>Pounce<CR>
nmap S <cmd>PounceRepeat<CR>
vmap s <cmd>Pounce<CR>
omap s <cmd>Pounce<CR>
]]
