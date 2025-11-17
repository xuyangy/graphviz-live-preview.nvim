const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

// Get dot source from command line argument or stdin
let dotSource = process.argv[2];
if (!dotSource) {
  // Read from stdin if no argument
  dotSource = '';
  process.stdin.setEncoding('utf8');
  process.stdin.on('data', chunk => dotSource += chunk);
  process.stdin.on('end', () => launchPreview(dotSource));
  process.stdin.resume();
} else {
  launchPreview(dotSource);
}

function launchPreview(dotSource) {
  // Write dot source to a temp file (optional, for future use)
  const tmpDotPath = path.join(__dirname, 'tmp.dot');
  fs.writeFileSync(tmpDotPath, dotSource, 'utf8');
  // Open the webview.html in browser
  const htmlPath = path.join(__dirname, 'webview.html');
  // Use platform-specific open command
  const openCmd = process.platform === 'darwin' ? `open "${htmlPath}"` :
                  process.platform === 'win32' ? `start "" "${htmlPath}"` :
                  `xdg-open "${htmlPath}"`;
  exec(openCmd);
  console.log('Graphviz preview launched in browser.');
}
