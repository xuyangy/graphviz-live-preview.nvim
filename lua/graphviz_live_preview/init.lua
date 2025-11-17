local M = {}

local util = require("graphviz_live_preview.util")

function M.setup()
  vim.api.nvim_create_user_command("GraphvizPreview", function()
    -- Get current buffer contents
    local dot_source = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    -- Always start the Node.js server (it will handle port-in-use gracefully)
    local plugin_dir = debug.getinfo(1, "S").source:match("@?(.*/)")
    local server_script = plugin_dir .. "src/server.js"
    vim.fn.jobstart({"node", server_script}, {detach = true})
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
        vim.fn.jobstart({open_cmd, url}, {detach = true})
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
