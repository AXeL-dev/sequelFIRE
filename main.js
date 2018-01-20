const electron = require('electron');
const app = electron.app;
const BrowserWindow = electron.BrowserWindow;

let mainWindow = null;
app.on('ready', () => {
  mainWindow = new BrowserWindow({
    width: 900,
    height: 500,
    'titleBarStyle': 'hidden', //ヘッダーバーを透明にし、ボタンだけ表示
    'acceptFirstMouse': true
  });
  mainWindow.loadURL('file://' + __dirname + '/index.html');

  mainWindow.on('closed', function() {
    mainWindow = null;
  });
});
