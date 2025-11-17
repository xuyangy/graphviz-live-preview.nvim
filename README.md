# graphviz-live-preview.nvim

A Neovim plugin providing interactive live previews for dot/Graphviz files, inspired by [vscode-interactive-graphviz](https://github.com/tintinweb/vscode-interactive-graphviz).

A Neovim plugin providing interactive live previews for dot/Graphviz files, inspired by [vscode-interactive-graphviz](https://github.com/tintinweb/vscode-interactive-graphviz).

## Features
- **Live Preview:** Render dot/Graphviz files in a browser webview using d3-graphviz and @hpcc-js/wasm.
- **Edge Tracing:** Click nodes to highlight incoming/outgoing edges (upstream, downstream, bidirectional). ESC clears highlights.
- **Search:** Search for nodes in the preview and highlight matches.
- **Export:** Download the graph as SVG or dot format.
- **Dot Syntax Highlighting:** Vim syntax file for dot language.
- **Snippets:** Common dot constructs for UltiSnips/LuaSnip.

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
- Your dot source will be rendered in a browser window using d3-graphviz and @hpcc-js/wasm.
- Interact with the preview:
  - Click nodes to trace edges (upstream, downstream, bidirectional).
  - Use the search box to highlight nodes.
  - Export as SVG or dot.
- Use dot syntax highlighting and snippets in Neovim.

### Requirements
- Node.js must be installed and available in your PATH.
- The plugin launches the preview using a Node.js script (`src/preview.js`).
- The browser will open automatically (macOS: `open`, Linux: `xdg-open`, Windows: `start`).

### Advanced
- You can customize the preview logic in `src/preview.js`.
- Extend the Lua command to pass more options or enable live updates.

## Development & Testing
- Run tests: `npx jest`
- All core features are covered by Jest tests.

## Credits
- [d3-graphviz](https://github.com/magjac/d3-graphviz)
- [@hpcc-js/wasm](https://github.com/hpcc-systems/hpcc-js-wasm)
- [vscode-interactive-graphviz](https://github.com/tintinweb/vscode-interactive-graphviz)

## License
MIT
