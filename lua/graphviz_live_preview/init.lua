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
    -- Open browser to preview
    local open_cmd = (vim.fn.has('mac') == 1 and 'open') or (vim.fn.has('win32') == 1 and 'start') or 'xdg-open'
    vim.fn.jobstart({open_cmd, "http://localhost:8080/webview.html"}, {detach = true})
    print("Graphviz live preview launched at http://localhost:8080/webview.html")
  end, { desc = "Open Graphviz live preview" })
end

M.install = util.install

return M
