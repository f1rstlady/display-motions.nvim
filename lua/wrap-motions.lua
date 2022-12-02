local wrap_motions = {}

local forBuf = function(opts)
  if opts then
    opts.buffer = true
  else
    opts = {buffer = true}
  end
  return opts
end

local setBufMap = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, forBuf(opts))
end

local delBufMap = function(mode, lhs, opts)
  vim.keymap.del(mode, lhs, forBuf(opts))
end

wrap_motions.enable = function()
  if vim.b.wrapMotionsEnabled then
    return
  end

  setBufMap("",  "j",      "gj")
  setBufMap("",  "k",      "gk")
  setBufMap("",  "<Down>", "j",           {remap = true})
  setBufMap("",  "<Up>",   "k",           {remap = true})
  setBufMap("",  "0",      "g0")
  setBufMap("",  "^",      "g^")
  setBufMap("",  "$",      "g$")
  setBufMap("n", "A",      "$a",          {remap = true})
  setBufMap("n", "C",      "c$",          {remap = true})
  setBufMap("n", "cc",     "0C",          {remap = true})
  setBufMap("n", "D",      "d$",          {remap = true})
  setBufMap("n", "dd",     "0D",          {remap = true})
  setBufMap("n", "Y",      "y$",          {remap = true})
  setBufMap("n", "yy",     "0Y",          {remap = true})
  setBufMap("i", "<Down>", "<C-o><Down>", {remap = true})
  setBufMap("i", "<Up>",   "<C-o><Up>",   {remap = true})

  vim.b.wrapMotionsEnabled = true
end

wrap_motions.disable = function()
  if not vim.b.wrapMotionsEnabled then
    return
  end

  delBufMap("",  "j")
  delBufMap("",  "k")
  delBufMap("",  "<Down>")
  delBufMap("",  "<Up>")
  delBufMap("",  "0")
  delBufMap("",  "^")
  delBufMap("",  "$")
  delBufMap("n", "A")
  delBufMap("n", "C")
  --delBufMap("n", "cc")
  delBufMap("n", "D")
  --delBufMap("n", "dd")
  delBufMap("n", "Y")
  --delBufMap("n", "yy")
  delBufMap("i", "<Down>")
  delBufMap("i", "<Up>")

  vim.b.wrapMotionsEnabled = false
end

return wrap_motions
