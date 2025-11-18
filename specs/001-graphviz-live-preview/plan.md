# Implementation Plan: Graphviz Live Preview

**Branch**: `001-graphviz-live-preview` | **Date**: 2025-11-17 | **Spec**: [specs/001-graphviz-live-preview/spec.md]
**Input**: Feature specification from `/specs/001-graphviz-live-preview/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Primary requirement: Provide a Neovim plugin for interactive live preview, search, export, and (eventually) edge tracing of dot/Graphviz files, matching the spirit of vscode-interactive-graphviz while staying simple for Neovim.
Technical approach: Implement a Lua Neovim plugin that writes the current buffer to a dot file, a small Node.js Express server that serves `webview.html` and a `/dot` endpoint, and a browser webview that renders using a Graphviz renderer backed by @hpcc-js/wasm and d3 for DOM interaction.

## Technical Context

**Language/Version**: Lua (Neovim plugin), Node.js (Express server), browser JavaScript/HTML
**Primary Dependencies**: @hpcc-js/wasm, d3 (for DOM/search), Express, Neovim Lua API
**Storage**: N/A (no persistent storage required)
**Testing**: NEEDS CLARIFICATION (recommend Busted for Lua, Jest for JS/TS, or pytest for Python)
**Target Platform**: Neovim (cross-platform)
**Project Type**: Single project (Neovim plugin)
**Performance Goals**: <1s live preview update, <2s search for 1000 nodes
**Constraints**: Must match VSCode feature parity, use open-source dependencies, process data locally
**Scale/Scope**: Graphs up to 1000 nodes (per success criteria)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- Interactive Live Feedback: All user-facing features MUST provide immediate, visible feedback for any change to the Graphviz source, including syntax highlighting and snippet insertion. The live preview MUST support zoom, pan, search, and edge tracing, updating on every valid edit. Rendering errors MUST be surfaced clearly and non-blocking.
- Multi-Interface Parity: All core rendering, parsing, and highlighting logic MUST be accessible via both CLI and web interfaces, with consistent behavior and output. CLI must support stdin/stdout, and the web UI must support copy-paste, file upload, and all interactive features (zoom, pan, search, edge tracing).
- Test-Driven Development (NON-NEGOTIABLE): All new features and bug fixes MUST be accompanied by automated tests. Tests MUST be written before implementation (TDD). No code is merged without passing tests for all supported platforms.
- Integration and Contract Testing: Integration tests MUST cover the full rendering and preview pipeline, including error handling, file I/O, interactive features, and cross-platform differences. Contract tests MUST be added for any public API, CLI flag, or UI feature.
- Observability, Simplicity, and Accessibility: All errors, warnings, and key events MUST be logged in a structured, human-readable format. The codebase MUST avoid unnecessary complexity; simple, composable modules are preferred. The web UI MUST be accessible via keyboard and screen reader. Versioning follows MAJOR.MINOR.PATCH (semver).
- Additional Constraints: Only open-source dependencies with OSI-approved licenses are permitted. All user data (files, diagrams) must be processed locally; no data is sent to third-party services. Syntax highlighting and snippets MUST support the full Graphviz (dot) language specification.
- Development Workflow: All changes require code review by at least one other contributor. Every pull request MUST pass all tests and linters before merge. Feature branches MUST be named as `feature/[short-description]`. Releases are cut from `main` after passing all checks.

**All gates pass.**
## Project Structure

### Documentation (this feature)

```text
specs/001-graphviz-live-preview/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lua/
└── graphviz_live_preview/   # Neovim plugin (Lua)

src/
├── server.js                # Express server serving /dot and webview
├── webview.html             # Browser UI for preview/search/export
└── ...                      # Renderer glue, TS/JS helpers

tests/
└── graphvizRenderer.test.ts # Jest tests for renderer logic
```

**Structure Decision**: Single project (Neovim plugin + Node webview) with Lua in `lua/`, Node/JS in `src/`, and tests in `tests/`.
## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
