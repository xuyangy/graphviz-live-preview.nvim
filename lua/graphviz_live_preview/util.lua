local M = {}

function M.install()
  -- Check for node
  if vim.fn.executable("node") == 1 then
    -- Get plugin directory
    local plugin_dir = debug.getinfo(1, "S").source:match("@?(.*/)") or vim.fn.getcwd()
    -- Run npm install in plugin dir
    print("Running npm install in " .. plugin_dir)
    vim.fn.system({"npm", "install"}, plugin_dir)
  else
    print("Node.js is required for graphviz-live-preview.nvim")
  end
end

return M
