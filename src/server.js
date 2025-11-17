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

// Endpoint to get dot source (current buffer written by Neovim)
app.get('/dot', (req, res) => {
  const dotPath = path.join(__dirname, 'current.dot');
  fs.readFile(dotPath, 'utf8', (err, data) => {
    if (err || !data) {
      // Fallback sample graph if no current buffer is available
      res.type('text/plain').send('digraph { a -> b }');
      return;
    }
    res.type('text/plain').send(data);
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Graphviz preview server running at http://localhost:${PORT}/`);
});
