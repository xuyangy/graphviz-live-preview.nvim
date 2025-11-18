# Quickstart: graphviz-live-preview.nvim

## Prerequisites
- Neovim (latest stable)
- Node.js (used to run a small Express preview server)
- Install plugin dependencies via `npm install` in the plugin root (this will install @hpcc-js/wasm and other JS deps)

## Installation

### With lazy.nvim
Add this to your `init.lua` or `plugins.lua`:

```lua
{
  "xuyangy/graphviz-live-preview.nvim",
  cmd = { "GraphvizPreview" },
  ft = { "dot" },
  build = function()
    require("graphviz_live_preview.util").install()
  end,
}
```

### Manual
1. Clone the plugin repository into your Neovim plugin directory.
2. Run `npm install` to install dependencies.
3. Start Neovim and run the plugin setup command (see README for details).

## Usage
- Open a `.dot` file in Neovim.
- Run `:GraphvizPreview` to launch the live preview in your browser.
- The plugin writes the current buffer to `src/current.dot`, starts a small Node.js Express server (`src/server.js`), and opens `http://localhost:8080/webview.html`.
- The webview polls `/dot` and re-renders whenever the dot source changes on disk (for example, when you save the `.dot` buffer).
- Interact with the preview:
  - Use the search box to highlight nodes.
  - Export the current graph as SVG or dot.
- Use dot syntax highlighting and snippets in Neovim.

### Requirements
- Node.js must be installed and available in your PATH.
- The plugin launches the preview by starting `node src/server.js` (Express) and opening `http://localhost:8080/webview.html`.
- The browser will open automatically (macOS: `open`, Linux: `xdg-open`, Windows: `start`).

### Advanced
- You can customize the preview logic in `src/server.js` and `src/webview.html`.
- Extend the Lua command in `lua/graphviz_live_preview/init.lua` to pass more options or tweak server behavior.

### Preview server lifecycle
- Running `:GraphvizPreview` starts the Node.js preview server and opens the browser.
- Closing or deleting `.dot` buffers with `:bd`, `:bdelete`, or `:bwipeout` will stop the server once there are no loaded `.dot` buffers left.
- A normal `:q` that only closes a window (leaving the buffer loaded/hidden) will **not** stop the server.
- Exiting Neovim (`:q` from the last window, `:qa`, etc.) will also stop the server via a `VimLeavePre` autocmd.

## Troubleshooting
- If preview does not update, check for syntax errors in the dot source.
- For large graphs, performance may degrade; adjust transitionDelay and transitionDuration as needed.
- Ensure all dependencies are installed and up to date.

## Further Reading
- [d3-graphviz documentation](https://github.com/magjac/d3-graphviz)
- [VSCode Interactive Graphviz](https://github.com/tintinweb/vscode-interactive-graphviz)
- [Neovim plugin development](https://neovim.io/doc/user/plugin.html)
