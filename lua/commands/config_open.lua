local M = {}

function M.config_open(opts)
	local path = '~/.config/nvim/'

	if #opts.args > 0 then
		path = path .. opts.fargs[1]
	end

	vim.cmd('e ' .. path)
end

return M
