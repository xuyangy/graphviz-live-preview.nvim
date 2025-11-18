---
description: "Task list for Graphviz Live Preview Neovim Plugin"
---

# Tasks: Graphviz Live Preview

**Input**: Design documents from `/specs/001-graphviz-live-preview/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

## Phase 1: Setup (Shared Infrastructure)

- [x] T001 Create project structure in lua/, src/, tests/, and contracts/
- [ ] T002 Initialize Node.js/TypeScript plugin with Graphviz rendering backed by @hpcc-js/wasm (current MVP uses plain JS and Express)
- [x] T003 [P] Configure Jest for testing in tests/
- [x] T004 [P] Add README and quickstart.md documentation

---

## Phase 2: Foundational (Blocking Prerequisites)

- [x] T005 Setup Neovim integration in `lua/graphviz_live_preview/init.lua` to write the current buffer to a dot file and launch the preview server
- [x] T006 [P] Implement webview infrastructure for live preview in `src/webview.html` (using @hpcc-js/wasm + d3)
- [x] T007 [P] Add dot language syntax highlighting and snippets via `syntax/dot.vim` and `snippets/dot.snippets`
- [ ] T008 [P] Implement RenderConfig entity (future) for configurable render/tracing options
- [ ] T009 [P] Implement Graph, Node, Edge entities (future) if needed for advanced features
- [ ] T010 [P] Setup error handling and logging infrastructure in Node server and webview

---

## Phase 3: User Story 1 - Interactive Live Preview (Priority: P1) 🎯 MVP

**Goal**: Interactive live preview of dot/Graphviz files that updates as user types
**Independent Test**: Edit a dot file and observe real-time updates in preview

### Tests for User Story 1
- [ ] T011 [P] [US1] Contract test for /preview endpoint in tests/contract/test_preview.ts
- [ ] T012 [P] [US1] Integration test for live preview in tests/integration/test_live_preview.ts

### Implementation for User Story 1
- [x] T013 [P] [US1] Implement /dot endpoint in `src/server.js` and polling-based live preview in `src/webview.html`
- [ ] T014 [US1] Integrate richer rendering options (e.g., transitions, zoom/pan controls) into the webview
- [x] T015 [US1] Implement error display for invalid dot source in `src/webview.html` status area
- [ ] T016 [US1] Add keyboard navigation and accessibility improvements in the webview

---

## Phase 4: User Story 2 - Search and Export (Priority: P2)

**Goal**: Search for nodes and export graph as SVG or dot
**Independent Test**: Search for a node and export graph

### Tests for User Story 2
- [ ] T017 [P] [US2] Contract test for /search and /export endpoints in tests/contract/test_search_export.ts
- [ ] T018 [P] [US2] Integration test for search and export in tests/integration/test_search_export.ts

### Implementation for User Story 2
- [ ] T019 [P] [US2] Implement /search endpoint in src/lib/search.ts
- [ ] T020 [P] [US2] Implement /export endpoint in src/lib/export.ts
- [ ] T021 [US2] Integrate node search and highlight in src/lib/search.ts
- [ ] T022 [US2] Integrate export functionality in src/lib/export.ts

---

## Phase 5: User Story 3 - Interactive Edge Tracing (Priority: P3)

**Goal**: Click node to highlight edges, change direction, ESC to unselect
**Independent Test**: Click nodes, change direction, press ESC

### Tests for User Story 3
- [ ] T023 [P] [US3] Contract test for /trace endpoint in tests/contract/test_trace.ts
- [ ] T024 [P] [US3] Integration test for edge tracing in tests/integration/test_edge_tracing.ts

### Implementation for User Story 3
- [ ] T025 [P] [US3] Implement /trace endpoint in src/lib/trace.ts
- [ ] T026 [US3] Integrate edge tracing and direction options in src/lib/trace.ts (adapt from vscode-interactive-graphviz/src/features/interactiveWebview.ts)
- [ ] T027 [US3] Implement ESC unselect logic in src/lib/trace.ts

---

## Final Phase: Polish & Cross-Cutting Concerns

- [ ] T028 [P] Documentation updates in docs/
- [ ] T029 Code cleanup and refactoring
- [ ] T030 Performance optimization in src/lib/
- [ ] T031 [P] Additional unit tests in tests/unit/
- [ ] T032 Security hardening and dependency audit
- [ ] T033 Run quickstart.md validation

---

## Dependencies & Execution Order

### Phase Dependencies
- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies
- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - May integrate with US1 but should be independently testable
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - May integrate with US1/US2 but should be independently testable

### Parallel Execution Examples
- All tasks marked [P] can run in parallel (different files, no dependencies)
- All contract and integration tests for a user story can run in parallel
- Models and endpoints for different stories can be developed in parallel

## Implementation Strategy

### MVP First (User Story 1 Only)
1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery
1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story 3 → Test independently → Deploy/Demo
5. Each story adds value without breaking previous stories

### Parallel Team Strategy
With multiple developers:
1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1
   - Developer B: User Story 2
   - Developer C: User Story 3
3. Stories complete and integrate independently
