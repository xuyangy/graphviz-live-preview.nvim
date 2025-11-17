# Data Model: Graphviz Live Preview

## Entities

### Graph
- Fields:
  - id: string
  - dotSource: string
  - nodes: Node[]
  - edges: Edge[]
  - attributes: object
- Relationships:
  - Has many Nodes
  - Has many Edges

### Node
- Fields:
  - id: string
  - label: string
  - position: {x: number, y: number}
  - attributes: object
- Relationships:
  - Belongs to Graph
  - Connected to Edges

### Edge
- Fields:
  - id: string
  - source: Node
  - target: Node
  - direction: 'single' | 'upstream' | 'downstream' | 'bidirectional'
  - attributes: object
- Relationships:
  - Belongs to Graph
  - Connects two Nodes

### RenderConfig
- Fields:
  - engine: string (default: 'dot')
  - transitionDelay: number
  - transitionDuration: number
  - tracingPreference: 'single' | 'upstream' | 'downstream' | 'bidirectional'
  - otherOptions: object
- Relationships:
  - Belongs to Graph

## Validation Rules
- Node IDs must be unique within a Graph
- Edge IDs must be unique within a Graph
- dotSource must be valid Graphviz dot syntax
- transitionDelay and transitionDuration must be non-negative numbers
- tracingPreference must be one of the allowed values
