local o = vim.opt

o.syntax = "off"

o.number = true
o.relativenumber = true

o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true

o.list = true
o.listchars = "tab:▸ ,space:·,trail:·,extends:›,precedes:‹,eol:$"

-- Search behavior: case-insensitive unless uppercase is used.
o.ignorecase = true
o.smartcase = true
