local wrap_motions = {}

local nest = require("nest")

wrap_motions.keymaps = {
  buffer = true, {
    { mode = "", {
      { "j", "gj" },
      { "k", "gk" },
      { "<Down>", "j", remap = true },
      { "<Up>", "k", remap = true },
      { "0", "g0" },
      { "^", "g^" },
      { "$", "g$" },
    }},
    { mode = "n", {
      { "A", "$a", remap = true },
      { "C", "c$", remap = true },
      { "D", "d$", remap = true },
      { "Y", "y$", remap = true },
      { "cc", "0C", remap = true },
      { "dd", "0D", remap = true },
      { "yy", "0Y", remap = true },
    }},
    { mode = "i", {
      { "<Down>", "<C-o><Down>", remap = true },
      { "<Up>", "<C-o><Up>", remap = true },
    }}
  }
}

local appliedKeymaps = {}

function wrap_motions.enable()
  if vim.b.wrapMotionsEnabled then
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  appliedKeymaps[buf] = nest.applyKeymaps(wrap_motions.keymaps)

  vim.b.wrapMotionsEnabled = true
end

function wrap_motions.disable()
  if not vim.b.wrapMotionsEnabled then
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  if appliedKeymaps[buf] then
    nest.revertKeymaps(appliedKeymaps[buf])
    appliedKeymaps[buf] = nil
  end

  vim.b.wrapMotionsEnabled = false
end

return wrap_motions
