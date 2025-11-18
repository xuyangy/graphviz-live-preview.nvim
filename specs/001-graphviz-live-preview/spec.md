# Feature Specification: Graphviz Live Preview

**Feature Branch**: `001-graphviz-live-preview`  
**Created**: 2025-11-17  
**Status**: In Progress  
**Input**: User description: "this plugin should:
Renders dot/Graphviz sources in an interactive live preview.
Updates preview as you type.
Search for nodes in the graph.
Export the graph as svg or dot.
Interactive edge tracing. Click on a node to highlight incoming and outgoing edges (ESC to unselect). The Direction of the highlighting can be changed (options: single, upstream, downstream, bidirectional)
Configurable render engine, render options & tracing preference: e.g. transitionDelay, transitionDuration."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Interactive Live Preview (Priority: P1)

As a Neovim user editing a dot/Graphviz file, I want to see an interactive live preview of my graph that updates as I type, so I can immediately visualize changes and catch errors early.

**Why this priority**: Immediate feedback is critical for usability and learning, enabling users to iterate quickly and avoid mistakes.

**Independent Test**: Can be fully tested by editing a dot file and observing real-time updates in the preview window.

**Acceptance Scenarios**:

1. **Given** a valid dot file, **When** the user edits the file, **Then** the preview updates instantly to reflect changes.
2. **Given** a syntax error, **When** the user saves or types, **Then** the preview displays a clear, non-blocking error message.

---

### User Story 2 - Search and Export (Priority: P2)

As a user viewing a large graph, I want to search for nodes and export the graph as SVG or dot, so I can quickly locate elements and share or reuse my work.

**Why this priority**: Searching and exporting are essential for working with complex graphs and integrating with other tools.

**Independent Test**: Can be tested by searching for a node and exporting the current graph to SVG/dot formats.

**Acceptance Scenarios**:

1. **Given** a graph with many nodes, **When** the user searches for a node, **Then** the matching node is highlighted in the preview.
2. **Given** a rendered graph, **When** the user selects export, **Then** the graph is saved as SVG or dot.

---

### User Story 3 - Interactive Edge Tracing (Priority: P3)

As a user exploring a graph, I want to click on a node to highlight incoming and outgoing edges, change the direction of highlighting, and unselect with ESC, so I can understand graph structure and relationships.

**Why this priority**: Edge tracing helps users analyze connectivity and flow, especially in complex graphs.

**Independent Test**: Can be tested by clicking nodes, changing direction options, and pressing ESC to unselect.

**Acceptance Scenarios**:

1. **Given** a graph, **When** the user clicks a node, **Then** incoming and outgoing edges are highlighted.
2. **Given** a highlighted node, **When** the user changes direction (single, upstream, downstream, bidirectional), **Then** the preview updates accordingly.
3. **Given** a highlighted node, **When** the user presses ESC, **Then** all highlights are cleared.

---

### Edge Cases

- What happens when the dot source is invalid or incomplete?
- How does the system handle extremely large graphs (performance, UI responsiveness)?
- What if a user searches for a node that does not exist?
- How are conflicting render/tracing options resolved?
- What if the user tries to export an empty or invalid graph?

## Clarifications

### Session 2025-11-17
- Q: What render engine should the plugin use? → A: Use what https://github.com/tintinweb/vscode-interactive-graphviz is using (d3-graphviz powered by @hpcc-js/wasm)

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST render dot/Graphviz sources in an interactive live preview within Neovim.
- **FR-002**: System MUST update the preview in real-time as the user types or saves changes.
- **FR-003**: Users MUST be able to search for nodes in the graph and highlight results.
- **FR-004**: Users MUST be able to export the current graph as SVG or dot format.
- **FR-005**: System MUST support interactive edge tracing: clicking a node highlights incoming/outgoing edges, with direction options (single, upstream, downstream, bidirectional), and ESC unselects.
- **FR-006**: System MUST provide configurable render options and tracing preferences (e.g., transitionDelay, transitionDuration) in at least one supported renderer.
- **FR-007**: System MUST display clear, non-blocking error messages for invalid dot sources.
- **FR-008**: System MUST use a browser-based Graphviz renderer backed by @hpcc-js/wasm. d3-graphviz MAY be used but is not required.

### Key Entities *(include if feature involves data)*

- **Graph**: Represents the dot/Graphviz source, including nodes, edges, and attributes.
- **Node**: Represents a graph node, with attributes (ID, label, position, etc.).
- **Edge**: Represents a connection between nodes, with direction and attributes.
- **RenderConfig**: Stores user preferences for render engine, options, and tracing behavior.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 95% of valid dot files render correctly in live preview with <1s update latency.
- **SC-002**: Users can search and highlight nodes in graphs with up to 1000 nodes in <2s.
- **SC-003**: Exported SVG/dot files match the current preview and are usable in external tools.
- **SC-004**: 90% of users successfully use edge tracing features without external documentation.
- **SC-005**: No blocking errors or crashes when handling invalid dot sources or large graphs.
