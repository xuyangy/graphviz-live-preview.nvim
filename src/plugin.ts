// src/plugin.ts
import { NvimPlugin } from 'neovim';
import * as fs from 'fs';
import * as path from 'path';
import { exec } from 'child_process';

/**
 * Neovim plugin entry point
 */
module.exports = (plugin: NvimPlugin) => {
  plugin.registerCommand('GraphvizPreview', async () => {
    // Get current buffer contents (dot source)
    const dotSource = (await plugin.nvim.buffer.lines).join('\n');

    // Path to webview.html
    const htmlPath = path.join(__dirname, 'webview.html');

    // Launch the webview in the default browser
    exec(`open ${htmlPath}`); // macOS; use 'xdg-open' for Linux, 'start' for Windows

    // TODO: Set up IPC or websocket to send dotSource to the webview for live updates
    // For now, user can manually refresh the webview to see changes
  });
};
