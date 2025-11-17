local M = {}

function M.install()
  -- Check for node
  if vim.fn.executable("node") == 1 then
    -- Get plugin directory
    local plugin_dir = debug.getinfo(1, "S").source:match("@?(.*/)") or vim.fn.getcwd()
    -- Run npm install in plugin dir
    print("Running npm install in " .. plugin_dir)
    vim.fn.system({"npm", "install"}, plugin_dir)
    print("Compiling TypeScript files...")
    vim.fn.system({"npx", "tsc", plugin_dir .. "src/graphvizRenderer.ts", "--outDir", plugin_dir .. "src/"})
    print("Bundling JS for browser (if webpack config exists)...")
    if vim.fn.filereadable(plugin_dir .. "webpack.config.js") == 1 then
      vim.fn.system({"npx", "webpack"}, plugin_dir)
    end
    print("Creating placeholder icons...")
    local icons = {"favicon.ico", "apple-touch-icon.png", "apple-touch-icon-precomposed.png"}
    for _, icon in ipairs(icons) do
      local icon_path = plugin_dir .. "src/" .. icon
      if vim.fn.filereadable(icon_path) == 0 then
        local f = io.open(icon_path, "w")
        if f then f:close() end
      end
    end
  else
    print("Node.js is required for graphviz-live-preview.nvim")
  end
end

return M
