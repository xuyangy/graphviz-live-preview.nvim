local M = {}

local util = require("graphviz_live_preview.util")

function M.setup()
  vim.api.nvim_create_user_command("GraphvizPreview", function()
    -- Get current buffer contents
    local dot_source = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    -- Run Node.js preview script, passing dot source as argument
    local plugin_dir = debug.getinfo(1, "S").source:match("@?(.*/)")
    local preview_script = plugin_dir .. "src/preview.js"
    vim.fn.system({"node", preview_script, dot_source})
    print("Launching Graphviz live preview in browser...")
  end, { desc = "Open Graphviz live preview" })
end

M.install = util.install

return M
