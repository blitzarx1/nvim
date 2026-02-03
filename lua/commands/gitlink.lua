-- lua/gitlink.lua
local M = {}

local function trim(s)
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function sys(cmd, cwd)
  -- Neovim 0.10+: vim.system; older: fallback to systemlist
  if vim.system then
    local res = vim.system(cmd, { cwd = cwd, text = true }):wait()
    if res.code ~= 0 then
      return nil, res.stderr
    end
    return trim(res.stdout), nil
  else
    local old = vim.fn.getcwd()
    if cwd then vim.cmd("lcd " .. vim.fn.fnameescape(cwd)) end
    local out = vim.fn.systemlist(cmd)
    local code = vim.v.shell_error
    if cwd then vim.cmd("lcd " .. vim.fn.fnameescape(old)) end
    if code ~= 0 then
      return nil, table.concat(out, "\n")
    end
    return trim(table.concat(out, "\n")), nil
  end
end

local function normalize_remote(remote)
  -- Converts:
  --   git@github.com:user/repo.git -> https://github.com/user/repo
  --   ssh://git@host/user/repo.git -> https://host/user/repo
  --   https://host/user/repo.git -> https://host/user/repo
  remote = trim(remote or "")

  remote = remote:gsub("%.git$", "")

  local ssh_host, ssh_path = remote:match("^git@([^:]+):(.+)$")
  if ssh_host and ssh_path then
    return ("https://%s/%s"):format(ssh_host, ssh_path)
  end

  local ssh2_host, ssh2_path = remote:match("^ssh://git@([^/]+)/(.+)$")
  if ssh2_host and ssh2_path then
    return ("https://%s/%s"):format(ssh2_host, ssh2_path)
  end

  -- Already http(s)
  if remote:match("^https?://") then
    return remote
  end

  return remote
end

local function build_url(base, host, path, ref, line1, line2)
  -- GitHub:   /blob/<ref>/<path>#Lx-Ly
  -- GitLab:   /-/blob/<ref>/<path>#Lx-Ly
  -- Bitbucket:/src/<ref>/<path>#lines-x:y
  local lfrag = ""
  if line1 and line2 and line1 ~= line2 then
    lfrag = ("#L%d-L%d"):format(line1, line2)
  elseif line1 then
    lfrag = ("#L%d"):format(line1)
  end

  if host:find("gitlab") then
    return ("%s/-/blob/%s/%s%s"):format(base, ref, path, lfrag)
  elseif host:find("bitbucket") then
    if line1 and line2 and line1 ~= line2 then
      return ("%s/src/%s/%s#lines-%d:%d"):format(base, ref, path, line1, line2)
    elseif line1 then
      return ("%s/src/%s/%s#lines-%d"):format(base, ref, path, line1)
    else
      return ("%s/src/%s/%s"):format(base, ref, path)
    end
  else
    -- Default to GitHub-like
    return ("%s/blob/%s/%s%s"):format(base, ref, path, lfrag)
  end
end

local function get_visual_range()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    return nil
  end
  local srow = vim.fn.getpos("'<")[2]
  local erow = vim.fn.getpos("'>")[2]
  if srow > erow then srow, erow = erow, srow end
  return srow, erow
end

function M.copy_link(opts)
  opts = opts or {}
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    vim.notify("No file name for current buffer", vim.log.levels.WARN)
    return
  end

  -- Determine range: command range > visual selection > cursor line
  local line1, line2
  if opts.line1 and opts.line2 and opts.line1 > 0 and opts.line2 > 0 then
    line1, line2 = opts.line1, opts.line2
  else
    local v1, v2 = get_visual_range()
    if v1 and v2 then
      line1, line2 = v1, v2
      -- exit visual so mappings feel normal
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
    else
      line1 = vim.api.nvim_win_get_cursor(0)[1]
      line2 = line1
    end
  end

  -- Git root
  local root, err_root = sys({ "git", "rev-parse", "--show-toplevel" }, vim.fn.fnamemodify(file, ":h"))
  if not root then
    vim.notify("Not a git repo (or git not available): " .. (err_root or ""), vim.log.levels.ERROR)
    return
  end

  -- Remote (origin by default)
  local remote, err_remote = sys({ "git", "remote", "get-url", "origin" }, root)
  if not remote then
    vim.notify("Couldn't get git remote 'origin': " .. (err_remote or ""), vim.log.levels.ERROR)
    return
  end
  local base = normalize_remote(remote)

  -- Use commit SHA for stable permalinks (change to branch if you prefer)
  local ref, err_ref = sys({ "git", "rev-parse", "HEAD" }, root)
  if not ref then
    vim.notify("Couldn't get git ref: " .. (err_ref or ""), vim.log.levels.ERROR)
    return
  end

  -- Relative file path inside repo
  local rel, err_rel = sys({ "git", "ls-files", "--full-name", file }, root)
  if not rel or rel == "" then
    -- Fallback if file is untracked: compute relative path
    rel = vim.fn.fnamemodify(file, ":p"):gsub(vim.fn.fnamemodify(root, ":p"), "")
    rel = rel:gsub("^/", "")
  end

  local host = base:match("^https?://([^/]+)/") or ""
  local url = build_url(base, host, rel, ref, line1, line2)

  -- Copy to clipboard (+ register)
  vim.fn.setreg("+", url)

  local msg
  if line1 == line2 then
    msg = ("Link to line %d copied to clipboard"):format(line1)
  else
    msg = ("Link to lines %d-%d copied to clipboard"):format(line1, line2)
  end

  vim.schedule(function()
    vim.notify(msg, vim.log.levels.INFO)
  end)
end

return M
