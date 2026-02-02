local M = {}

function M.config_open(opts)
  local path = vim.fn.expand("~/.config/nvim/")

  if #opts.args > 0 then
    path = path .. opts.fargs[1]
  end

  if vim.fn.isdirectory(path) == 1 then
    vim.cmd("NvimTreeOpen " .. path)
  else
    vim.cmd("edit " .. path)
  end
end

return M
