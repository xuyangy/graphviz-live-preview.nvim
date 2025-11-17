# Research: Graphviz Live Preview

## Decision: Language/Version
- Chosen: TypeScript (Node.js, with webview integration)
- Rationale: TypeScript is widely used for Neovim plugins (via node-client), integrates well with d3-graphviz and web technologies, and allows reuse of code from VSCode extensions. Lua is also possible, but TypeScript offers better compatibility with d3-graphviz and related JS libraries.
- Alternatives considered: Lua (native Neovim), Python (via pynvim), Rust (via nvim-oxi)

## Decision: Primary Dependencies
- Chosen: d3-graphviz, @hpcc-js/wasm, jquery.graphviz.svg, vscode-graphviz (for webview and dot support)
- Rationale: These match the dependencies of vscode-interactive-graphviz and provide all required rendering, edge tracking, and dot language support features.
- Alternatives considered: viz.js (less feature-rich), direct Graphviz binary integration (less portable)

## Decision: Testing Framework
- Chosen: Jest (for TypeScript/Node.js)
- Rationale: Jest is the standard for TypeScript/Node.js projects, supports plugin testing, and is compatible with Neovim plugin test runners.
- Alternatives considered: Busted (Lua), Mocha (JS), Pytest (Python)

## Decision: Accessibility & Error Handling
- Chosen: Keyboard navigation, clear error messages, screen reader support in webview
- Rationale: Matches constitution and VSCode parity; ensures usability for all users.
- Alternatives considered: Minimal accessibility (not acceptable per constitution)

## Decision: Integration Patterns
- Chosen: Use Neovim's node-client for plugin host, webview for preview, and direct JS integration for d3-graphviz and related libraries
- Rationale: Allows best reuse of VSCode extension code and web technologies; matches user expectations for interactive preview.
- Alternatives considered: Native Lua integration (less compatible with JS libraries)
