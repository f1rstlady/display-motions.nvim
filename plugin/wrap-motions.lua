local wrap_motions = require("wrap-motions")

local augroup = vim.api.nvim_create_augroup("wrap-motions", {})

-- Toggle the keybindings when changing 'wrap'.
vim.api.nvim_create_autocmd("OptionSet", {
  group = augroup,
  pattern = "wrap",
  desc = "Toggle wrap motions",
  callback = function()
    -- Enable/disable display motions
    if vim.opt_local.wrap:get() then
      wrap_motions.enable()
    else
      wrap_motions.disable()
    end
  end
})

-- Initialise the keybindings if 'wrap' is set.
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  desc = "Initialise display motions",
  callback = function()
    if vim.opt_local.wrap:get() then
      wrap_motions.enable()
    end
  end
})
