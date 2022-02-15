local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

require 'colorizer'.setup({
  '*'; -- Highlight all files, but customize some others.
  css = { rgb_fn = true; };
  php = { rgb_fn = true; };
  html = { rgb_fn = true; };
})
