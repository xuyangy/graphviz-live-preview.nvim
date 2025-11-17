local M = {}

local util = require("graphviz_live_preview.util")

function M.setup()
  vim.api.nvim_create_user_command("GraphvizPreview", function()
    -- Get current buffer contents
    local dot_source = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    -- Start Node.js server if not running
    local plugin_dir = debug.getinfo(1, "S").source:match("@?(.*/)")
    local server_script = plugin_dir .. "src/server.js"
    -- Try to connect to server, if fails, start it
    local socket = require('socket')
    local server_running = false
    local tcp = socket.tcp()
    if tcp:connect('127.0.0.1', 8080) then
      server_running = true
      tcp:close()
    end
    if not server_running then
      vim.fn.jobstart({"node", server_script}, {detach = true})
      vim.cmd("sleep 500m") -- Give server time to start
    end
    -- Open browser to preview
    local open_cmd = (vim.fn.has('mac') == 1 and 'open') or (vim.fn.has('win32') == 1 and 'start') or 'xdg-open'
    vim.fn.jobstart({open_cmd, "http://localhost:8080/webview.html"}, {detach = true})
    print("Graphviz live preview launched at http://localhost:8080/webview.html")
  end, { desc = "Open Graphviz live preview" })
end

M.install = util.install

return M
