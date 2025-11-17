local M = {}

local util = require("graphviz_live_preview.util")

-- Determine the plugin root directory from this module's path.
local function get_plugin_root()
  local source = debug.getinfo(1, "S").source
  if source:sub(1, 1) == "@" then
    source = source:sub(2)
  end
  -- Strip the lua/graphviz_live_preview/init.lua suffix
  local idx = source:find("lua/graphviz_live_preview/init.lua", 1, true)
  if idx then
    return source:sub(1, idx - 1)
  end
  -- Fallback to directory of this file
  return source:match("(.*/)") or vim.fn.getcwd()
end

M.plugin_root = get_plugin_root()

function M.setup()
  vim.api.nvim_create_user_command("GraphvizPreview", function()
    -- Get current buffer contents (reserved for future /dot endpoint)
    local dot_source = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")

    if vim.fn.executable("node") ~= 1 then
      vim.notify("graphviz-live-preview.nvim: Node.js is not available in PATH", vim.log.levels.ERROR)
      return
    end

    local server_script = M.plugin_root .. "src/server.js"

    if vim.fn.filereadable(server_script) ~= 1 then
      vim.notify("graphviz-live-preview.nvim: server.js not found at " .. server_script, vim.log.levels.ERROR)
      return
    end

    -- Start the Node.js server; it will handle port-in-use gracefully
    local job_id = vim.fn.jobstart({ "node", server_script }, {
      detach = true,
    })

    if job_id <= 0 then
      vim.notify("graphviz-live-preview.nvim: failed to start Node server (jobstart returned " .. tostring(job_id) .. ")", vim.log.levels.ERROR)
      return
    end

    vim.cmd("sleep 500m") -- Give server time to start

    -- Robust browser launch
    local function open_browser(url)
      local open_cmd
      if vim.fn.has('mac') == 1 then
        open_cmd = 'open'
      elseif vim.fn.has('win32') == 1 then
        open_cmd = 'start'
      elseif vim.fn.executable('xdg-open') == 1 then
        open_cmd = 'xdg-open'
      elseif vim.fn.executable('wslview') == 1 then
        open_cmd = 'wslview'
      else
        open_cmd = nil
      end
      if open_cmd then
        vim.fn.jobstart({ open_cmd, url }, { detach = true })
      else
        print('Open this URL in your browser: ' .. url)
      end
    end

    open_browser('http://localhost:8080/webview.html')
    print('Graphviz live preview launched at http://localhost:8080/webview.html')
  end, { desc = "Open Graphviz live preview" })
end

M.install = util.install

return M
