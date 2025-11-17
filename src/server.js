const express = require('express');
const path = require('path');
const fs = require('fs');
const app = express();
const PORT = process.env.PORT || 8080;

// Serve static files from src/
app.use(express.static(path.join(__dirname)));

// Serve webview.html at root
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'webview.html'));
});

// Endpoint to get dot source (for future live updates)
app.get('/dot', (req, res) => {
  // For now, just return a sample dot string
  res.type('text/plain').send('digraph { a -> b }');
});

app.listen(PORT, () => {
  console.log(`Graphviz preview server running at http://localhost:${PORT}/`);
});
