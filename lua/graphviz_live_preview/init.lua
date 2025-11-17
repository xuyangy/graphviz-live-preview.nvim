local M = {}

local util = require("graphviz_live_preview.util")

function M.setup()
  vim.api.nvim_create_user_command("GraphvizPreview", function()
    -- TODO: Call your TypeScript/Node.js preview logic here
    print("GraphvizPreview command triggered!")
  end, { desc = "Open Graphviz live preview" })
end

M.install = util.install

return M
