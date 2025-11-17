// src/graphvizRenderer.ts
import { graphviz } from 'd3-graphviz';
import { initWasm } from '@hpcc-js/wasm';

/**
 * Initializes d3-graphviz with @hpcc-js/wasm and renders the given dot source to the target element.
 * @param targetElementId - The DOM element ID to render into
 * @param dotSource - The Graphviz dot source string
 * @param options - Optional render options
 */
export async function renderGraphviz(targetElementId: string, dotSource: string, options?: Record<string, any>) {
  // Ensure WASM is initialized
  await initWasm();

  // Select the target element and render
  const renderer = graphviz(`#${targetElementId}`)
    .options(options || {})
    .on('end', () => {
      // Add edge tracing interactivity
      const svg = document.querySelector(`#${targetElementId} svg`);
      if (!svg) return;
      // Remove previous listeners
      svg.querySelectorAll('.node').forEach(node => {
        node.removeEventListener('click', node._edgeTraceHandler);
      });
      // Add listeners to nodes
      svg.querySelectorAll('.node').forEach(node => {
        const handler = (event: MouseEvent) => {
          event.stopPropagation();
          const nodeId = node.querySelector('title')?.textContent;
          if (!nodeId) return;
          highlightEdges(svg, nodeId, options?.traceDirection || 'bidirectional');
        };
        node._edgeTraceHandler = handler;
        node.addEventListener('click', handler);
      });
      // ESC to clear highlights
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
          clearEdgeHighlights(svg);
        }
      });
    })
    .renderDot(dotSource);
}

function highlightEdges(svg: SVGElement, nodeId: string, direction: string) {
  // Remove previous highlights
  clearEdgeHighlights(svg);
  // Highlight edges based on direction
  svg.querySelectorAll('.edge').forEach(edge => {
    const title = edge.querySelector('title')?.textContent;
    if (!title) return;
    const [src, dst] = title.split('->').map(s => s.trim());
    let highlight = false;
    if (direction === 'bidirectional') {
      highlight = src === nodeId || dst === nodeId;
    } else if (direction === 'upstream') {
      highlight = dst === nodeId;
    } else if (direction === 'downstream') {
      highlight = src === nodeId;
    }
    if (highlight) {
      edge.classList.add('edge-highlight');
      edge.querySelector('path')?.setAttribute('stroke', '#f00');
      edge.querySelector('path')?.setAttribute('stroke-width', '3');
    }
  });
}

function clearEdgeHighlights(svg: SVGElement) {
  svg.querySelectorAll('.edge.edge-highlight').forEach(edge => {
    edge.classList.remove('edge-highlight');
    edge.querySelector('path')?.setAttribute('stroke', '#000');
    edge.querySelector('path')?.setAttribute('stroke-width', '1');
  });
}

}

/**
 * Example usage (to be called from webview context):
 *
 * await renderGraphviz('graphviz-container', 'digraph { a -> b }');
 */
