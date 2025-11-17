<!--
Sync Impact Report
Version change: 1.1.0 → 1.1.1
List of modified principles: None
Added sections: None
Removed sections: None
Templates requiring updates:
  ✅ .specify/templates/plan-template.md (no changes needed)
  ✅ .specify/templates/spec-template.md (no changes needed)
  ✅ .specify/templates/tasks-template.md (no changes needed)
Follow-up TODOs: None
-->

# Graphviz Live Preview Constitution

> **Project Description:**  
> This project provides syntax highlighting, snippets, and an interactive, zoom-, pan- and searchable, live preview with edge tracing for graphs in Graphviz (dot format).

## Core Principles

### I. Interactive Live Feedback
All user-facing features MUST provide immediate, visible feedback for any change to the Graphviz source, including syntax highlighting and snippet insertion. The live preview MUST support zoom, pan, search, and edge tracing, updating on every valid edit. Rendering errors MUST be surfaced clearly and non-blocking.

**Rationale:** Fast, interactive feedback and discoverability are essential for usability and learning; users must see the impact of their changes instantly and be able to explore complex graphs efficiently.

### II. Multi-Interface Parity
All core rendering, parsing, and highlighting logic MUST be accessible via both CLI and web interfaces, with consistent behavior and output. CLI must support stdin/stdout, and the web UI must support copy-paste, file upload, and all interactive features (zoom, pan, search, edge tracing).

**Rationale:** Ensures accessibility for both automation and interactive use, and prevents feature drift between interfaces.

### III. Test-Driven Development (NON-NEGOTIABLE)
All new features and bug fixes (including syntax highlighting, snippets, and preview interactivity) MUST be accompanied by automated tests. Tests MUST be written before implementation (TDD). No code is merged without passing tests for all supported platforms.

**Rationale:** Prevents regressions, ensures reliability, and enables safe refactoring.

### IV. Integration and Contract Testing
Integration tests MUST cover the full rendering and preview pipeline, including error handling, file I/O, interactive features, and cross-platform differences. Contract tests MUST be added for any public API, CLI flag, or UI feature.

**Rationale:** Ensures that the system works as a whole and that public interfaces remain stable.

### V. Observability, Simplicity, and Accessibility
All errors, warnings, and key events MUST be logged in a structured, human-readable format. The codebase MUST avoid unnecessary complexity; simple, composable modules are preferred. The web UI MUST be accessible via keyboard and screen reader. Versioning follows MAJOR.MINOR.PATCH (semver).

**Rationale:** Observability aids debugging and support; simplicity reduces maintenance burden and onboarding time; accessibility ensures inclusivity.

## Additional Constraints

- Only open-source dependencies with OSI-approved licenses are permitted.
- All user data (files, diagrams) must be processed locally; no data is sent to third-party services.
- Syntax highlighting and snippets MUST support the full Graphviz (dot) language specification.

## Development Workflow

- All changes require code review by at least one other contributor.
- Every pull request MUST pass all tests and linters before merge.
- Feature branches MUST be named as `feature/[short-description]`.
- Releases are cut from `main` after passing all checks.

## Governance

- This constitution supersedes all other project practices.
- Amendments require a pull request, approval by at least two maintainers, and a migration plan if breaking.
- All PRs and reviews MUST verify compliance with these principles.
- Constitution version MUST be incremented according to the versioning policy below.
- Compliance reviews are conducted quarterly or after any major release.

**Version**: 1.1.1 | **Ratified**: 2025-11-17 | **Last Amended**: 2025-11-17
