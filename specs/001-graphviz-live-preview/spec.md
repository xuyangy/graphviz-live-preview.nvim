# Feature Specification: graphviz-live-preview

**Feature Branch**: `001-graphviz-live-preview`  
**Created**: [DATE]  
**Status**: Draft  
**Input**: User description:  
> "it should work exactly as https://github.com/tintinweb/vscode-interactive-graphviz except that it's a neovim plugin instead of a vscode extension."

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Live Preview While Editing (Priority: P1)
- **Description:** As a Neovim user, I want to see a live preview of my Graphviz diagram as I edit the source code, so I can immediately visualize changes.
- **Why this priority:** Core value; enables instant feedback and rapid iteration.
- **Independent Test:** Open a .dot file, edit, and verify preview updates.
- **Acceptance Scenarios:**
  1. **Given** a valid .dot file, **When** the user edits and saves, **Then** the preview updates in the external viewer within 2 seconds.
  2. **Given** a valid .dot file, **When** the user makes a syntax error, **Then** an error message is shown in the preview.

---

### User Story 2 - Manual Preview Trigger (Priority: P2)
- **Description:** As a user, I want to manually trigger the preview update, so I can control when rendering occurs, especially for large files.
- **Why this priority:** Useful for large files or performance-sensitive workflows.
- **Independent Test:** User triggers preview via command and sees updated diagram.
- **Acceptance Scenarios:**
  1. **Given** a .dot file, **When** the user runs the preview command, **Then** the diagram updates in the external viewer.
  2. **Given** a large .dot file, **When** the user attempts auto preview, **Then** the system switches to manual mode and informs the user.

---

### User Story 3 - Customizing Preview Behavior (Priority: P3)
- **Description:** As a user, I want to configure preview settings (auto/manual, output format, file size limit), so the plugin fits my workflow.
- **Why this priority:** Enhances usability for diverse user needs.
- **Independent Test:** User changes settings and verifies preview behavior.
- **Acceptance Scenarios:**
  1. **Given** the plugin settings, **When** the user changes output format, **Then** the preview reflects the new format in the external viewer.
  2. **Given** the plugin settings, **When** the user changes the file size limit, **Then** the system applies the new threshold for switching preview modes.

---

## Edge Cases
- What happens when the Graphviz code is invalid?  
  → Error message is shown in the external viewer.
- How does the system handle very large diagrams?  
  → System switches to manual preview mode and notifies the user when file size exceeds configurable limit.
- What if the external viewer cannot be opened?  
  → System displays an error message in Neovim and provides troubleshooting steps.

---

## Requirements *(mandatory)*

### Functional Requirements
- **FR-001:** System MUST provide live preview of Graphviz diagrams in Neovim.
- **FR-002:** System MUST update preview on user action (save/edit/command).
- **FR-003:** System MUST display errors for invalid Graphviz code.
- **FR-004:** Users MUST be able to configure preview behavior (auto/manual, output format, file size limit).
- **FR-005:** System MUST support at least SVG output format.
- **FR-006:** System MUST display preview in an external viewer, following the model of markdown-preview.nvim for Neovim.
- **FR-007:** System MUST switch to manual preview mode when file size exceeds a configurable limit, and inform the user.
- **FR-008:** System MUST update preview automatically on save by default, but switch to manual trigger when file size exceeds a configurable limit.

### Key Entities
- **Graphviz Source Code:** The text representing the diagram.
- **Rendered Diagram:** The visual output (SVG, PNG, etc.).
- **Preview Window (External Viewer):** The browser or app displaying the diagram, launched from Neovim.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes
- **SC-001:** Users see updated diagram in the external viewer within 2 seconds of saving edits (for files below size limit).
- **SC-002:** 95% of valid Graphviz files render correctly in the external viewer.
- **SC-003:** Error feedback is shown for invalid code in the external viewer.
- **SC-004:** Users can toggle preview on/off and configure preview mode and file size limit easily.
- **SC-005:** User satisfaction (measured via feedback or survey) is above 80%.

---

## Assumptions
- Default output format is SVG unless user changes it.
- Preview updates automatically on save unless file size exceeds configurable limit.
- Error messages are shown in the external viewer.
- Large files trigger a switch to manual preview mode, with user notification.
- External viewer is modeled after markdown-preview.nvim for Neovim.
