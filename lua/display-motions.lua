local displayMotions = {}

local nest = require 'nest'

displayMotions.keymaps = {
	{
		mode = '',
		{
			{ 'j', 'gj' },
			{ 'k', 'gk' },
			{ '<Down>', 'j', remap = true },
			{ '<Up>', 'k', remap = true },
			{ '0', 'g0' },
			{ '^', 'g^' },
			{ '$', 'g$' },
		},
	},
	{
		mode = 'i',
		{
			{ '<Down>', '<C-o><Down>', remap = true },
			{ '<Up>', '<C-o><Up>', remap = true },
		},
	},
}

local appliedKeymaps = {}

displayMotions.debug = {
	-- A readonly interface to the table of applied keymaps
	appliedKeymaps = setmetatable({}, {
		__index = appliedKeymaps,
		__newindex = function() end,
	}),
}

function displayMotions.enable()
	if vim.b.displayMotionsEnabled then
		return
	end

	appliedKeymaps = nest.applyKeymaps(displayMotions.keymaps)

	vim.b.displayMotionsEnabled = true
end

function displayMotions.disable()
	if not vim.b.displayMotionsEnabled then
		return
	end

	if appliedKeymaps then
		nest.revertKeymaps(appliedKeymaps)
		appliedKeymaps = nil
	end

	vim.b.displayMotionsEnabled = false
end

function displayMotions.toggle()
	if vim.b.displayMotionsEnabled then
		displayMotions.disable()
	else
		displayMotions.enable()
	end
end

return displayMotions
