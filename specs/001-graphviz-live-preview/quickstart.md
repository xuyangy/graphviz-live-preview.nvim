# Quickstart: Graphviz Live Preview Neovim Plugin

## Prerequisites
- Neovim (latest stable)
- Node.js (for TypeScript/JS plugin host)
- Install plugin dependencies: d3-graphviz, @hpcc-js/wasm, jquery.graphviz.svg

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
- Open a `.dot` or Graphviz file in Neovim.
- Use the plugin command to open the live preview (e.g., `:GraphvizPreview`).
- Edit the file; the preview updates in real time.
- Use the search box in the preview to highlight nodes.
- Export the graph as SVG or dot using the export buttons in the preview.
- Click nodes in the preview to trace edges; use ESC to clear highlights.
- Configure render options and tracing preferences by passing options to the preview command (see README).

## Troubleshooting
- If preview does not update, check for syntax errors in the dot source.
- For large graphs, performance may degrade; adjust transitionDelay and transitionDuration as needed.
- Ensure all dependencies are installed and up to date.

## Further Reading
- [d3-graphviz documentation](https://github.com/magjac/d3-graphviz)
- [VSCode Interactive Graphviz](https://github.com/tintinweb/vscode-interactive-graphviz)
- [Neovim plugin development](https://neovim.io/doc/user/plugin.html)
