local this = require("wrap-motions")

local augroup = vim.api.nvim_create_augroup("wrap-motions", {})
vim.api.nvim_create_autocmd("OptionSet", {
  group = augroup,
  pattern = "wrap",
  desc = "Toggle display motions",
  callback = function()
    -- Only proceed if `wrap` changed.
    if vim.v.option_new == vim.v.option_old then
      return
    end

    -- Enable/disable display motions
    if vim.opt_local.wrap:get() then
      this.enable()
    else
      this.disable()
    end
  end
})

-- Initialise the keybindings if 'wrap' is set.
if vim.opt_local.wrap:get() then
  this.enable()
end
