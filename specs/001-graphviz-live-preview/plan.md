# Implementation Plan: Graphviz Live Preview

**Branch**: `001-graphviz-live-preview` | **Date**: 2025-11-17 | **Spec**: [specs/001-graphviz-live-preview/spec.md]
**Input**: Feature specification from `/specs/001-graphviz-live-preview/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Primary requirement: Provide a Neovim plugin for interactive live preview, search, export, and edge tracing of dot/Graphviz files, matching the feature set of vscode-interactive-graphviz, using d3-graphviz and related dependencies.
Technical approach: Integrate d3-graphviz (powered by @hpcc-js/wasm) for rendering, port edge tracking and webview handling from referenced VSCode extensions, and use dot language support/snippets from vscode-graphviz.

## Technical Context

**Language/Version**: NEEDS CLARIFICATION (recommend Lua, TypeScript, or Python; must support d3-graphviz integration)
**Primary Dependencies**: d3-graphviz, @hpcc-js/wasm, jquery.graphviz.svg, vscode-graphviz (for webview and dot support)
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
src/
├── models/
├── services/
├── cli/
└── lib/

tests/
├── contract/
├── integration/
└── unit/
```

**Structure Decision**: Single project (Neovim plugin) with source in `src/` and tests in `tests/`.
## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
