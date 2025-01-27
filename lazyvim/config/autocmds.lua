-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "term://lazygit" },
	callback = function()
		vim.schedule(function()
			-- Send keys `ze` to scroll left...
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>zei", true, true, true), "i", true)
			-- ...and try (_try_) to disable horizontal scrolling in the buffer
			vim.cmd("set sidescrolloff=" .. vim.o.columns)
			vim.cmd("redraw!")
		end)
	end,
})

vim.cmd([[
  autocmd BufReadPre * hi TrailingWhitespace guibg=#e06c75|match TrailingWhitespace /\s\+$/
]])
