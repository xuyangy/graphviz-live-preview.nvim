# graphviz-live-preview.nvim

A Neovim plugin providing interactive live previews for dot/Graphviz files, inspired by [vscode-interactive-graphviz](https://github.com/tintinweb/vscode-interactive-graphviz).

A Neovim plugin providing interactive live previews for dot/Graphviz files, inspired by [vscode-interactive-graphviz](https://github.com/tintinweb/vscode-interactive-graphviz).

## Features
- **Live Preview:** Render dot/Graphviz files in a browser webview using a Graphviz renderer backed by @hpcc-js/wasm.
- **Search:** Search for nodes in the preview and highlight matches.
- **Export:** Download the graph as SVG or dot format.
- **Dot Syntax Highlighting:** Vim syntax file for dot language.
- **Snippets:** Common dot constructs for UltiSnips/LuaSnip.

Edge tracing and advanced tracing options are planned but not implemented yet.

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
1. Clone this repo and run `npm install`.
2. Place `syntax/dot.vim` in your Neovim runtime path (`~/.config/nvim/syntax/`).
3. Place `snippets/dot.snippets` in your snippet plugin directory.
4. Build and run the plugin (see Quickstart).

## Usage
- Open a `.dot` file in Neovim.
- Run `:GraphvizPreview` to launch the live preview in your browser.
- The plugin writes the current buffer to `src/current.dot`, starts a small Node.js Express server (`src/server.js`), and opens `http://localhost:8080/webview.html`.
- The webview polls `/dot` and re-renders whenever the dot source changes on disk (e.g. when you save the buffer).
- Interact with the preview:
  - Use the search box to highlight nodes.
  - Export as SVG or dot.
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

## Development & Testing
- Run tests: `npx jest`
- All core features are covered by Jest tests.

## Credits
- [d3-graphviz](https://github.com/magjac/d3-graphviz)
- [@hpcc-js/wasm](https://github.com/hpcc-systems/hpcc-js-wasm)
- [vscode-interactive-graphviz](https://github.com/tintinweb/vscode-interactive-graphviz)

## License
MIT
